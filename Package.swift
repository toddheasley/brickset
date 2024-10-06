// swift-tools-version: 6.0

import PackageDescription

let package: Package = Package(name: "Brickset", platforms: [
        .macOS(.v15),
        .macCatalyst(.v18),
        .iOS(.v18),
        .tvOS(.v18),
        .watchOS(.v11),
        .visionOS(.v2)
    ], products: [
        .library(name: "Brickset", targets: [
            "Brickset"
        ]),
        .executable(name: "brickset-cli", targets: [
            "BricksetCLI"
        ])
    ], dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", branch: "main")
    ], targets: [
        .target(name: "Brickset"),
        .executableTarget(name: "BricksetCLI", dependencies: [
            .product(name: "ArgumentParser", package: "swift-argument-parser"),
            "Brickset"
        ]),
        .testTarget(name: "BricksetTests", dependencies: [
            "Brickset"
        ])
    ])