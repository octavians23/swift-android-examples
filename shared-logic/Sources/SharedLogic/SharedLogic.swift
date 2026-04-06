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

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

/// Returns a personalized greeting message.
public func greet(name: String) -> String {
    "Hello, \(name)! Welcome to SharedLogic."
}

/// Returns a version string identifying this library.
public func version() -> String {
    "SharedLogic 1.0.0"
}

/// Returns the current date and time as an ISO 8601 string.
public func currentTimestamp() -> String {
    ISO8601DateFormatter().string(from: Date())
}
