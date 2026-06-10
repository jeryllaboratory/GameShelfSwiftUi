// GameRepositoryProtocol.swift
// GameShelfCore
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import Foundation

public protocol GameRepositoryProtocol {
    func fetchGames() async throws -> [GameEntity]
    func searchGames(query: String) async throws -> [GameEntity]
    func fetchGameDetail(id: Int) async throws -> GameDetailEntity
}
