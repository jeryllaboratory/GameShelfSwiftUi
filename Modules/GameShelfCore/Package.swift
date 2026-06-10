// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "GameShelfCore",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "GameShelfCore",
            targets: ["GameShelfCore"]
        )
    ],
    targets: [
        .target(
            name: "GameShelfCore"
        ),
        .testTarget(
            name: "GameShelfCoreTests",
            dependencies: ["GameShelfCore"]
        )
    ]
)
