// HomeViewModel.swift
// GameShelfHomeFeature
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import Combine
import Foundation
import GameShelfCore

@MainActor
public final class HomeViewModel: ObservableObject {
    @Published public private(set) var state: HomeViewState = .idle
    @Published public var searchText: String = ""

    private let useCase: HomeUseCase
    private var requestTask: Task<Void, Never>?
    private var cancellables = Set<AnyCancellable>()
    private var activeSearchQuery: String?

    public init(useCase: HomeUseCase) {
        self.useCase = useCase
        bindSearchText()
    }

    deinit {
        requestTask?.cancel()
        cancellables.removeAll()
    }

    public func loadGames() {
        activeSearchQuery = nil
        requestTask?.cancel()
        requestTask = Task { [weak self] in
            await self?.fetchGames()
        }
    }

    public func retry() {
        let trimmedQuery = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        if trimmedQuery.isEmpty {
            loadGames()
        } else {
            runSearch(query: trimmedQuery)
        }
    }

    public func searchGames(query: String) {
        searchText = query
    }

    private func bindSearchText() {
        $searchText
            .dropFirst()
            .debounce(for: .milliseconds(350), scheduler: RunLoop.main)
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .removeDuplicates()
            .sink { [weak self] query in
                Task { @MainActor [weak self] in
                    self?.handleSearchInput(query)
                }
            }
            .store(in: &cancellables)
    }

    private func handleSearchInput(_ query: String) {
        guard !query.isEmpty else {
            guard activeSearchQuery != nil else { return }
            loadGames()
            return
        }

        runSearch(query: query)
    }

    private func runSearch(query: String) {
        activeSearchQuery = query
        requestTask?.cancel()
        requestTask = Task { [weak self] in
            await self?.performSearch(query: query)
        }
    }

    private func fetchGames() async {
        state = .loading

        do {
            let games = try await useCase.fetchGames()
            state = games.isEmpty
                ? .empty(message: "No games available right now.")
                : .content(games)
        } catch {
            state = .error(message: error.localizedDescription)
        }
    }

    private func performSearch(query: String) async {
        state = .loading

        do {
            let games = try await useCase.searchGames(query: query)
            state = games.isEmpty
                ? .empty(message: "No games found for \"\(query)\".")
                : .content(games)
        } catch {
            state = .error(message: error.localizedDescription)
        }
    }
}
