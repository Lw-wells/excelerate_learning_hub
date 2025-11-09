📱 Excelerate Hub - Flutter App

Excelerate Hub is a mobile application built with Flutter, designed to help learners explore and register for upskilling programs offered through the Excelerate Initiative.

This project was developed as part of the Excelerate Virtual Internship (Mobile App Development with Flutter) program.

🚀 Project Overview

The app provides a clean, interactive, and user-friendly interface that allows users to:

🔐 Sign in to access their personalized dashboard.

🧭 Browse through available training programs.

📄 View detailed information about each program.

🔁 Seamlessly navigate across multiple screens with dynamic data handling.

This repository currently represents the Functional UI Prototype (Milestone 2) — with plans for integration of backend APIs, authentication, and database connectivity in the next phase.

🧱 App Structure
📂 Folder Organization
lib/
│
├── main.dart                     # Entry point
│
├── models/
│   └── program.dart               # Program model definition
│
├── screens/
│   ├── sign_in_screen.dart        # Login interface
│   ├── home_screen.dart           # Landing page after login
│   ├── program_listing_screen.dart # Displays list of programs
│   └── program_details_screen.dart # Shows program details
│
└── assets/
    └── profile.jpg                # Placeholder user image

🧭 Navigation Flow
Sign In Screen → Home Screen → Program Listing Screen → Program Details Screen

🧩 Implemented Features
Feature	Description
Sign In Screen	Includes form validation and navigation on successful login.
Home Screen	Displays featured and upcoming programs; includes bottom navigation.
Program Listing	Lists all available programs dynamically.
Program Details	Displays specific program information via route arguments.
💻 Getting Started

Follow these steps to clone, install dependencies, and run the project locally.

1️⃣ Clone the Repository
git clone https://github.com/YOUR_USERNAME/excelerate-hub.git


Or fork it first via GitHub UI, then clone your fork:

git clone https://github.com/YOUR_USERNAME/excelerate-hub.git

2️⃣ Navigate to the Project Directory
cd excelerate-hub

3️⃣ Install Dependencies

Ensure you have Flutter SDK installed, then run:

flutter pub get

4️⃣ Run the App

Start the app on your emulator or connected device:

flutter run

🖼️ App Screenshots

Below are key screens from the current prototype:

🏠 Home Screen


![dashboard](https://github.com/user-attachments/assets/e75764b8-1f34-4b5c-81f2-c62ec3071897)


📚 Program Listing!

[programlisting](https://github.com/user-attachments/assets/a8bb7fe5-7871-4fc3-a8d7-d7cc6d38f331)



📄 Program Details


![overview program](https://github.com/user-attachments/assets/a9e495eb-45eb-42b7-8523-b1cd72d42a1c)


🔐 Sign In Screen


![Signup screen](https://github.com/user-attachments/assets/428b4655-822d-415e-a959-c7cda6916445)


🧠 Next Steps

Planned improvements include:

✅ Integration with Firebase Authentication

✅ Dynamic data fetching from Firestore

✅ Program registration and progress tracking

✅ Improved UI consistency and state management (Provider/Bloc)

🤝 Contributing

We welcome contributions!
If you’d like to enhance the app, follow these steps:

Fork the repo

Create a new branch (git checkout -b feature-name)

Commit your changes (git commit -m 'Add new feature')

Push to your branch (git push origin feature-name)

Open a Pull Request

🧑‍💻 Team

This app was developed by:

Stanley Wells (Team Lead / Flutter Developer)

[Add team members if applicable]

📄 License

This project is licensed under the MIT License
.
