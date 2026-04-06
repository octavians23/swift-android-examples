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

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TextField
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import com.example.sharedlogicapp.ui.theme.SharedLogicAppTheme
import com.example.sharedlogic.SharedLogic

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            SharedLogicAppTheme {
                Surface(
                    modifier = Modifier.fillMaxSize().padding(top = 64.dp),
                    color = MaterialTheme.colorScheme.background
                ) {
                    SharedLogicScreen()
                }
            }
        }
    }
}

@Composable
fun SharedLogicScreen() {
    val nameInput = remember { mutableStateOf("") }
    val greeting = remember { mutableStateOf("") }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(32.dp),
        verticalArrangement = Arrangement.spacedBy(12.dp)
    ) {
        TextField(
            value = nameInput.value,
            onValueChange = { nameInput.value = it },
            label = { Text("Enter your name") },
            modifier = Modifier.fillMaxWidth()
        )

        Button(
            colors = ButtonDefaults.buttonColors(
                containerColor = Color(0xFFF05138),
                contentColor = Color.White
            ),
            onClick = {
                // Calls the Swift greet() function from SharedLogic.swift
                greeting.value = SharedLogic.greet(nameInput.value)
            }
        ) {
            Text("Greet")
        }

        if (greeting.value.isNotEmpty()) {
            Text(
                text = greeting.value,
                style = MaterialTheme.typography.bodyMedium
            )
        }

        Text(
            // Calls the Swift version() function from SharedLogic.swift
            text = SharedLogic.version(),
            style = MaterialTheme.typography.bodySmall
        )

        Text(
            // Calls the Swift currentTimestamp() function from SharedLogic.swift
            text = "Time: ${SharedLogic.currentTimestamp()}",
            style = MaterialTheme.typography.bodySmall
        )
    }
}
