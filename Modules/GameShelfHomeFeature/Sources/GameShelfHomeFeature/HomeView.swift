// HomeView.swift
// GameShelfHomeFeature
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import GameShelfCommon
import GameShelfCore
import SwiftUI

public struct HomeView<DetailContent: View>: View {
    @StateObject private var viewModel: HomeViewModel
    private let detailDestination: (Int) -> DetailContent

    public init(
        viewModel: HomeViewModel,
        @ViewBuilder detailDestination: @escaping (Int) -> DetailContent
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.detailDestination = detailDestination
    }

    public var body: some View {
        VStack(spacing: 0) {
            GSTopBar(
                title: "Gameshelf",
                leadingSystemImage: "line.3.horizontal",
                trailingSystemImage: nil
            )

            ScrollView {
                VStack(alignment: .leading, spacing: GSSpacing.xxl) {
                    GSSearchBar(
                        placeholder: "Search library...",
                        text: searchTextBinding
                    )

                    contentView
                }
                .padding(.horizontal, GSSpacing.screenHorizontal)
                .padding(.bottom, GSSpacing.xxl)
            }
            .refreshable {
                viewModel.loadGames()
            }
        }
        .background(GSColor.appBackground)
        .hideNavigationBarIfAvailable()
        .task {
            if case .idle = viewModel.state {
                viewModel.loadGames()
            }
        }
    }

    private var searchTextBinding: Binding<String> {
        Binding(
            get: { viewModel.searchText },
            set: { viewModel.searchText = $0 }
        )
    }

    @ViewBuilder
    private var contentView: some View {
        switch viewModel.state {
        case .idle, .loading:
            GSLoadingView(message: "Loading games...")
                .frame(minHeight: 360)
        case .content(let games):
            gameListView(games: games)
        case .empty(let message):
            GSEmptyStateView(
                systemImage: "magnifyingglass",
                title: "No Games Found",
                message: message
            )
            .frame(minHeight: 360)
        case .error(let message):
            GSErrorStateView(
                message: message,
                retryAction: viewModel.retry
            )
            .frame(minHeight: 360)
        }
    }

    private func gameListView(games: [GameEntity]) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("LATEST RELEASES")
                .font(GSTypography.overline)
                .foregroundStyle(GSColor.primaryText)
                .tracking(3)
                .padding(.bottom, GSSpacing.lg)

            LazyVStack(spacing: 0) {
                ForEach(games) { game in
                    NavigationLink {
                        detailDestination(game.id)
                    } label: {
                        HomeGameRowView(game: game)
                    }
                    .buttonStyle(.plain)

                    if game.id != games.last?.id {
                        Divider()
                            .padding(.leading, 80 + GSSpacing.xl)
                            .background(GSColor.divider)
                    }
                }
            }
        }
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
}

#Preview {
    NavigationStack {
        HomeView(
            viewModel: HomeViewModel(useCase: PreviewHomeUseCase()),
            detailDestination: { gameId in
                Text("Detail \(gameId)")
            }
        )
    }
}

private struct PreviewHomeUseCase: HomeUseCase {
    func fetchGames() async throws -> [GameEntity] {
        [
            GameEntity(
                id: 1,
                name: "Sample Game",
                released: "2026-06-08",
                backgroundImage: nil,
                rating: 4.5
            )
        ]
    }

    func searchGames(query: String) async throws -> [GameEntity] {
        try await fetchGames()
    }
}
