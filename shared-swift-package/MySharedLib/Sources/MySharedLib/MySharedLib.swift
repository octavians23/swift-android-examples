//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2025 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

// Use FoundationEssentials when available (Android / recent Apple platforms),
// falling back to the full Foundation framework on older Apple targets.
#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

/// Returns a personalised greeting for the given name.
///
/// This function is the public API of the shared Swift package.  The
/// JExtractSwiftPlugin (from swift-java) automatically generates a Java
/// wrapper for this function when building for Android, so it can be called
/// directly from Kotlin or Java without any manual JNI code.
///
/// On iOS the function is available as an ordinary Swift import via SPM.
public func greet(_ name: String) -> String {
    "Hello, \(name), from Swift!"
}
