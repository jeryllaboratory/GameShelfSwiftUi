// GameShelfSwiftUiTests.swift
// GameShelfSwiftUi
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import Foundation
import GameShelfAboutFeature
import GameShelfCommon
import GameShelfCore
import GameShelfDetailFeature
import GameShelfFavoriteFeature
import GameShelfHomeFeature
import Testing
import XCTest

struct GameShelfSwiftUiTests {

    @Test func toDisplayDateWithValidInputReturnsFormattedUppercaseDate() async throws {
        #expect("2013-09-17".toDisplayDate() == "SEP 17 2013")
    }

    @Test func toDisplayDateWithInvalidInputReturnsNil() async throws {
        #expect("invalid-date".toDisplayDate() == nil)
    }

    @Test func gameEntityStoresBasicGameInformation() async throws {
        let entity = GameShelfCore.GameEntity(
            id: 100,
            slug: "sample-game",
            name: "Sample Game",
            released: "2026-06-08",
            backgroundImage: "https://example.com/game.jpg",
            rating: 4.5,
            genres: [GameShelfCore.GenreEntity(id: 1, name: "Action", slug: "action")]
        )

        #expect(entity.id == 100)
        #expect(entity.name == "Sample Game")
        #expect(entity.genres.first?.name == "Action")
    }

    @Test func favoriteGameEntityStoresFavoriteInformation() async throws {
        let createdAt = Date(timeIntervalSince1970: 0)
        let entity = GameShelfCore.FavoriteGameEntity(
            id: 200,
            name: "Favorite Sample",
            released: "2026-06-08",
            rating: 4.6,
            backgroundImage: "https://example.com/favorite.jpg",
            createdAt: createdAt
        )

        #expect(entity.id == 200)
        #expect(entity.name == "Favorite Sample")
        #expect(entity.createdAt == createdAt)
    }

    @MainActor
    @Test func homeViewModelLoadGamesShowsContentState() async throws {
        let viewModel = GameShelfHomeFeature.HomeViewModel(useCase: FakeHomeUseCase())
        viewModel.loadGames()
        await waitUntil {
            viewModel.state.games.count == 1
        }

        #expect(viewModel.state.games.count == 1)
        #expect(viewModel.state.games.first?.name == "Sample Game")
    }

    @MainActor
    @Test func detailViewModelLoadDetailShowsContentState() async throws {
        let viewModel = GameShelfDetailFeature.DetailViewModel(gameId: 1, useCase: FakeDetailUseCase())
        viewModel.loadDetail()
        await waitUntil {
            viewModel.state.game != nil
        }

        #expect(viewModel.state.game?.id == 1)
        #expect(viewModel.state.game?.name == "Sample Detail")
        #expect(viewModel.state.isFavorite == false)
    }

    @MainActor
    @Test func detailViewModelToggleFavoriteUpdatesFavoriteState() async throws {
        let viewModel = GameShelfDetailFeature.DetailViewModel(gameId: 1, useCase: FakeDetailUseCase())
        viewModel.loadDetail()
        await waitUntil {
            viewModel.state.game != nil
        }

        viewModel.toggleFavorite()
        await waitUntil {
            viewModel.state.isFavorite && viewModel.actionMessage != nil
        }

        #expect(viewModel.state.isFavorite == true)
        #expect(viewModel.actionMessage == "Added to favorites")
    }

    @MainActor
    @Test func detailViewModelToggleFavoriteNotifiesFavoriteRefresh() async throws {
        var didNotifyFavoriteChanged = false
        let viewModel = GameShelfDetailFeature.DetailViewModel(
            gameId: 1,
            useCase: FakeDetailUseCase(),
            onFavoriteChanged: {
                didNotifyFavoriteChanged = true
            }
        )

        viewModel.loadDetail()
        await waitUntil {
            viewModel.state.game != nil
        }

        viewModel.toggleFavorite()
        await waitUntil {
            didNotifyFavoriteChanged && viewModel.actionMessage != nil
        }

        #expect(didNotifyFavoriteChanged)
    }

    @MainActor
    @Test func favoriteViewModelLoadFavoritesShowsContentState() async throws {
        let viewModel = GameShelfFavoriteFeature.FavoriteViewModel(useCase: FakeFavoriteUseCase())
        viewModel.loadFavorites()
        await waitUntil {
            viewModel.state.favorites.count == 1
        }

        #expect(viewModel.state.favorites.count == 1)
        #expect(viewModel.state.favorites.first?.name == "Sample Favorite")
    }

    @MainActor
    @Test func favoriteViewModelDeleteFavoriteReloadsFavorites() async throws {
        let useCase = FakeFavoriteUseCase()
        let viewModel = GameShelfFavoriteFeature.FavoriteViewModel(useCase: useCase)
        viewModel.loadFavorites()
        await waitUntil {
            viewModel.state.favorites.count == 1
        }

        viewModel.deleteFavorite(id: 10)
        await waitUntil {
            viewModel.state.favorites.isEmpty && viewModel.actionMessage != nil
        }

        #expect(viewModel.state.favorites.isEmpty)
        #expect(viewModel.actionMessage == "Favorite removed.")
    }
}

@MainActor
private func waitUntil(
    timeout: TimeInterval = 1.0,
    condition: @escaping () -> Bool
) async {
    let deadline = Date().addingTimeInterval(timeout)

    while Date() < deadline {
        if condition() {
            return
        }

        try? await Task.sleep(nanoseconds: 50_000_000)
    }
}

private struct FakeHomeUseCase: GameShelfCore.HomeUseCase {
    func fetchGames() async throws -> [GameShelfCore.GameEntity] {
        [
            GameShelfCore.GameEntity(
                id: 1,
                name: "Sample Game",
                released: "2026-06-08",
                backgroundImage: nil,
                rating: 4.5
            )
        ]
    }

    func searchGames(query: String) async throws -> [GameShelfCore.GameEntity] {
        try await fetchGames()
    }
}

private final class FakeDetailUseCase: GameShelfCore.DetailUseCase {
    private var favoriteState = false

    func fetchGameDetail(id: Int) async throws -> GameShelfCore.GameDetailEntity {
        GameShelfCore.GameDetailEntity(
            id: id,
            name: "Sample Detail",
            released: "2026-06-08",
            rating: 4.5,
            metacritic: 90,
            overview: "Sample overview",
            genres: [GameShelfCore.GenreEntity(id: 1, name: "Action")]
        )
    }

    func isFavorite(id: Int) async throws -> Bool {
        favoriteState
    }

    func toggleFavorite(game: GameShelfCore.GameDetailEntity) async throws -> Bool {
        favoriteState.toggle()
        return favoriteState
    }
}

@MainActor
private final class FakeFavoriteUseCase: GameShelfCore.FavoriteUseCase {
    private var favorites = [
        GameShelfCore.FavoriteGameEntity(
            id: 10,
            name: "Sample Favorite",
            released: "2026-06-08",
            rating: 4.6,
            backgroundImage: nil
        )
    ]

    func fetchFavorites() async throws -> [GameShelfCore.FavoriteGameEntity] {
        favorites
    }

    func deleteFavorite(id: Int) async throws {
        favorites.removeAll { $0.id == id }
    }
}
