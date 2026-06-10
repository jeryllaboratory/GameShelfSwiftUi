// DetailViewModel.swift
// GameShelfDetailFeature
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import Foundation
import GameShelfCore

@MainActor
public final class DetailViewModel: ObservableObject {
    @Published public private(set) var state: DetailViewState = .idle
    @Published public var actionMessage: String?

    private let gameId: Int
    private let useCase: DetailUseCase
    private let onFavoriteChanged: () -> Void

    public init(
        gameId: Int,
        useCase: DetailUseCase,
        onFavoriteChanged: @escaping () -> Void = {}
    ) {
        self.gameId = gameId
        self.useCase = useCase
        self.onFavoriteChanged = onFavoriteChanged
    }

    public func loadDetail() {
        Task {
            await fetchDetail()
        }
    }

    public func refreshFavoriteStatus() {
        guard case .content(let game, _) = state else { return }

        Task {
            do {
                let isFavorite = try await useCase.isFavorite(id: game.id)
                state = .content(game: game, isFavorite: isFavorite)
            } catch {
                actionMessage = error.localizedDescription
            }
        }
    }

    public func retry() {
        loadDetail()
    }

    public func toggleFavorite() {
        guard case .content(let game, _) = state else { return }

        Task {
            do {
                let isFavorite = try await useCase.toggleFavorite(game: game)
                state = .content(game: game, isFavorite: isFavorite)
                actionMessage = isFavorite ? "Added to favorites" : "Removed from favorites"
                onFavoriteChanged()
            } catch {
                actionMessage = error.localizedDescription
            }
        }
    }

    public func clearActionMessage() {
        actionMessage = nil
    }

    private func fetchDetail() async {
        state = .loading

        do {
            let game = try await useCase.fetchGameDetail(id: gameId)
            let isFavorite = try await useCase.isFavorite(id: game.id)
            state = .content(game: game, isFavorite: isFavorite)
        } catch {
            state = .error(message: error.localizedDescription)
        }
    }
}
