// GameShelfCoreTests.swift
// GameShelfCore
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

@testable import GameShelfCore
import XCTest

final class GameShelfCoreTests: XCTestCase {

    func testGameEntityStoresBasicGameInformation() {
        let entity = GameEntity(
            id: 100,
            slug: "sample-game",
            name: "Sample Game",
            released: "2026-06-08",
            backgroundImage: "https://example.com/game.jpg",
            rating: 4.5,
            genres: [GenreEntity(id: 1, name: "Action", slug: "action")]
        )

        XCTAssertEqual(entity.id, 100)
        XCTAssertEqual(entity.name, "Sample Game")
        XCTAssertEqual(entity.genres.first?.name, "Action")
    }

    func testFavoriteGameEntityStoresFavoriteInformation() {
        let createdAt = Date(timeIntervalSince1970: 0)
        let entity = FavoriteGameEntity(
            id: 200,
            name: "Favorite Sample",
            released: "2026-06-08",
            rating: 4.6,
            backgroundImage: "https://example.com/favorite.jpg",
            createdAt: createdAt
        )

        XCTAssertEqual(entity.id, 200)
        XCTAssertEqual(entity.name, "Favorite Sample")
        XCTAssertEqual(entity.createdAt, createdAt)
    }

    func testHomeInteractorTrimsSearchQueryBeforeCallingRepository() async throws {
        let repository = FakeGameRepository()
        let interactor = HomeInteractor(repository: repository)

        let games = try await interactor.searchGames(query: "  sample  ")

        XCTAssertEqual(games.count, 1)
        XCTAssertEqual(repository.lastSearchQuery, "sample")
    }
}

private final class FakeGameRepository: GameRepositoryProtocol {
    private(set) var lastSearchQuery: String?

    func fetchGames() async throws -> [GameEntity] {
        [GameEntity(id: 1, name: "Default Game")]
    }

    func searchGames(query: String) async throws -> [GameEntity] {
        lastSearchQuery = query
        return [GameEntity(id: 2, name: "Sample Game")]
    }

    func fetchGameDetail(id: Int) async throws -> GameDetailEntity {
        GameDetailEntity(id: id, name: "Sample Detail")
    }
}
