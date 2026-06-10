// AboutExpertiseView.swift
// GameShelfAboutFeature
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import GameShelfCommon
import SwiftUI

public struct AboutExpertiseView: View {
    let expertise: [String]

    private let columns = [
        GridItem(.adaptive(minimum: 88), spacing: GSSpacing.xs, alignment: .leading)
    ]

    public init(expertise: [String]) {
        self.expertise = expertise
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: GSSpacing.md) {
            Text("EXPERTISE")
                .font(GSTypography.overline)
                .foregroundStyle(GSColor.primaryText)
                .tracking(1.5)

            LazyVGrid(columns: columns, alignment: .leading, spacing: GSSpacing.xs) {
                ForEach(expertise, id: \.self) { item in
                    GSChipView(title: item.uppercased())
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    AboutExpertiseView(
        expertise: [
            "SwiftUI",
            "SwiftData",
            "Clean Architecture",
            "Modularization"
        ]
    )
    .padding()
}
