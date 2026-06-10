// AboutUseCase.swift
// GameShelfCore
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import Foundation

public protocol AboutUseCase {
    func fetchProfile() async throws -> ProfileEntity
}

public struct AboutInteractor: AboutUseCase {
    private let repository: AboutRepositoryProtocol

    public init(repository: AboutRepositoryProtocol) {
        self.repository = repository
    }

    public func fetchProfile() async throws -> ProfileEntity {
        try await repository.fetchProfile()
    }
}
