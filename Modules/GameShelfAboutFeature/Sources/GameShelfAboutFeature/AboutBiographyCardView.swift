// AboutBiographyCardView.swift
// GameShelfAboutFeature
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import GameShelfCommon
import SwiftUI

public struct AboutBiographyCardView: View {
    let biography: String

    public init(biography: String) {
        self.biography = biography
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: GSSpacing.md) {
            Text("BIOGRAPHY")
                .font(GSTypography.overline)
                .foregroundStyle(GSColor.primaryText)
                .tracking(1.5)

            Text(biography)
                .font(GSTypography.body)
                .foregroundStyle(GSColor.primaryText)
                .lineSpacing(8)
                .fixedSize(horizontal: false, vertical: true)
                .padding(GSSpacing.xl)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(GSColor.surfaceElevated)
                .overlay {
                    RoundedRectangle(cornerRadius: GSRadius.sm)
                        .stroke(GSColor.border, lineWidth: 1)
                }
                .clipShape(RoundedRectangle(cornerRadius: GSRadius.sm))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    AboutBiographyCardView(
        biography: "Software engineer focused on mobile development and clean architecture."
    )
    .padding()
}
