# Single App + Swift Package Template

This folder is a standalone Android project template with exactly two modules:

- `app`: main Android application (Kotlin + Compose)
- `swift-lib`: Swift package compiled for Android and consumed by `app`

It is derived from `hello-swift-java` and reduced to the minimum structure needed for one app and one Swift package.

## Project structure

```text
single-app-swift-template/
├── app/
├── swift-lib/
├── gradle/
├── gradlew
├── gradlew.bat
├── settings.gradle.kts
└── build.gradle.kts
```

## Prerequisites

- Android SDK
- JDK (JDK 25 needed for local swift-java artifact publishing)
- [Swiftly](https://www.swift.org/install/)
- Swift SDK for Android compatible with your Swift toolchain

## One-time setup

1. Resolve Swift dependencies:

   ```bash
   cd /home/runner/work/swift-android-examples/swift-android-examples/single-app-swift-template/swift-lib
   swift package resolve
   ```

2. Publish required `swift-java` artifact(s) to local Maven:

   ```bash
   ./.build/checkouts/swift-java/gradlew --project-dir .build/checkouts/swift-java :SwiftKitCore:publishToMavenLocal
   ```

3. If needed, configure Swift tool paths in:

   `/home/runner/work/swift-android-examples/swift-android-examples/single-app-swift-template/swift-lib/gradle.properties`

## Build

From template root:

```bash
cd /home/runner/work/swift-android-examples/swift-android-examples/single-app-swift-template
./gradlew :swift-lib:assembleRelease
./gradlew :app:assembleDebug
```

## Run

Open `single-app-swift-template` in Android Studio and run the `app` configuration.

## Customize

- Swift API: edit `swift-lib/Sources/SwiftHashing/SwiftHashing.swift`
- Swift-to-Java package mapping: edit `swift-lib/Sources/SwiftHashing/swift-java.config`
- Android app package/name:
  - `app/build.gradle.kts`
  - Kotlin package under `app/src/main/java/com/example/templateapp`
