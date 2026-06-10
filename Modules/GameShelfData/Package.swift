// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "GameShelfData",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "GameShelfData",
            targets: ["GameShelfData"]
        )
    ],
    dependencies: [
        .package(path: "../GameShelfCore"),
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.10.0"))
    ],
    targets: [
        .target(
            name: "GameShelfData",
            dependencies: [
                "GameShelfCore",
                "Alamofire"
            ]
        ),
        .testTarget(
            name: "GameShelfDataTests",
            dependencies: [
                "GameShelfData",
                "GameShelfCore"
            ]
        )
    ]
)
