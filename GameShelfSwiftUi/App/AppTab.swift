// AppTab.swift
// GameShelfSwiftUi
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import Foundation

enum AppTab: Hashable {
    case home
    case favorite
    case profile

    var title: String {
        switch self {
        case .home:
            return "Home"
        case .favorite:
            return "Favorite"
        case .profile:
            return "Profile"
        }
    }

    var systemImage: String {
        switch self {
        case .home:
            return "house"
        case .favorite:
            return "heart"
        case .profile:
            return "person.circle"
        }
    }
}
