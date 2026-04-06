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

import Testing
@testable import MySharedLib

@Test func greeting() throws {
    #expect(greet("World") == "Hello, World, from Swift!")
}

@Test func greetingWithEmptyName() throws {
    #expect(greet("") == "Hello, , from Swift!")
}
