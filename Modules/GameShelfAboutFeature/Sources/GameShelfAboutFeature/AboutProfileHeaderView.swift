// AboutProfileHeaderView.swift
// GameShelfAboutFeature
//
// Created by Jery I D Lenas on 08/06/26.
// Copyright © 2026 JERYL.ID All rights reserved.
//

import GameShelfCommon
import GameShelfCore
import SwiftUI

public struct AboutProfileHeaderView: View {
    let profile: ProfileEntity

    public init(profile: ProfileEntity) {
        self.profile = profile
    }

    public var body: some View {
        VStack(spacing: GSSpacing.lg) {
            avatarView

            VStack(spacing: GSSpacing.xs) {
                Text(profile.name)
                    .font(GSTypography.largeTitle)
                    .foregroundStyle(GSColor.primaryText)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .minimumScaleFactor(0.8)

                Text(profile.headline)
                    .font(GSTypography.body)
                    .foregroundStyle(GSColor.secondaryText)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.top, GSSpacing.xxxl)
    }

    private var avatarView: some View {
        ZStack {
            if let avatarURL = profile.avatarURL,
               let url = URL(string: avatarURL) {
                GSRemoteImageView(url: url)
            } else {
                GSColor.surface
                Image(systemName: "person.fill")
                    .font(.system(size: 46, weight: .regular))
                    .foregroundStyle(GSColor.secondaryText)
            }
        }
        .frame(width: 112, height: 112)
        .clipShape(RoundedRectangle(cornerRadius: GSRadius.lg))
    }
}

#Preview {
    AboutProfileHeaderView(
        profile: ProfileEntity(
            name: "Jery I D Lenas",
            headline: "iOS Developer | Mobile Developer",
            biography: "Sample biography"
        )
    )
    .padding()
}
