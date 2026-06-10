// HomeViewState.swift
// GameShelfHomeFeature
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import Foundation
import GameShelfCore

public enum HomeViewState: Equatable {
    case idle
    case loading
    case content([GameEntity])
    case empty(message: String)
    case error(message: String)

    public var games: [GameEntity] {
        if case .content(let games) = self {
            return games
        }
        return []
    }
}
