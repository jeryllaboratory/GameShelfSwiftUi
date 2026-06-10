// DetailViewModelTests.swift
// GameShelfDetailFeature
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import GameShelfCore
@testable import GameShelfDetailFeature
import XCTest

final class DetailViewModelTests: XCTestCase {
    @MainActor
    func testLoadDetailShowsContentState() async throws {
        let viewModel = DetailViewModel(
            gameId: 1,
            useCase: FakeDetailUseCase()
        )

        viewModel.loadDetail()
        try await Task.sleep(nanoseconds: 100_000_000)

        XCTAssertEqual(viewModel.state.game?.id, 1)
        XCTAssertEqual(viewModel.state.game?.name, "Sample Detail Game")
        XCTAssertFalse(viewModel.state.isFavorite)
    }

    @MainActor
    func testToggleFavoriteUpdatesStateAndCallback() async throws {
        var callbackCount = 0
        let viewModel = DetailViewModel(
            gameId: 1,
            useCase: FakeDetailUseCase(),
            onFavoriteChanged: { callbackCount += 1 }
        )

        viewModel.loadDetail()
        try await Task.sleep(nanoseconds: 100_000_000)
        viewModel.toggleFavorite()
        try await Task.sleep(nanoseconds: 100_000_000)

        XCTAssertTrue(viewModel.state.isFavorite)
        XCTAssertEqual(viewModel.actionMessage, "Added to favorites")
        XCTAssertEqual(callbackCount, 1)
    }
}

private struct FakeDetailUseCase: DetailUseCase {
    private let detail = GameDetailEntity(
        id: 1,
        name: "Sample Detail Game",
        released: "2026-06-08",
        backgroundImage: nil,
        rating: 4.5,
        metacritic: 90,
        overview: "Sample overview",
        genres: [GenreEntity(id: 1, name: "Action")]
    )

    func fetchGameDetail(id: Int) async throws -> GameDetailEntity {
        detail
    }

    func isFavorite(id: Int) async throws -> Bool {
        false
    }

    func toggleFavorite(game: GameDetailEntity) async throws -> Bool {
        true
    }
}
