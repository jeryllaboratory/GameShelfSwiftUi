// GameRemoteDataSource.swift
// GameShelfData
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import Foundation

public protocol GameRemoteDataSourceProtocol {
    func fetchGames() async throws -> [GameDTO]
    func searchGames(query: String) async throws -> [GameDTO]
    func fetchGameDetail(id: Int) async throws -> GameDetailDTO
}

public struct GameRemoteDataSource: GameRemoteDataSourceProtocol {
    private let networkService: NetworkServiceProtocol

    public init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    public func fetchGames() async throws -> [GameDTO] {
        let response: GamesResponseDTO = try await networkService.request(APIEndpoint.games.url)
        return response.results
    }

    public func searchGames(query: String) async throws -> [GameDTO] {
        do {
            let response: GamesResponseDTO = try await networkService.request(APIEndpoint.searchGames(query: query).url)
            return response.results
        } catch DataError.notFound {
            return []
        } catch DataError.emptyData {
            return []
        } catch DataError.invalidResponse {
            return []
        }
    }

    public func fetchGameDetail(id: Int) async throws -> GameDetailDTO {
        try await networkService.request(APIEndpoint.gameDetail(id: id).url)
    }
}
