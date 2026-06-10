// GenreEntity.swift
// GameShelfCore
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import Foundation

public struct GenreEntity: Equatable, Identifiable {
    public let id: Int
    public let name: String
    public let slug: String?

    public init(
        id: Int,
        name: String,
        slug: String? = nil
    ) {
        self.id = id
        self.name = name
        self.slug = slug
    }
}
