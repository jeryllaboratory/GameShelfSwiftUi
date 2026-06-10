// ProfileEntity.swift
// GameShelfCore
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import Foundation

public struct ProfileEntity: Equatable {
    public let name: String
    public let avatarURL: String?
    public let headline: String
    public let biography: String
    public let stats: [ProfileStatEntity]
    public let expertise: [String]

    public init(
        name: String,
        avatarURL: String? = nil,
        headline: String,
        biography: String,
        stats: [ProfileStatEntity] = [],
        expertise: [String] = []
    ) {
        self.name = name
        self.avatarURL = avatarURL
        self.headline = headline
        self.biography = biography
        self.stats = stats
        self.expertise = expertise
    }
}

public struct ProfileStatEntity: Equatable, Identifiable {
    public let id: UUID
    public let value: String
    public let label: String

    public init(
        id: UUID = UUID(),
        value: String,
        label: String
    ) {
        self.id = id
        self.value = value
        self.label = label
    }
}
