// GameEntity.swift
// GameShelfCore
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import Foundation

public struct GameEntity: Equatable, Identifiable {
    public let id: Int
    public let slug: String?
    public let name: String
    public let released: String?
    public let backgroundImage: String?
    public let rating: Double
    public let genres: [GenreEntity]

    public init(
        id: Int,
        slug: String? = nil,
        name: String,
        released: String? = nil,
        backgroundImage: String? = nil,
        rating: Double = 0,
        genres: [GenreEntity] = []
    ) {
        self.id = id
        self.slug = slug
        self.name = name
        self.released = released
        self.backgroundImage = backgroundImage
        self.rating = rating
        self.genres = genres
    }
}
