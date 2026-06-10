// FavoriteLocalDataSource.swift
// GameShelfData
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import Foundation
import GameShelfCore
import SwiftData

@MainActor
public protocol FavoriteLocalDataSourceProtocol {
    func fetchFavorites() throws -> [FavoriteGameModel]
    func fetchFavorite(id: Int) throws -> FavoriteGameModel?
    func isFavorite(id: Int) throws -> Bool
    func saveFavorite(_ game: GameDetailEntity) throws
    func deleteFavorite(id: Int) throws
}

@MainActor
public final class FavoriteLocalDataSource: FavoriteLocalDataSourceProtocol {
    private let modelContext: ModelContext

    public init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    public func fetchFavorites() throws -> [FavoriteGameModel] {
        let descriptor = FetchDescriptor<FavoriteGameModel>(
            sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
        )
        return try modelContext.fetch(descriptor)
    }

    public func fetchFavorite(id: Int) throws -> FavoriteGameModel? {
        var descriptor = FetchDescriptor<FavoriteGameModel>(
            predicate: #Predicate { favorite in
                favorite.id == id
            }
        )
        descriptor.fetchLimit = 1
        return try modelContext.fetch(descriptor).first
    }

    public func isFavorite(id: Int) throws -> Bool {
        try fetchFavorite(id: id) != nil
    }

    public func saveFavorite(_ game: GameDetailEntity) throws {
        if let existingFavorite = try fetchFavorite(id: game.id) {
            existingFavorite.update(from: game)
        } else {
            modelContext.insert(FavoriteGameModel(game: game))
        }

        try modelContext.save()
    }

    public func deleteFavorite(id: Int) throws {
        guard let favorite = try fetchFavorite(id: id) else {
            return
        }

        modelContext.delete(favorite)
        try modelContext.save()
    }
}
