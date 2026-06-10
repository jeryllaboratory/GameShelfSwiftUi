// MainTabView.swift
// GameShelfSwiftUi
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import GameShelfAboutFeature
import GameShelfCommon
import GameShelfData
import GameShelfDetailFeature
import GameShelfFavoriteFeature
import GameShelfHomeFeature
import SwiftUI

struct MainTabView: View {
    @EnvironmentObject private var appDIContainer: AppDIContainer
    @State private var selectedTab: AppTab = .home

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                GameShelfHomeFeature.HomeView(
                    viewModel: appDIContainer.makeHomeViewModel(),
                    detailDestination: { gameId in
                        makeDetailView(gameId: gameId)
                    }
                )
            }
            .tag(AppTab.home)
            .tabItem {
                Label(AppTab.home.title, systemImage: AppTab.home.systemImage)
            }

            NavigationStack {
                GameShelfFavoriteFeature.FavoriteView(
                    viewModel: appDIContainer.makeFavoriteViewModel(),
                    refreshToken: appDIContainer.favoriteRefreshToken,
                    onRefreshFavorites: appDIContainer.notifyFavoriteChanged,
                    detailDestination: { gameId in
                        makeDetailView(gameId: gameId)
                    }
                )
            }
            .tag(AppTab.favorite)
            .tabItem {
                Label(AppTab.favorite.title, systemImage: AppTab.favorite.systemImage)
            }

            NavigationStack {
                GameShelfAboutFeature.AboutView(viewModel: appDIContainer.makeAboutViewModel())
            }
            .tag(AppTab.profile)
            .tabItem {
                Label(AppTab.profile.title, systemImage: AppTab.profile.systemImage)
            }
        }
        .tint(GameShelfCommon.GSColor.primaryText)
    }

    private func makeDetailView(gameId: Int) -> GameShelfDetailFeature.DetailView {
        GameShelfDetailFeature.DetailView(
            viewModel: appDIContainer.makeDetailViewModel(gameId: gameId),
            favoriteRefreshToken: appDIContainer.favoriteRefreshToken
        )
    }
}

#Preview {
    ContentView()
        .modelContainer(for: GameShelfData.FavoriteGameModel.self, inMemory: true)
}
