// DetailUseCase.swift
// GameShelfCore
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import Foundation

public protocol DetailUseCase {
    func fetchGameDetail(id: Int) async throws -> GameDetailEntity
    func isFavorite(id: Int) async throws -> Bool
    func toggleFavorite(game: GameDetailEntity) async throws -> Bool
}

public struct DetailInteractor: DetailUseCase {
    private let gameRepository: GameRepositoryProtocol
    private let favoriteRepository: FavoriteRepositoryProtocol

    public init(
        gameRepository: GameRepositoryProtocol,
        favoriteRepository: FavoriteRepositoryProtocol
    ) {
        self.gameRepository = gameRepository
        self.favoriteRepository = favoriteRepository
    }

    public func fetchGameDetail(id: Int) async throws -> GameDetailEntity {
        try await gameRepository.fetchGameDetail(id: id)
    }

    public func isFavorite(id: Int) async throws -> Bool {
        try await favoriteRepository.isFavorite(id: id)
    }

    public func toggleFavorite(game: GameDetailEntity) async throws -> Bool {
        try await favoriteRepository.toggleFavorite(game)
    }
}
