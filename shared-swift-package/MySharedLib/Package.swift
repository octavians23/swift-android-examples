// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import CompilerPluginSupport
import PackageDescription

let package = Package(
  name: "MySharedLib",
  // On iOS and macOS the package is used directly through SPM.
  // Android targets are driven by the Swift SDK cross-compiler and do not
  // require a platforms entry here.
  platforms: [
    .macOS(.v15),
    .iOS(.v17),
  ],
  products: [
    // Build as a dynamic library so it can be packaged as a .so for Android
    // and as a dynamic framework for iOS.
    .library(
      name: "MySharedLib",
      type: .dynamic,
      targets: ["MySharedLib"]
    )
  ],
  dependencies: [
    // swift-java provides the JExtractSwiftPlugin that auto-generates Java/JNI
    // bindings from the public Swift API. On iOS the plugin is a no-op.
    .package(url: "https://github.com/swiftlang/swift-java", from: "0.1.2"),
  ],
  targets: [
    .target(
      name: "MySharedLib",
      dependencies: [
        .product(name: "SwiftJava", package: "swift-java")
      ],
      swiftSettings: [
        .swiftLanguageMode(.v5),
      ],
      plugins: [
        // Generates Java wrapper classes and JNI glue from the public Swift API.
        // Only active when building for Android via the Gradle build script.
        .plugin(name: "JExtractSwiftPlugin", package: "swift-java")
      ]
    ),
    .testTarget(
      name: "MySharedLibTests",
      dependencies: ["MySharedLib"]
    ),
  ]
)
