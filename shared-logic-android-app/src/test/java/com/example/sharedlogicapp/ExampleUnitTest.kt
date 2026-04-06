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

package com.example.sharedlogicapp

import org.junit.Test

import org.junit.Assert.*

class ExampleUnitTest {
    // SharedLogic JNI functions require a loaded native library and must be tested
    // as instrumented tests on an Android device. See ExampleInstrumentedTest.kt.
    @Test
    fun addition_isCorrect() {
        assertEquals(4, 2 + 2)
    }
}
