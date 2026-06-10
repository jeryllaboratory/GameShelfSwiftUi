// FavoriteViewModelTests.swift
// GameShelfFavoriteFeature
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import GameShelfCore
@testable import GameShelfFavoriteFeature
import XCTest

final class FavoriteViewModelTests: XCTestCase {
    @MainActor
    func testLoadFavoritesShowsContentState() async throws {
        let viewModel = FavoriteViewModel(useCase: FakeFavoriteUseCase())

        viewModel.loadFavorites()
        try await Task.sleep(nanoseconds: 100_000_000)

        XCTAssertEqual(viewModel.state.favorites.count, 1)
        XCTAssertEqual(viewModel.state.favorites.first?.name, "Sample Favorite")
    }

    @MainActor
    func testDeleteFavoriteShowsActionMessageAndReloadsFavorites() async throws {
        let useCase = FakeFavoriteUseCase()
        let viewModel = FavoriteViewModel(useCase: useCase)

        viewModel.deleteFavorite(id: 1)
        try await Task.sleep(nanoseconds: 100_000_000)

        XCTAssertEqual(viewModel.actionMessage, "Favorite removed.")
        XCTAssertEqual(viewModel.state.favorites.count, 1)
    }
}

private struct FakeFavoriteUseCase: FavoriteUseCase {
    func fetchFavorites() async throws -> [FavoriteGameEntity] {
        [
            FavoriteGameEntity(
                id: 1,
                name: "Sample Favorite",
                released: "2026-06-08",
                rating: 4.7,
                backgroundImage: nil
            )
        ]
    }

    func deleteFavorite(id: Int) async throws {}
}
