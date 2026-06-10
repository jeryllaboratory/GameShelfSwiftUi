// DetailHeaderView.swift
// GameShelfDetailFeature
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import GameShelfCommon
import GameShelfCore
import SwiftUI

public struct DetailHeaderView: View {
    let game: GameDetailEntity
    let contentWidth: CGFloat

    public init(game: GameDetailEntity, contentWidth: CGFloat) {
        self.game = game
        self.contentWidth = contentWidth
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: GSSpacing.lg) {
            GSRemoteImageView(
                url: game.backgroundImage.flatMap(URL.init(string:)),
                contentMode: .fill
            )
            .frame(width: contentWidth, height: contentWidth * 0.56)
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: GSRadius.md))

            Text(game.name.uppercased())
                .font(GSTypography.title)
                .foregroundStyle(GSColor.primaryText)
                .lineLimit(2)
                .minimumScaleFactor(0.85)
                .allowsTightening(true)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .frame(width: contentWidth, alignment: .leading)

            if let genre = game.genres.first {
                HStack {
                    Spacer(minLength: 0)
                    GSChipView(title: genre.name)
                    Spacer(minLength: 0)
                }
                .frame(width: contentWidth)
            }
        }
        .frame(width: contentWidth, alignment: .leading)
    }
}

#Preview {
    DetailHeaderView(
        game: GameDetailEntity(
            id: 1,
            name: "Grand Theft Auto V",
            released: "2013-09-17",
            rating: 4.5,
            overview: "Sample overview",
            genres: [GenreEntity(id: 1, name: "Action")]
        ),
        contentWidth: 340
    )
    .padding()
}
