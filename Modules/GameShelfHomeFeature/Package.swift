// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "GameShelfHomeFeature",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "GameShelfHomeFeature",
            targets: ["GameShelfHomeFeature"]
        )
    ],
    dependencies: [
        .package(path: "../GameShelfCore"),
        .package(
            url: "https://github.com/jeryllaboratory/GameShelfCommon.git",
            from: "1.0.1"
        )
    ],
    targets: [
        .target(
            name: "GameShelfHomeFeature",
            dependencies: [
                "GameShelfCore",
                .product(
                        name: "GameShelfCommon",
                        package: "GameShelfCommon"
                    )
            ]
        ),
        .testTarget(
            name: "GameShelfHomeFeatureTests",
            dependencies: ["GameShelfHomeFeature"]
        )
    ]
)
