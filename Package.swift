// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CrystalButtonKit",
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "CrystalButtonKit",
            targets: ["CrystalButtonKit"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-snapshot-testing.git",
            from: "1.9.0"
        ),
        .package(
            name: "CUISeparator",
            url: "https://github.com/robhasacamera/CUISeparator.git",
            from: "0.3.1"
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "CrystalButtonKit",
            dependencies: ["CUISeparator"]
        ),
        .testTarget(
            name: "CrystalButtonKitTests",
            dependencies: [
                "CrystalButtonKit",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing")
            ],
            exclude: ["__Snapshots__/"]
        )
    ]
)
