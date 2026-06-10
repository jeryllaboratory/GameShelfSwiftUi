// HomeViewModelTests.swift
// GameShelfHomeFeature
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import GameShelfCore
@testable import GameShelfHomeFeature
import XCTest

final class HomeViewModelTests: XCTestCase {
    @MainActor
    func testLoadGamesShowsContentState() async throws {
        let viewModel = HomeViewModel(useCase: FakeHomeUseCase())
        viewModel.loadGames()
        try await Task.sleep(nanoseconds: 100_000_000)

        XCTAssertEqual(viewModel.state.games.count, 1)
        XCTAssertEqual(viewModel.state.games.first?.name, "Sample Game")
    }
}

private struct FakeHomeUseCase: HomeUseCase {
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
