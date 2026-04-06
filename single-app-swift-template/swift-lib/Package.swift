// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import CompilerPluginSupport
import PackageDescription

let package = Package(
  name: "SwiftHashing",
  platforms: [.macOS(.v15)],
  products: [
    .library(
      name: "SwiftHashing",
      type: .dynamic,
      targets: ["SwiftHashing"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/swiftlang/swift-java", from: "0.1.2"),
    .package(url: "https://github.com/apple/swift-crypto.git", "1.0.0"..<"4.0.0"),
  ],
  targets: [
    .target(
      name: "SwiftHashing",
      dependencies: [
        .product(name: "Crypto", package: "swift-crypto"),
        .product(name: "SwiftJava", package: "swift-java")
      ],
      swiftSettings: [
        .swiftLanguageMode(.v5),
      ],
      plugins: [
        .plugin(name: "JExtractSwiftPlugin", package: "swift-java")
      ]
    ),
    .testTarget(
      name: "SwiftHashingTests",
      dependencies: ["SwiftHashing"]
    ),
  ]
)
