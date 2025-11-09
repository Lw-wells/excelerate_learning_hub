

````markdown
# 📱 Excelerate Hub - Flutter App  

Excelerate Hub is a mobile application built with **Flutter**, designed to help learners explore and register for upskilling programs offered through the **Excelerate Initiative**.  

This project was developed as part of the **Excelerate Virtual Internship (Mobile App Development with Flutter)** program.  

---

## 🚀 Project Overview  

The app provides a clean, interactive, and user-friendly interface that allows users to:  
- 🔐 Sign in to access their personalized dashboard.  
- 🧭 Browse through available training programs.  
- 📄 View detailed information about each program.  
- 🔁 Seamlessly navigate across multiple screens with dynamic data handling.  

This repository currently represents the **Functional Prototype** — having integrated Firebase Authentication & Firestore Database. 

---

## 🧱 App Structure  

### 📂 Folder Organization  

```plaintext
lib/
│
├── main.dart                     # Entry point
│
├── models/
│   └── program.dart               # Program model definition
│
├── screens/
|   |-- splashscreen.dart
│   ├── sign_in_screen.dart        # Login interface
│   ├── home_screen.dart           # Landing page after login
│   ├── program_listing_screen.dart # Displays list of programs
│   └── program_details_screen.dart # Shows program details
│
└── assets/
    └── profile.jpg                # Placeholder user image
    |__ web.jpg
    -   mobile.jpg
    -   datascience.jpg
    -   uxui.jpg
    -   project.jpg
    -   javascript.jpg
    -   profile.jpg
    -   ai.jpg
    -   softwaretesting.jpg
    -   person1.jpg
    -   excelerate.jpeg
    -   data/programs.json
    -   google.png
    -   profile.png
````

### 🧭 Navigation Flow

```plaintext
Splash Screen → Sign In Screen → Home Screen → Program Listing Screen → Program Details Screen
```

---

## 🧩 Implemented Features

| Feature             | Description                                                          |
| ------------------- | -------------------------------------------------------------------- |
| **Splash Screen**   | Displays app logo and routes to authentication.                      |
| **Sign In Screen**  | Includes form validation and navigation on successful login.         |
| **Home Screen**     | Displays featured and upcoming programs; includes bottom navigation. |
| **Program Listing** | Lists all available programs dynamically.                            |
| **Program Details** | Displays specific program information via route arguments.           |

---

## 💻 Getting Started

Follow these steps to **clone, install dependencies, and run** the project locally.

### 1️⃣ Clone the Repository

```bash
git clone (https://github.com/Lw-wells/excelerate_learning_hub.git)
```

Or fork it first via GitHub UI, then clone your fork:

```bash
git clone (https://github.com/Lw-wells/excelerate_learning_hub.git)
```

---

### 2️⃣ Navigate to the Project Directory

```bash
cd excelerate_learning_hub
```

---

### 3️⃣ Install Dependencies

Ensure you have Flutter SDK installed, then run:

```bash
flutter pub get
```

---

### 4️⃣ Run the App

Start the app on your emulator or connected device:

```bash
flutter run
```

---

## 🔥 Firebase Setup

Follow these steps to integrate Firebase for authentication and backend data management.

### 1️⃣ Create a Firebase Project

* Visit [Firebase Console](https://console.firebase.google.com/)
* Click **“Add Project”** → Name it `excelerate_learning_hub` → Continue

---

### 2️⃣ Add Android App

* In Firebase Console, click **“Add App” → “Android”**
* Enter your package name (found in `android/app/build.gradle`, e.g., `com.example.excelerate_app`)
* Download the generated `google-services.json` file
* Place it inside:

  ```
  android/app/google-services.json
  ```

---

### 3️⃣ Add iOS App *(Optional)*

* Add your iOS bundle ID
* Download `GoogleService-Info.plist`
* Place it under:

  ```
  ios/Runner/GoogleService-Info.plist
  ```

---

### 4️⃣ Configure Gradle Files

In `android/build.gradle`:

```gradle
dependencies {
    classpath 'com.google.gms:google-services:4.4.2'
}
```

In `android/app/build.gradle`:

```gradle
apply plugin: 'com.google.gms.google-services'
```

---

### 5️⃣ Initialize Firebase in Flutter

In `main.dart`:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
```

---

### 6️⃣ (Optional) Enable Google Sign-In

In Firebase Console:

* Go to **Authentication → Sign-in method**
* Enable **Google** provider
* Add your SHA-1 key (from Android Studio > Gradle > Signing Report)

In Flutter, add the package:

```bash
flutter pub add google_sign_in
```

---

## 🖼️ App Screenshots

Below are key screens from the current prototype.
You can replace the placeholders with updated screenshots as development progresses.

### SplashScreen

![splashscreen](https://github.com/user-attachments/assets/1f0fd1e9-9835-415e-a314-7c0c2a87c593)


### 🏠 Home Screen

![Home Screen](https://github.com/user-attachments/assets/064458b7-3fd0-4aa4-a82e-3757fbec6c8e)

### 📚 Program Listing

![Program Listing](https://github.com/user-attachments/assets/61f3ba93-fc3c-48f7-9124-7abee5c4314c)

### 📄 Program Details

![overview program](https://github.com/user-attachments/assets/5567093d-8e88-4a47-969a-ed04bb69c125)


### 🔐 Sign In Screen

![Signup screen](https://github.com/user-attachments/assets/225c633a-bc72-4f75-8148-f23fe34dbb02)


---

## 🧠 Next Steps

Planned improvements include:

* ✅ Integration with **Firebase Authentication & Firestore**
* ✅ Google Sign-In support
* ✅ User profile & saved programs
* ✅ Program registration and progress tracking
* ✅ UI restructuring for maintainability
* ✅ Provider or Bloc for state management

---

## 📽️ Live Demo 

🎥 **[Watch Demo Video]([YOUTUBE_VIDEO_LINK](https://youtu.be/IrN-ZfcVf0I?si=NrzBMfoKd15ROrsm))**
---

## 🤝 Contributing

We welcome contributions!
If you’d like to enhance the app, follow these steps:

1. **Fork** the repo
2. **Create a new branch** (`git checkout -b feature-name`)
3. **Commit your changes** (`git commit -m 'Add new feature'`)
4. **Push to your branch** (`git push origin feature-name`)
5. **Open a Pull Request**

---

## 🧑‍💻 Team

This app was developed by:

* **Stanley Wells** (Team Lead / Flutter Developer)
* **Divyanshu Singh** (Documentation)

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).

