// FavoriteViewState.swift
// GameShelfFavoriteFeature
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import Foundation
import GameShelfCore

public enum FavoriteViewState: Equatable {
    case idle
    case loading
    case content([FavoriteGameEntity])
    case empty(message: String)
    case error(message: String)

    public var favorites: [FavoriteGameEntity] {
        if case .content(let favorites) = self {
            return favorites
        }
        return []
    }
}
