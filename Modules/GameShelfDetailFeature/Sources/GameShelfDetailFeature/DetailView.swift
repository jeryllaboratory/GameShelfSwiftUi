// DetailView.swift
// GameShelfDetailFeature
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import GameShelfCommon
import GameShelfCore
import SwiftUI

public struct DetailView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: DetailViewModel
    private let favoriteRefreshToken: UUID

    public init(
        viewModel: DetailViewModel,
        favoriteRefreshToken: UUID = UUID()
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.favoriteRefreshToken = favoriteRefreshToken
    }

    public var body: some View {
        GeometryReader { proxy in
            let screenWidth = proxy.size.width
            let horizontalPadding = GSSpacing.screenHorizontal
            let contentWidth = max(0, screenWidth - (horizontalPadding * 2))

            VStack(spacing: 0) {
                GSTopBar(
                    title: "Gameshelf",
                    leadingSystemImage: "chevron.left",
                    trailingSystemImage: viewModel.state.game == nil ? nil : favoriteSystemImage,
                    leadingAction: { dismiss() },
                    trailingAction: viewModel.toggleFavorite
                )
                .frame(width: screenWidth)

                ScrollView(.vertical, showsIndicators: false) {
                    contentView(contentWidth: contentWidth)
                        .frame(width: contentWidth, alignment: .leading)
                        .padding(.horizontal, horizontalPadding)
                        .padding(.top, GSSpacing.sm)
                        .padding(.bottom, GSSpacing.xxl)
                }
                .frame(width: screenWidth)
                .refreshable {
                    viewModel.loadDetail()
                }
            }
            .frame(width: screenWidth, height: proxy.size.height)
            .background(GSColor.appBackground)
        }
        .hideNavigationBarIfAvailable()
        .task {
            if case .idle = viewModel.state {
                viewModel.loadDetail()
            }
        }
        .onChange(of: favoriteRefreshToken) { _, _ in
            viewModel.refreshFavoriteStatus()
        }
        .gsSnackbar(
            message: viewModel.actionMessage,
            onDismiss: viewModel.clearActionMessage
        )
    }

    private var favoriteSystemImage: String {
        viewModel.state.isFavorite ? "heart.fill" : "heart"
    }

    @ViewBuilder
    private func contentView(contentWidth: CGFloat) -> some View {
        switch viewModel.state {
        case .idle, .loading:
            GSLoadingView(message: "Loading detail...")
                .frame(width: contentWidth)
                .frame(minHeight: 480)
        case .content(let game, _):
            detailContent(game: game, contentWidth: contentWidth)
        case .error(let message):
            GSErrorStateView(
                message: message,
                retryAction: viewModel.retry
            )
            .frame(width: contentWidth)
            .frame(minHeight: 480)
        }
    }

    private func detailContent(game: GameDetailEntity, contentWidth: CGFloat) -> some View {
        VStack(alignment: .leading, spacing: GSSpacing.xl) {
            DetailHeaderView(game: game, contentWidth: contentWidth)
            DetailInfoGridView(game: game)
                .frame(width: contentWidth)

            VStack(alignment: .leading, spacing: GSSpacing.md) {
                Text("OVERVIEW")
                    .font(GSTypography.overline)
                    .foregroundStyle(GSColor.secondaryText)
                    .tracking(2)
                    .frame(width: contentWidth, alignment: .leading)

                Text(game.overview ?? "No overview available.")
                    .font(GSTypography.body)
                    .foregroundStyle(GSColor.primaryText)
                    .lineSpacing(8)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(width: contentWidth, alignment: .leading)
            }
            .frame(width: contentWidth, alignment: .leading)
        }
        .frame(width: contentWidth, alignment: .leading)
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
