// AboutViewModelTests.swift
// GameShelfAboutFeature
//
// Created by Jery I D Lenas on 09/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import GameShelfCore
@testable import GameShelfAboutFeature
import XCTest

final class AboutViewModelTests: XCTestCase {
    @MainActor
    func testLoadProfileShowsContentState() async throws {
        let viewModel = AboutViewModel(useCase: FakeAboutUseCase())

        viewModel.loadProfile()
        try await Task.sleep(nanoseconds: 100_000_000)

        XCTAssertEqual(viewModel.state.profile?.name, "Jery I D Lenas")
        XCTAssertEqual(viewModel.state.profile?.headline, "iOS Developer | Mobile Developer")
        XCTAssertEqual(viewModel.state.profile?.expertise, ["SwiftUI", "SwiftData"])
    }
}

private struct FakeAboutUseCase: AboutUseCase {
    func fetchProfile() async throws -> ProfileEntity {
        ProfileEntity(
            name: "Jery I D Lenas",
            headline: "iOS Developer | Mobile Developer",
            biography: "Focused on SwiftUI and clean architecture.",
            stats: [
                ProfileStatEntity(value: "4+", label: "Years"),
                ProfileStatEntity(value: "iOS", label: "Focus")
            ],
            expertise: ["SwiftUI", "SwiftData"]
        )
    }
}
