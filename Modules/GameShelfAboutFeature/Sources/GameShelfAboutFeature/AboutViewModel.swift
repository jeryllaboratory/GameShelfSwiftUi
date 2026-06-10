// AboutViewModel.swift
// GameShelfAboutFeature
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import Foundation
import GameShelfCore

@MainActor
public final class AboutViewModel: ObservableObject {
    @Published public private(set) var state: AboutViewState = .idle

    private let useCase: AboutUseCase
    private var loadTask: Task<Void, Never>?

    public init(useCase: AboutUseCase) {
        self.useCase = useCase
    }

    deinit {
        loadTask?.cancel()
    }

    public func loadProfile() {
        loadTask?.cancel()
        loadTask = Task { [weak self] in
            await self?.fetchProfile()
        }
    }

    public func retry() {
        loadProfile()
    }

    private func fetchProfile() async {
        state = .loading

        do {
            let profile = try await useCase.fetchProfile()
            state = .content(profile)
        } catch {
            state = .error(message: error.localizedDescription)
        }
    }
}
