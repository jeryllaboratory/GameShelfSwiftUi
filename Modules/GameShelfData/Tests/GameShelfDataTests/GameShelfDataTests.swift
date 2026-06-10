// GameShelfDataTests.swift
// GameShelfData
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import GameShelfCore
@testable import GameShelfData
import XCTest

final class GameShelfDataTests: XCTestCase {

    func testGameDTOMapsToGameEntity() {
        let dto = GameDTO(
            id: 1,
            slug: "sample-game",
            name: "Sample Game",
            released: "2026-06-08",
            backgroundImage: "https://example.com/game.jpg",
            rating: 4.5,
            genres: [GenreDTO(id: 10, name: "Action", slug: "action")]
        )

        let entity = dto.toEntity()

        XCTAssertEqual(entity.id, 1)
        XCTAssertEqual(entity.name, "Sample Game")
        XCTAssertEqual(entity.genres.first?.name, "Action")
    }

    func testGameDetailDTOMapsToGameDetailEntity() {
        let dto = GameDetailDTO(
            id: 2,
            slug: "detail-game",
            name: "Detail Game",
            released: "2026-06-08",
            backgroundImage: "https://example.com/detail.jpg",
            rating: 4.8,
            metacritic: 90,
            overview: "Overview",
            genres: [GenreDTO(id: 11, name: "Adventure", slug: "adventure")]
        )

        let entity = dto.toEntity()

        XCTAssertEqual(entity.id, 2)
        XCTAssertEqual(entity.name, "Detail Game")
        XCTAssertEqual(entity.metacritic, 90)
        XCTAssertEqual(entity.overview, "Overview")
    }

    func testAboutRepositoryReturnsProfile() async throws {
        let repository = AboutRepository()
        let profile = try await repository.fetchProfile()

        XCTAssertEqual(profile.name, "Jery I D Lenas")
        XCTAssertFalse(profile.expertise.isEmpty)
    }
}
