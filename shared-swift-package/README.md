# Shared Swift Package (iOS + Android)

This example shows how to structure a single Swift package so that it can be used **natively on iOS** via Swift Package Manager and **on Android** via the [swift-java](https://github.com/swiftlang/swift-java) JNI bridge.

The example is intentionally minimal – a public `greet()` function – so the focus stays on the cross-platform setup rather than the business logic.

## Project layout

```
shared-swift-package/
├── MySharedLib/                  # The Swift package (shared between iOS and Android)
│   ├── Package.swift
│   ├── Sources/MySharedLib/
│   │   ├── MySharedLib.swift     # Public API: greet(_ name:) -> String
│   │   └── swift-java.config     # JNI config consumed by JExtractSwiftPlugin
│   └── Tests/MySharedLibTests/
│       └── MySharedLibTests.swift
├── shared-lib-android/           # Android AAR Gradle module wrapping MySharedLib
│   └── build.gradle
└── shared-app/                   # Android demo app (Kotlin / Jetpack Compose)
    └── src/main/java/com/example/sharedapp/MainActivity.kt
```

---

## Using the Swift package on iOS

1. In Xcode open your iOS project.
2. Choose **File → Add Package Dependencies**.
3. Point to the local `MySharedLib/` directory (or its remote Git URL).
4. Add **MySharedLib** as a dependency of your app target.
5. Import and call the shared function like any Swift library:

```swift
import MySharedLib

let message = greet("Alice")   // "Hello, Alice, from Swift!"
```

The `JExtractSwiftPlugin` and `SwiftJava` product declared in `Package.swift` are no-ops on Apple platforms – they only generate JNI glue when the package is compiled with the Android Swift SDK.

---

## Using the Swift package on Android

### Prerequisites (one-time machine setup)

| Tool | Install command / link |
|------|------------------------|
| **Swiftly** (Swift toolchain manager) | https://www.swift.org/install/ |
| **Swift 6.3 toolchain** | `swiftly install 6.3` |
| **Swift SDK for Android** | Follow [these instructions](https://www.swift.org/documentation/articles/swift-sdk-for-android-getting-started.html) |
| **JDK 25** (only to publish swift-java artifacts) | [sdkman](https://sdkman.io): `sdk install java 25.0.1-amzn` |

### Publish swift-java support libraries to local Maven

> This step will not be necessary once swift-java publishes releases.

```bash
cd shared-swift-package/MySharedLib

# Resolve Swift packages (downloads swift-java source)
swift package resolve

# Publish swiftkit-core to ~/.m2/repository
./.build/checkouts/swift-java/gradlew \
    --project-dir .build/checkouts/swift-java \
    :SwiftKitCore:publishToMavenLocal
```

### Running the Android demo app

1. Open the root `swift-android-examples` project in Android Studio.
2. Select the **shared-swift-package-shared-app** Gradle target.
3. Run on an Android emulator or physical device (API 28+).
4. Type a name into the text field and press **Greet**.  
   The app calls `greet()` in Swift and displays the result.

### Building only the Android library

```bash
./gradlew :shared-swift-package-shared-lib-android:assembleRelease
```

The resulting `.aar` is at:
`shared-swift-package/shared-lib-android/build/outputs/aar/shared-lib-android-release.aar`

---

## How it works

```
MySharedLib.swift  (public func greet)
       │
       │  JExtractSwiftPlugin  (swift-java, build time)
       ▼
Java wrapper classes  (auto-generated, com.example.mysharedlib.MySharedLib)
       │
       │  JNI
       ▼
libMySharedLib.so  (compiled by shared-lib-android/build.gradle for each ABI)
       │
       ▼
Android app (Kotlin) calls MySharedLib.greet(name)
```

The key file is **`shared-lib-android/build.gradle`**.  It:

* Invokes `swiftly run swift build --swift-sdk <triple>` for each Android ABI (`arm64-v8a`, `armeabi-v7a`, `x86_64`).
* Copies the resulting `.so` files and Swift runtime libraries into the AAR.
* Adds the JExtract-generated Java sources to the Android `main` source set.

Because `workingDir` in the build tasks points to `../MySharedLib`, the same `Package.swift` that Xcode uses is the single source of truth.

---

## Troubleshooting

**New Swift code is not visible in Java after a build**  
Delete the Swift `.build` folder and rebuild:
```bash
rm -rf shared-swift-package/MySharedLib/.build
./gradlew :shared-swift-package-shared-lib-android:assembleDebug
```

**Crash: `UnsatisfiedLinkError: library "libswiftXxx.so" not found`**  
Add the missing library name to the `swiftRuntimeLibs` list in `shared-lib-android/build.gradle`.  
For example, to add `swiftObservation`:
```groovy
def swiftRuntimeLibs = [
    // ... existing entries ...
    "swiftObservation",   // <-- add this
]
```
