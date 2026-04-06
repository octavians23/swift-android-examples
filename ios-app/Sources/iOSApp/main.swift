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

import SharedLogic

// Demonstrates calling the cross-platform SharedLogic library.
// On iOS, import SharedLogic in any Swift file after adding the package in Xcode.

let greeting = greet(name: "iOS")
print(greeting)

let libVersion = version()
print("Library: \(libVersion)")

let timestamp = currentTimestamp()
print("Current time: \(timestamp)")
