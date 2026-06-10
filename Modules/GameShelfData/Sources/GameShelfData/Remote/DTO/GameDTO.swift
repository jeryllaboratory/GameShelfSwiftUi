// GameDTO.swift
// GameShelfData
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import Foundation
import GameShelfCore

public struct GamesResponseDTO: Decodable {
    public let results: [GameDTO]

    public init(results: [GameDTO]) {
        self.results = results
    }
}

public struct GameDTO: Decodable {
    public let id: Int?
    public let slug: String?
    public let name: String?
    public let released: String?
    public let backgroundImage: String?
    public let rating: Double?
    public let genres: [GenreDTO]?

    enum CodingKeys: String, CodingKey {
        case id
        case slug
        case name
        case released
        case backgroundImage = "background_image"
        case rating
        case genres
    }

    public init(
        id: Int?,
        slug: String?,
        name: String?,
        released: String?,
        backgroundImage: String?,
        rating: Double?,
        genres: [GenreDTO]?
    ) {
        self.id = id
        self.slug = slug
        self.name = name
        self.released = released
        self.backgroundImage = backgroundImage
        self.rating = rating
        self.genres = genres
    }

    public func toEntity() -> GameEntity {
        GameEntity(
            id: id ?? 0,
            slug: slug,
            name: name ?? "Unknown Game",
            released: released,
            backgroundImage: backgroundImage,
            rating: rating ?? 0,
            genres: genres?.map { $0.toEntity() } ?? []
        )
    }
}

public struct GenreDTO: Decodable {
    public let id: Int?
    public let name: String?
    public let slug: String?

    public init(id: Int?, name: String?, slug: String?) {
        self.id = id
        self.name = name
        self.slug = slug
    }

    public func toEntity() -> GenreEntity {
        GenreEntity(
            id: id ?? 0,
            name: name ?? "Unknown Genre",
            slug: slug
        )
    }
}
