// GameRepository.swift
// GameShelfData
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import Foundation
import GameShelfCore

public struct GameRepository: GameRepositoryProtocol {
    private let remoteDataSource: GameRemoteDataSourceProtocol

    public init(remoteDataSource: GameRemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }

    public func fetchGames() async throws -> [GameEntity] {
        let response = try await remoteDataSource.fetchGames()
        return response.map { $0.toEntity() }
    }

    public func searchGames(query: String) async throws -> [GameEntity] {
        let response = try await remoteDataSource.searchGames(query: query)
        return response.map { $0.toEntity() }
    }

    public func fetchGameDetail(id: Int) async throws -> GameDetailEntity {
        let response = try await remoteDataSource.fetchGameDetail(id: id)
        return response.toEntity()
    }
}
