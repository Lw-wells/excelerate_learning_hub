# 📱 Excelerate Hub - Flutter App

Excelerate Hub is a mobile application designed to help learners explore and register for various upskilling programs under the Excelerate initiative.  
This project is being developed as part of the **Excelerate Virtual Internship (Mobile App Development with Flutter)**.

---

## 🚀 Project Overview

The app provides a simple, interactive, and elegant interface that allows users to:
- Sign in to access their personalized dashboard.
- View available training programs.
- Explore detailed information about each program.
- Seamlessly navigate between screens.

This repository currently represents the **Week 2 Deliverable: Functional UI Prototype**.

---

## 🧱 App Structure

### Implemented Screens

1. **Sign In Screen**
   - Clean login interface with form validation.
   - On successful login, navigates to the Home Screen.

2. **Home Screen**
   - Displays featured and upcoming programs.
   - “View All Programs” button links to the Program Listing screen.
   - Includes bottom navigation for future features.

3. **Program Listing Screen**
   - Shows a scrollable list of all available programs.
   - Each program card includes title, duration, and a “View Details” button.

4. **Program Details Screen**
   - Displays detailed information about a selected program.
   - Receives data dynamically via route arguments.

---

5. **Folder Structure**
   lib/
│
├── main.dart                     # Entry point
│
├── models/
│   └── programs.dart             # Program model definition
│
├── screens/
│   ├── sign_in_screen.dart
│   ├── home_screen.dart
│   ├── program_listing_screen.dart
│   └── program_details_screen.dart
│
└── assets/
    └── profile.jpg               # Placeholder user image

**Screenshots of the prototype**

Homepage
<img width="501" height="935" alt="image" src="https://github.com/user-attachments/assets/064458b7-3fd0-4aa4-a82e-3757fbec6c8e" />

Programs
<img width="501" height="935" alt="image" src="https://github.com/user-attachments/assets/61f3ba93-fc3c-48f7-9124-7abee5c4314c" />


## 🔗 Navigation Flow

```plaintext
Sign In Screen → Home Screen → Program Listing Screen → Program Details Screen

