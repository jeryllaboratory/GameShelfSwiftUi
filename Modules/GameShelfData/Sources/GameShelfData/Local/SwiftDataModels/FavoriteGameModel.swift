// FavoriteGameModel.swift
// GameShelfData
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import Foundation
import GameShelfCore
import SwiftData

@Model
public final class FavoriteGameModel {
    @Attribute(.unique) public var id: Int
    public var name: String
    public var released: String?
    public var rating: Double
    public var backgroundImage: String?
    public var createdAt: Date

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

    public convenience init(game: GameDetailEntity) {
        self.init(
            id: game.id,
            name: game.name,
            released: game.released,
            rating: game.rating,
            backgroundImage: game.backgroundImage,
            createdAt: Date()
        )
    }

    public func toEntity() -> FavoriteGameEntity {
        FavoriteGameEntity(
            id: id,
            name: name,
            released: released,
            rating: rating,
            backgroundImage: backgroundImage,
            createdAt: createdAt
        )
    }

    public func update(from game: GameDetailEntity) {
        name = game.name
        released = game.released
        rating = game.rating
        backgroundImage = game.backgroundImage
    }
}
