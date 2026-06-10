// AboutStatCardView.swift
// GameShelfAboutFeature
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import GameShelfCommon
import GameShelfCore
import SwiftUI

public struct AboutStatCardView: View {
    let stat: ProfileStatEntity

    public init(stat: ProfileStatEntity) {
        self.stat = stat
    }

    public var body: some View {
        VStack(spacing: GSSpacing.xxs) {
            Text(stat.value)
                .font(GSTypography.title2)
                .foregroundStyle(GSColor.primaryText)
                .lineLimit(1)

            Text(stat.label.uppercased())
                .font(GSTypography.caption)
                .foregroundStyle(GSColor.secondaryText)
                .tracking(1.5)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    AboutStatCardView(stat: ProfileStatEntity(value: "4+", label: "Years"))
        .padding()
}
