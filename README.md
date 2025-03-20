# Firebase App Distribution Integration in Flutter

## 📌 Overview
This task integrates **Firebase App Distribution** into a Flutter application to facilitate **beta testing**. By distributing pre-release versions to a group of testers, we can gather feedback before launching the final version.

## 🛠 What the Code Does
- **Creates a Firebase project** and links it with the Flutter app.
- **Adds the google-services.json** file to configure Firebase services.
- **Installs necessary dependencies** for Firebase initialization.
- **Initializes Firebase in the Flutter project** to enable app distribution.

## ⚙️ How the Code Works
### 1️⃣ Setting Up Firebase
- Go to the **Firebase Console** and create a new project.
- Add an **Android app** to the Firebase project.
- Download the `google-services.json` file and place it inside the `android/app` directory.

### 2️⃣ Installing Dependencies
Add the required Firebase packages in `pubspec.yaml`:
```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: latest_version
  firebase_app_distribution: latest_version
```
Then, run:
```sh
flutter pub get
```

### 3️⃣ Initializing Firebase in the Project
Modify `main.dart` to initialize Firebase:
```dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
```

### 4️⃣ Distributing the App
- Build the app release version:
```sh
flutter build apk --release
```
- Upload the APK to Firebase App Distribution using Firebase CLI:
```sh
firebase appdistribution:distribute path/to/your/app-release.apk \
  --app your-app-id \
  --groups your-tester-group
```

## 🎯 Conclusion
With Firebase App Distribution, testers can easily access and test new versions of the Flutter app before the final release. This improves the overall quality and stability of the application. 🚀

