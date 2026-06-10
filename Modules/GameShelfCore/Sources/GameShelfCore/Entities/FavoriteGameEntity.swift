// FavoriteGameEntity.swift
// GameShelfCore
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import Foundation

public struct FavoriteGameEntity: Equatable, Identifiable {
    public let id: Int
    public let name: String
    public let released: String?
    public let rating: Double
    public let backgroundImage: String?
    public let createdAt: Date

    public init(
        id: Int,
        name: String,
        released: String? = nil,
        rating: Double = 0,
        backgroundImage: String? = nil,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.name = name
        self.released = released
        self.rating = rating
        self.backgroundImage = backgroundImage
        self.createdAt = createdAt
    }
}
