# builder_ip

A Dart package that simplifies connecting Flutter apps to local emulators by providing a build-time constant with the builder's IP address.

## Problem

When developing Flutter apps that interact with local emulators (e.g., Firebase Emulators), you often need to specify the emulator's IP address. While `localhost` works fine on the development machine, it won't work when running the app on a physical device.  Manually updating the IP address every time it changes is cumbersome.

## Solution

This package introduces a source code builder that automatically generates a constant with the IP address of the machine used to build the app. This allows your app to connect to emulators running on your development machine even when running on a physical device.

## Usage

1. **Add dependencies:**

   ```yaml
   dev_dependencies:
     build_runner: ^2.1.7
     builder_ip: ^1.0.0 # Replace with the latest version
   ```

2. **Create `build.yaml`:**

   ```yaml
   targets:
     $default:
       builders:
         dart_builder_ip|builder_ip:
           generate_for:
             - lib/file_that_uses_builderIp.dart  # Replace with your file
   ```

3. **Use the builder in your Dart code:**

   ```dart
   import 'file_that_uses_builderIp.builder-ip.dart';

   void main() {
     print('Builder IP: $builderIp'); 
     // Use builderIp to connect to your emulator
   }
   ```

## Example with Firebase Emulators

```dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

part 'main.builder-ip.dart'; // Import the generated file

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (kDebugMode) {
    FirebaseFirestore.instance.useFirestoreEmulator(builderIp, 8080);
    await FirebaseAuth.instance.useAuthEmulator(builderIp, 9099);
  }

  // ... rest of main function
}
```

**Remember to add `main.dart` to the `generate_for` list in your `build.yaml`.**

## How it works

The `builder_ip` package utilizes a code generation technique. During the build process, it identifies the IP address of the machine running the build and injects a constant named `builderIp` into your specified Dart file.

## Benefits

- **Simplified emulator connection:** No more manual IP updates.
- **Improved development workflow:** Focus on building your app, not configuring connections.
- **Enhanced portability:** Easily run your app on different devices without changing code.
