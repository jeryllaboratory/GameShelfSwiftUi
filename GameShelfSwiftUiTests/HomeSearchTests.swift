// HomeSearchTests.swift
// GameShelfSwiftUi
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import Foundation
import GameShelfCore
import GameShelfHomeFeature
import Testing
import XCTest

struct HomeSearchTests {

    @MainActor
    @Test func emptySearchInputDoesNotTriggerRequest() async throws {
        let useCase = CountingHomeUseCase()
        let viewModel = GameShelfHomeFeature.HomeViewModel(useCase: useCase)

        viewModel.searchText = ""
        await waitUntil(timeout: 0.7) {
            useCase.fetchCount == 0 && useCase.searchCount == 0
        }

        #expect(useCase.fetchCount == 0)
        #expect(useCase.searchCount == 0)
    }

    @MainActor
    @Test func whitespaceSearchInputDoesNotTriggerRequest() async throws {
        let useCase = CountingHomeUseCase()
        let viewModel = GameShelfHomeFeature.HomeViewModel(useCase: useCase)

        viewModel.searchText = "   "
        await waitUntil(timeout: 0.7) {
            useCase.fetchCount == 0 && useCase.searchCount == 0
        }

        #expect(useCase.fetchCount == 0)
        #expect(useCase.searchCount == 0)
    }

    @MainActor
    @Test func nonEmptySearchInputTriggersSearchRequest() async throws {
        let useCase = CountingHomeUseCase()
        let viewModel = GameShelfHomeFeature.HomeViewModel(useCase: useCase)

        viewModel.searchText = "zelda"
        await waitUntil(timeout: 1.0) {
            useCase.searchCount == 1 && useCase.lastSearchQuery == "zelda"
        }

        #expect(useCase.fetchCount == 0)
        #expect(useCase.searchCount == 1)
        #expect(useCase.lastSearchQuery == "zelda")
    }

    @MainActor
    @Test func clearingSearchAfterActiveSearchReloadsDefaultGames() async throws {
        let useCase = CountingHomeUseCase()
        let viewModel = GameShelfHomeFeature.HomeViewModel(useCase: useCase)

        viewModel.searchText = "zelda"
        await waitUntil(timeout: 1.0) {
            useCase.searchCount == 1
        }

        viewModel.searchText = ""
        await waitUntil(timeout: 1.0) {
            useCase.fetchCount == 1
        }

        #expect(useCase.searchCount == 1)
        #expect(useCase.fetchCount == 1)
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

private final class CountingHomeUseCase: GameShelfCore.HomeUseCase {
    private(set) var fetchCount = 0
    private(set) var searchCount = 0
    private(set) var lastSearchQuery: String?

    func fetchGames() async throws -> [GameShelfCore.GameEntity] {
        fetchCount += 1
        return [
            GameShelfCore.GameEntity(
                id: 1,
                name: "Default Game",
                released: "2026-06-08",
                backgroundImage: nil,
                rating: 4.5
            )
        ]
    }

    func searchGames(query: String) async throws -> [GameShelfCore.GameEntity] {
        searchCount += 1
        lastSearchQuery = query
        return [
            GameShelfCore.GameEntity(
                id: 2,
                name: "Search Result",
                released: "2026-06-08",
                backgroundImage: nil,
                rating: 4.8
            )
        ]
    }
}
