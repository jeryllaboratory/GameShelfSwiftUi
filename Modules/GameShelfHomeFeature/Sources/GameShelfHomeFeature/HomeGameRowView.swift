// HomeGameRowView.swift
// GameShelfHomeFeature
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import GameShelfCommon
import GameShelfCore
import SwiftUI

public struct HomeGameRowView: View {
    let game: GameEntity

    public init(game: GameEntity) {
        self.game = game
    }

    public var body: some View {
        HStack(alignment: .center, spacing: GSSpacing.xl) {
            GSRemoteImageView(
                url: game.backgroundImage.flatMap(URL.init(string:)),
                contentMode: .fill
            )
            .frame(width: 80, height: 80)
            .clipShape(RoundedRectangle(cornerRadius: GSRadius.sm))

            VStack(alignment: .leading, spacing: GSSpacing.xs) {
                Text(game.name)
                    .font(GSTypography.listTitle)
                    .foregroundStyle(GSColor.primaryText)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)

                Text(game.released?.toDisplayDate() ?? "Unknown release")
                    .font(GSTypography.caption)
                    .foregroundStyle(GSColor.secondaryText)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            HStack(spacing: GSSpacing.xs) {
                Image(systemName: "star")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(GSColor.primaryText)

                Text(String(format: "%.1f/5", game.rating))
                    .font(GSTypography.bodyMedium)
                    .foregroundStyle(GSColor.primaryText)
                    .lineLimit(1)
            }
            .frame(minWidth: 72, alignment: .trailing)
        }
        .gsFlatRow()
    }
}

#Preview {
    HomeGameRowView(
        game: GameEntity(
            id: 1,
            name: "Sample Game",
            released: "2026-06-08",
            backgroundImage: nil,
            rating: 4.5
        )
    )
    .padding()
}
