# iOS App — SharedLogic Integration

This directory contains a Swift executable that demonstrates calling the `SharedLogic`
cross-platform Swift package from a macOS/iOS context.

## Run on macOS

```sh
swift run
```

Expected output:
```
Hello, iOS! Welcome to SharedLogic.
Library: SharedLogic 1.0.0
Current time: 2025-...
```

## Add to an iOS Xcode project

1. Open your Xcode project.
2. Go to **File → Add Package Dependencies → Add Local…**
3. Select the `shared-logic/` directory at the root of this repository.
4. Add **SharedLogic** as a dependency of your app target.
5. Import and use it in any Swift file:

```swift
import SharedLogic

let greeting = greet(name: "World")
print(greeting)

let timestamp = currentTimestamp()
print("Current time: \(timestamp)")
```

## Notes

- `SharedLogic` is a pure Swift library with no platform-specific dependencies,
  so it builds natively for iOS, macOS, and Android.
- On Android the same package is cross-compiled using the Swift Android SDK and
  the `JExtractSwiftPlugin` generates Java/JNI wrappers automatically.
  See `shared-logic-android-app/` for the Android side.
