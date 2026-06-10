// DetailViewState.swift
// GameShelfDetailFeature
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import Foundation
import GameShelfCore

public enum DetailViewState: Equatable {
    case idle
    case loading
    case content(game: GameDetailEntity, isFavorite: Bool)
    case error(message: String)

    public var game: GameDetailEntity? {
        if case .content(let game, _) = self {
            return game
        }
        return nil
    }

    public var isFavorite: Bool {
        if case .content(_, let isFavorite) = self {
            return isFavorite
        }
        return false
    }
}
