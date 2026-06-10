// HomeUseCase.swift
// GameShelfCore
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import Foundation

public protocol HomeUseCase {
    func fetchGames() async throws -> [GameEntity]
    func searchGames(query: String) async throws -> [GameEntity]
}

public struct HomeInteractor: HomeUseCase {
    private let repository: GameRepositoryProtocol

    public init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }

    public func fetchGames() async throws -> [GameEntity] {
        try await repository.fetchGames()
    }

    public func searchGames(query: String) async throws -> [GameEntity] {
        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmedQuery.isEmpty else {
            return try await fetchGames()
        }

        return try await repository.searchGames(query: trimmedQuery)
    }
}
