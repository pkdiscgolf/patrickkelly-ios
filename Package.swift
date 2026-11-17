// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "PatrickKelly",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
    ],
    products: [
        // An xtool project should contain exactly one library product,
        // representing the main app.
        .library(
            name: "PatrickKelly",
            targets: ["PatrickKelly"]
        ),
    ],
    targets: [
        .target(
            name: "PatrickKelly",
            resources: [
                .process("Resources"),
            ]
        ),
    ]
)
