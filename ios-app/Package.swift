// swift-tools-version: 6.0
// Demo Swift executable showing how to use the SharedLogic package on macOS/iOS.
//
// To run on macOS:
//   swift run
//
// To add to an iOS Xcode project:
//   File > Add Package Dependencies > Add Local... > select the shared-logic/ directory

import PackageDescription

let package = Package(
    name: "iOSApp",
    platforms: [.macOS(.v13), .iOS(.v16)],
    dependencies: [
        .package(path: "../shared-logic"),
    ],
    targets: [
        .executableTarget(
            name: "iOSApp",
            dependencies: [
                .product(name: "SharedLogic", package: "shared-logic"),
            ]
        ),
    ]
)
