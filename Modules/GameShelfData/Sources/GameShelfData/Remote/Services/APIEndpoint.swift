// APIEndpoint.swift
// GameShelfData
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import Foundation

public enum APIEndpoint {
    private static let baseURL = "https://rawg-mirror.vercel.app/api"

    case games
    case searchGames(query: String)
    case gameDetail(id: Int)

    public var url: URL? {
        switch self {
        case .games:
            return URL(string: "\(Self.baseURL)/games")
        case .searchGames(let query):
            var components = URLComponents(string: "\(Self.baseURL)/games")
            components?.queryItems = [
                URLQueryItem(name: "search", value: query)
            ]
            return components?.url
        case .gameDetail(let id):
            return URL(string: "\(Self.baseURL)/games/\(id)")
        }
    }
}
