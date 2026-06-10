// AboutViewState.swift
// GameShelfAboutFeature
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import Foundation
import GameShelfCore

public enum AboutViewState: Equatable {
    case idle
    case loading
    case content(ProfileEntity)
    case error(message: String)

    public var profile: ProfileEntity? {
        if case .content(let profile) = self {
            return profile
        }
        return nil
    }
}
