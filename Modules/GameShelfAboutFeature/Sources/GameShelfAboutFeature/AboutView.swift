// AboutView.swift
// GameShelfAboutFeature
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import GameShelfCommon
import GameShelfCore
import SwiftUI

public struct AboutView: View {
    @StateObject private var viewModel: AboutViewModel

    public init(viewModel: AboutViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    public var body: some View {
        VStack(spacing: 0) {
            GSTopBar(title: "Profile")
            Divider().background(GSColor.divider)
            contentView
        }
        .background(GSColor.appBackground)
        .hideNavigationBarIfAvailable()
        .task {
            if case .idle = viewModel.state {
                viewModel.loadProfile()
            }
        }
    }

    @ViewBuilder
    private var contentView: some View {
        switch viewModel.state {
        case .idle, .loading:
            GSLoadingView(message: "Loading profile...")
        case .content(let profile):
            profileContentView(profile: profile)
        case .error(let message):
            GSErrorStateView(
                message: message,
                retryAction: viewModel.retry
            )
        }
    }

    private func profileContentView(profile: ProfileEntity) -> some View {
        ScrollView {
            VStack(spacing: GSSpacing.xl) {
                AboutProfileHeaderView(profile: profile)
                statsView(profile.stats)
                AboutBiographyCardView(biography: profile.biography)
                AboutExpertiseView(expertise: profile.expertise)
            }
            .padding(.horizontal, GSSpacing.screenHorizontal)
            .padding(.bottom, GSSpacing.xxl)
        }
    }

    private func statsView(_ stats: [ProfileStatEntity]) -> some View {
        VStack(spacing: 0) {
            Divider().background(GSColor.divider)

            HStack(spacing: 0) {
                ForEach(Array(stats.enumerated()), id: \.element.id) { index, stat in
                    AboutStatCardView(stat: stat)

                    if index != stats.count - 1 {
                        Rectangle()
                            .fill(GSColor.divider)
                            .frame(width: 1, height: 48)
                    }
                }
            }
            .padding(.vertical, GSSpacing.lg)

            Divider().background(GSColor.divider)
        }
    }
}

private extension View {
    @ViewBuilder
    func hideNavigationBarIfAvailable() -> some View {
        #if os(iOS)
        self.toolbar(.hidden, for: .navigationBar)
        #else
        self
        #endif
    }
}

#Preview {
    NavigationStack {
        AboutView(viewModel: AboutViewModel(useCase: PreviewAboutUseCase()))
    }
}

private struct PreviewAboutUseCase: AboutUseCase {
    func fetchProfile() async throws -> ProfileEntity {
        ProfileEntity(
            name: "Jery I D Lenas",
            headline: "iOS Developer | Mobile Developer",
            biography: "Software engineer focused on mobile development, clean architecture, "
                + "modularization, and production-ready application design.",
            stats: [
                ProfileStatEntity(value: "4+", label: "Years"),
                ProfileStatEntity(value: "5+", label: "Projects"),
                ProfileStatEntity(value: "iOS", label: "Focus")
            ],
            expertise: [
                "SwiftUI",
                "SwiftData",
                "Clean Architecture",
                "Modularization"
            ]
        )
    }
}
