// FavoriteViewModel.swift
// GameShelfFavoriteFeature
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import Foundation
import GameShelfCore

@MainActor
public final class FavoriteViewModel: ObservableObject {
    @Published public private(set) var state: FavoriteViewState = .idle
    @Published public var actionMessage: String?

    private let useCase: FavoriteUseCase
    private var loadTask: Task<Void, Never>?

    public init(useCase: FavoriteUseCase) {
        self.useCase = useCase
    }

    deinit {
        loadTask?.cancel()
    }

    public func loadFavorites() {
        loadTask?.cancel()
        loadTask = Task { [weak self] in
            await self?.fetchFavorites()
        }
    }

    public func retry() {
        loadFavorites()
    }

    public func deleteFavorite(id: Int) {
        loadTask?.cancel()
        loadTask = Task { [weak self] in
            await self?.performDeleteFavorite(id: id)
        }
    }

    public func deleteFavorite(at offsets: IndexSet) {
        let currentFavorites = state.favorites

        for index in offsets where currentFavorites.indices.contains(index) {
            deleteFavorite(id: currentFavorites[index].id)
        }
    }

    public func clearActionMessage() {
        actionMessage = nil
    }

    private func fetchFavorites() async {
        state = .loading

        do {
            let favorites = try await useCase.fetchFavorites()
            state = favorites.isEmpty
                ? .empty(message: "Games saved from the detail page will appear here.")
                : .content(favorites)
        } catch {
            state = .error(message: error.localizedDescription)
        }
    }

    private func performDeleteFavorite(id: Int) async {
        do {
            try await useCase.deleteFavorite(id: id)
            actionMessage = "Favorite removed."
            await fetchFavorites()
        } catch {
            state = .error(message: error.localizedDescription)
        }
    }
}
