// DetailFavoriteButton.swift
// GameShelfDetailFeature
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import GameShelfCommon
import SwiftUI

public struct DetailFavoriteButton: View {
    let isFavorite: Bool
    let action: () -> Void

    public init(isFavorite: Bool, action: @escaping () -> Void) {
        self.isFavorite = isFavorite
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(isFavorite ? .red : GSColor.primaryText)
                .frame(width: 36, height: 36)
                .background(GSColor.iconBackground)
                .clipShape(Circle())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HStack {
        DetailFavoriteButton(isFavorite: false) {}
        DetailFavoriteButton(isFavorite: true) {}
    }
    .padding()
}
