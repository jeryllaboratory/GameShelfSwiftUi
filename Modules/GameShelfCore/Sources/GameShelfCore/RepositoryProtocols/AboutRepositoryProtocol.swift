// AboutRepositoryProtocol.swift
// GameShelfCore
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import Foundation

public protocol AboutRepositoryProtocol {
    func fetchProfile() async throws -> ProfileEntity
}
