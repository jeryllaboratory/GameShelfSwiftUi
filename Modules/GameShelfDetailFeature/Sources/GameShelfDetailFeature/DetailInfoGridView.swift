// DetailInfoGridView.swift
// GameShelfDetailFeature
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import GameShelfCommon
import GameShelfCore
import SwiftUI

public struct DetailInfoGridView: View {
    let game: GameDetailEntity

    public init(game: GameDetailEntity) {
        self.game = game
    }

    public var body: some View {
        VStack(spacing: 0) {
            Divider()
                .background(GSColor.divider)

            HStack(spacing: 0) {
                DetailInfoColumn(
                    title: "RATING",
                    value: String(format: "%.1f", game.rating)
                )

                verticalDivider

                DetailInfoColumn(
                    title: "RELEASE",
                    value: game.released?.toMonthDayDisplayDate() ?? "-"
                )

                verticalDivider

                DetailInfoColumn(
                    title: "SCORE",
                    value: game.metacritic.map(String.init) ?? "-"
                )
            }
            .padding(.vertical, GSSpacing.xl)

            Divider()
                .background(GSColor.divider)
        }
        .frame(maxWidth: .infinity)
        .background(GSColor.appBackground)
    }

    private var verticalDivider: some View {
        Rectangle()
            .fill(GSColor.divider)
            .frame(width: 1, height: 56)
    }
}

private struct DetailInfoColumn: View {
    let title: String
    let value: String

    var body: some View {
        VStack(spacing: GSSpacing.sm) {
            Text(title)
                .font(GSTypography.captionMedium)
                .foregroundStyle(GSColor.secondaryText)
                .tracking(1)
                .lineLimit(1)
                .minimumScaleFactor(0.8)

            Text(value)
                .font(GSTypography.title2)
                .foregroundStyle(GSColor.primaryText)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
                .allowsTightening(true)
        }
        .frame(maxWidth: .infinity, minHeight: 64)
        .clipped()
    }
}

#Preview {
    DetailInfoGridView(
        game: GameDetailEntity(
            id: 1,
            name: "Sample Game",
            released: "2026-06-08",
            rating: 4.5,
            metacritic: 90
        )
    )
    .padding()
}
