// GameDetailDTO.swift
// GameShelfData
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import Foundation
import GameShelfCore

public struct GameDetailDTO: Decodable {
    public let id: Int?
    public let slug: String?
    public let name: String?
    public let released: String?
    public let backgroundImage: String?
    public let rating: Double?
    public let metacritic: Int?
    public let overview: String?
    public let genres: [GenreDTO]?

    enum CodingKeys: String, CodingKey {
        case id
        case slug
        case name
        case released
        case backgroundImage = "background_image"
        case rating
        case metacritic
        case overview = "description_raw"
        case genres
    }

    public init(
        id: Int?,
        slug: String?,
        name: String?,
        released: String?,
        backgroundImage: String?,
        rating: Double?,
        metacritic: Int?,
        overview: String?,
        genres: [GenreDTO]?
    ) {
        self.id = id
        self.slug = slug
        self.name = name
        self.released = released
        self.backgroundImage = backgroundImage
        self.rating = rating
        self.metacritic = metacritic
        self.overview = overview
        self.genres = genres
    }

    public func toEntity() -> GameDetailEntity {
        GameDetailEntity(
            id: id ?? 0,
            slug: slug,
            name: name ?? "Unknown Game",
            released: released,
            backgroundImage: backgroundImage,
            rating: rating ?? 0,
            metacritic: metacritic,
            overview: overview,
            genres: genres?.map { $0.toEntity() } ?? []
        )
    }
}
