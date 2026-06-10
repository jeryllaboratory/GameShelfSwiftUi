// ContentView.swift
// GameShelfSwiftUi
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import GameShelfData
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        MainTabView()
            .environmentObject(AppDIContainer(modelContext: modelContext))
    }
}

#Preview {
    ContentView()
        .modelContainer(for: GameShelfData.FavoriteGameModel.self, inMemory: true)
}
