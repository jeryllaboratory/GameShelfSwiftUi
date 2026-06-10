// AboutFeatureTests.swift
// GameShelfSwiftUi
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import GameShelfAboutFeature
import GameShelfCore
import Testing
import XCTest

struct AboutFeatureTests {

    @MainActor
    @Test func aboutViewModelLoadProfileShowsContentState() async throws {
        let viewModel = GameShelfAboutFeature.AboutViewModel(useCase: FakeAboutUseCase())
        viewModel.loadProfile()
        await waitUntil {
            viewModel.state.profile != nil
        }

        #expect(viewModel.state.profile?.name == "Jery I D Lenas")
        #expect(viewModel.state.profile?.expertise.contains("SwiftUI") == true)
    }
}

@MainActor
private func waitUntil(
    timeout: TimeInterval = 1.0,
    condition: @escaping () -> Bool
) async {
    let deadline = Date().addingTimeInterval(timeout)

    while Date() < deadline {
        if condition() {
            return
        }

        try? await Task.sleep(nanoseconds: 50_000_000)
    }
}

private struct FakeAboutUseCase: GameShelfCore.AboutUseCase {
    func fetchProfile() async throws -> GameShelfCore.ProfileEntity {
        GameShelfCore.ProfileEntity(
            name: "Jery I D Lenas",
            headline: "iOS Developer | Mobile Developer",
            biography: "Focused on SwiftUI and clean architecture.",
            stats: [
                GameShelfCore.ProfileStatEntity(value: "4+", label: "Years"),
                GameShelfCore.ProfileStatEntity(value: "iOS", label: "Focus")
            ],
            expertise: ["SwiftUI", "SwiftData"]
        )
    }
}
