// FavoriteRepository.swift
// GameShelfData
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import Foundation
import GameShelfCore

@MainActor
public struct FavoriteRepository: FavoriteRepositoryProtocol {
    private let localDataSource: FavoriteLocalDataSourceProtocol

    public init(localDataSource: FavoriteLocalDataSourceProtocol) {
        self.localDataSource = localDataSource
    }

    public func fetchFavorites() async throws -> [FavoriteGameEntity] {
        try localDataSource.fetchFavorites().map { $0.toEntity() }
    }

    public func isFavorite(id: Int) async throws -> Bool {
        try localDataSource.isFavorite(id: id)
    }

    public func addFavorite(_ game: GameDetailEntity) async throws {
        try localDataSource.saveFavorite(game)
    }

    public func removeFavorite(id: Int) async throws {
        try localDataSource.deleteFavorite(id: id)
    }

    public func toggleFavorite(_ game: GameDetailEntity) async throws -> Bool {
        if try localDataSource.isFavorite(id: game.id) {
            try localDataSource.deleteFavorite(id: game.id)
            return false
        }

        try localDataSource.saveFavorite(game)
        return true
    }
}
