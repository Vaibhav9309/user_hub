📱 Flutter Developer Assignment – User List App
🧩 Overview

A Flutter application demonstrating state management (BLoC), REST API integration, pagination, search, and responsive UI/UX following Clean Architecture principles.
The app fetches user data from the ReqRes API
and supports offline caching, pull-to-refresh, infinite scrolling, and error handling for real-world reliability.

🚀 Features
Feature	Description
👥 User List Screen	Displays users with name, email, and avatar
🔍 Search Users	Filter users by name in real time
♻️ Pagination	Infinite scrolling using API page queries
📄 User Detail Screen	Shows user details like name, email, and phone
🧭 Navigation	Seamless transition between list and detail screens
🔄 Pull to Refresh	Refresh user data instantly
🌗 Light & Dark Mode	Dynamic theme switching
⚡ Caching (SharedPreferences)	Local storage for offline access
📡 Error Handling	Dedicated UI for loading, empty, and error states
🌍 Offline Support	Displays retry option when network is unavailable
🧱 Clean Architecture	Modular separation of presentation, domain, and data layers
🧠 Dependency Injection	Managed using get_it
🧪 Optional Tests	Includes structure for widget and API tests
🧰 Tech Stack
Category	Library
State Management	flutter_bloc

Networking	http

Dependency Injection	get_it

Caching	shared_preferences

UI Components	Flutter Material Widgets
Architecture	Clean Architecture (Presentation → Domain → Data)
📦 Folder Structure
lib/
├── core/
│   ├── constants/
│   ├── theme/
│   └── utils/
│
├── data/
│   ├── models/
│   ├── repositories/
│   └── services/
│
├── domain/
│   ├── entities/
│   └── usecases/
│
├── presentation/
│   ├── bloc/
│   │   ├── user_list/
│   │   └── user_detail/
│   ├── screens/
│   │   ├── user_list_screen.dart
│   │   └── user_detail_screen.dart
│   └── widgets/
│
└── main.dart

⚙️ Getting Started
Prerequisites

Flutter SDK (latest stable version)

Android Studio / VS Code

A connected device or emulator

Installation
# Clone the repository
git clone https://github.com/Vaibhav9309/user_hub.git

# Navigate to the project directory
cd flutter-user-list-app

# Install dependencies
flutter pub get

# Run the application
flutter run

🧪 API Endpoint

Base URL: https://reqres.in/api/users

Example: https://reqres.in/api/users?per_page=10&page=1

User Detail

📥 Download Release APK: https://drive.google.com/file/d/1BC-TPvIfxQhcP7xhEhnEKctWPQBLuvlP/view?usp=sharing

(Uploaded for review and testing)


⚡ Problem Scenarios Handled
Scenario	Behavior
⏳ Slow API Response	Displays loading indicator and timeout handling
📶 No Internet	Shows offline message with retry button
🕳️ Empty Response	Displays “No users found” UI
🔎 Search Edge Cases	Handles special characters and spaces
🔙 Navigation	Ensures proper state cleanup and memory safety
📱 Responsiveness	Adapts layout for multiple screen sizes
🧹 Cache Management	Clears outdated data on refresh
📱 Screens Overview

(Replace placeholders with actual screenshots)

Screen	Light Mode	Dark Mode
User List


📄 Evaluation Criteria
Criteria	Weight
Code Quality & Structure	30%
Functionality & Features	30%
UI/UX Design & Responsiveness	20%
Error Handling & Optimization	10%
Bonus (Tests)	10%
👨‍💻 Author

Developer: Vaibhav Shelke
📧 vaibhavshelke2901@gmail.com
🌐 GitHub – Vaibhav9309
🏙️ Nashik, India