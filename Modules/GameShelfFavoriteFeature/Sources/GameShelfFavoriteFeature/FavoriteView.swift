// FavoriteView.swift
// GameShelfFavoriteFeature
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import GameShelfCommon
import GameShelfCore
import SwiftUI

public struct FavoriteView<DetailContent: View>: View {
    @StateObject private var viewModel: FavoriteViewModel
    private let refreshToken: UUID
    private let detailDestination: (Int) -> DetailContent
    private let onRefreshFavorites: () -> Void

    public init(
        viewModel: FavoriteViewModel,
        refreshToken: UUID,
        onRefreshFavorites: @escaping () -> Void = {},
        @ViewBuilder detailDestination: @escaping (Int) -> DetailContent
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.refreshToken = refreshToken
        self.onRefreshFavorites = onRefreshFavorites
        self.detailDestination = detailDestination
    }

    public var body: some View {
        VStack(spacing: 0) {
            GSTopBar(title: "Favorite")
            Divider().background(GSColor.divider)
            contentView
        }
        .background(GSColor.appBackground)
        .hideNavigationBarIfAvailable()
        .task {
            viewModel.loadFavorites()
        }
        .onChange(of: refreshToken) { _, _ in
            viewModel.loadFavorites()
        }
        .gsSnackbar(
            message: viewModel.actionMessage,
            onDismiss: viewModel.clearActionMessage
        )
    }

    @ViewBuilder
    private var contentView: some View {
        switch viewModel.state {
        case .idle, .loading:
            GSLoadingView(message: "Loading favorites...")
        case .content(let favorites):
            favoriteListView(favorites: favorites)
        case .empty(let message):
            GSEmptyStateView(
                systemImage: "heart.slash",
                title: "No favorite games yet",
                message: message
            )
        case .error(let message):
            GSErrorStateView(
                message: message,
                retryAction: viewModel.retry
            )
        }
    }

    private func favoriteListView(favorites: [FavoriteGameEntity]) -> some View {
        List {
            ForEach(favorites) { favorite in
                NavigationLink {
                    detailDestination(favorite.id)
                } label: {
                    FavoriteGameRowView(favorite: favorite)
                }
                .buttonStyle(.plain)
                .listRowInsets(
                    EdgeInsets(
                        top: 0,
                        leading: GSSpacing.screenHorizontal,
                        bottom: 0,
                        trailing: GSSpacing.screenHorizontal
                    )
                )
                .listRowSeparatorTint(GSColor.divider)
                .listRowBackground(GSColor.appBackground)
            }
            .onDelete(perform: deleteFavorites)
        }
        .listStyle(.plain)
        .scrollContentBackgroundIfAvailable(.hidden)
        .padding(.top, GSSpacing.lg)
        .refreshable {
            viewModel.loadFavorites()
        }
    }

    private func deleteFavorites(at offsets: IndexSet) {
        viewModel.deleteFavorite(at: offsets)
        onRefreshFavorites()
    }
}

private extension View {
    @ViewBuilder
    func hideNavigationBarIfAvailable() -> some View {
        #if os(iOS)
        self.toolbar(.hidden, for: .navigationBar)
        #else
        self
        #endif
    }

    @ViewBuilder
    func scrollContentBackgroundIfAvailable(_ visibility: Visibility) -> some View {
        #if os(iOS)
        self.scrollContentBackground(visibility)
        #else
        self
        #endif
    }
}

#Preview {
    NavigationStack {
        FavoriteView(
            viewModel: FavoriteViewModel(useCase: PreviewFavoriteUseCase()),
            refreshToken: UUID(),
            detailDestination: { gameId in
                Text("Detail \(gameId)")
            }
        )
    }
}

private struct PreviewFavoriteUseCase: FavoriteUseCase {
    func fetchFavorites() async throws -> [FavoriteGameEntity] {
        [
            FavoriteGameEntity(
                id: 1,
                name: "Sample Favorite Game",
                released: "2026-06-08",
                rating: 4.6,
                backgroundImage: nil
            )
        ]
    }

    func deleteFavorite(id: Int) async throws {}
}
