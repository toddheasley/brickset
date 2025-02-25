// swift-tools-version: 6.0

import PackageDescription

let package: Package = Package(name: "GetSet", platforms: [
        .macOS(.v15),
        .macCatalyst(.v18),
        .iOS(.v18),
        .watchOS(.v11),
        .visionOS(.v2),
        .tvOS(.v18)
    ], products: [
        .executable(name: "getset-cli", targets: [
            "GetSetCLI"
        ]),
        .library(name: "GetSet", targets: [
            "GetSet"
        ])
    ], dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", exact: "1.5.0")
    ], targets: [
        .target(name: "GetSet"),
        .executableTarget(name: "GetSetCLI", dependencies: [
            .product(name: "ArgumentParser", package: "swift-argument-parser"),
            "GetSet"
        ]),
        .testTarget(name: "GetSetTests", dependencies: [
            "GetSet"
        ])
    ])
