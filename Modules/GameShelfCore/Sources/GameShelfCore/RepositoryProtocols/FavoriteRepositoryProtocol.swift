// FavoriteRepositoryProtocol.swift
// GameShelfCore
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import Foundation

public protocol FavoriteRepositoryProtocol {
    func fetchFavorites() async throws -> [FavoriteGameEntity]
    func isFavorite(id: Int) async throws -> Bool
    func addFavorite(_ game: GameDetailEntity) async throws
    func removeFavorite(id: Int) async throws
    func toggleFavorite(_ game: GameDetailEntity) async throws -> Bool
}
