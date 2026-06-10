// FavoriteUseCase.swift
// GameShelfCore
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import Foundation

public protocol FavoriteUseCase {
    func fetchFavorites() async throws -> [FavoriteGameEntity]
    func deleteFavorite(id: Int) async throws
}

public struct FavoriteInteractor: FavoriteUseCase {
    private let repository: FavoriteRepositoryProtocol

    public init(repository: FavoriteRepositoryProtocol) {
        self.repository = repository
    }

    public func fetchFavorites() async throws -> [FavoriteGameEntity] {
        try await repository.fetchFavorites()
    }

    public func deleteFavorite(id: Int) async throws {
        try await repository.removeFavorite(id: id)
    }
}
