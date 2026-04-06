// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import CompilerPluginSupport
import PackageDescription

let package = Package(
  name: "SharedLogic",
  platforms: [.macOS(.v15), .iOS(.v16)],
  products: [
    .library(
      name: "SharedLogic",
      type: .dynamic,
      targets: ["SharedLogic"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/swiftlang/swift-java", from: "0.1.2"),
  ],
  targets: [
    .target(
      name: "SharedLogic",
      dependencies: [
        // SwiftJava is only needed on platforms that support JVM interop (Android, Linux, macOS).
        // It is excluded from iOS builds where the JVM is not available.
        .product(
          name: "SwiftJava",
          package: "swift-java",
          condition: .when(platforms: [.android, .linux, .macOS])
        )
      ],
      swiftSettings: [
        .swiftLanguageMode(.v5),
      ],
      plugins: [
        .plugin(name: "JExtractSwiftPlugin", package: "swift-java")
      ]
    ),
    .testTarget(
      name: "SharedLogicTests",
      dependencies: ["SharedLogic"]
    ),
  ]
)
