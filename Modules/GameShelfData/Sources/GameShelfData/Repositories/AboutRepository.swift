// AboutRepository.swift
// GameShelfData
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import Foundation
import GameShelfCore

public struct AboutRepository: AboutRepositoryProtocol {
    private let avatarURL = "https://assets.cdn.dicoding.com/small/avatar/"
        + "dos:4638acc0b4f6d62b91a9e5aeda6390d220211004103334.png"

    public init() {}

    public func fetchProfile() async throws -> ProfileEntity {
        ProfileEntity(
            name: "Jery I D Lenas",
            avatarURL: avatarURL,
            headline: "iOS Developer | Mobile Developer",
            biography: "Software engineer focused on mobile development, clean architecture, "
                + "modularization, and production-ready application design.",
            stats: [
                ProfileStatEntity(value: "4+", label: "Years"),
                ProfileStatEntity(value: "5+", label: "Projects"),
                ProfileStatEntity(value: "iOS", label: "Focus")
            ],
            expertise: [
                "SwiftUI",
                "SwiftData",
                "UIKit",
                "Clean Architecture",
                "Modularization"
            ]
        )
    }
}
