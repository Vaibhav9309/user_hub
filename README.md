📱 Flutter Developer Assignment – User List App
🧩 Overview

This Flutter application demonstrates state management (Bloc), API integration, pagination, search functionality, and clean UI/UX design following best Flutter architecture practices.
The app fetches users from the public API https://reqres.in/api/users
and displays them with pagination, caching, pull-to-refresh, and error handling.

🚀 Features
Feature	Description
👥 User List Screen	Displays list of users with name, email, and profile picture
🔍 Search Users	Filter users by name using a search bar
♻️ Pagination	Infinite scrolling with incremental API page loading
📄 User Detail Screen	Shows user profile, name, email, phone, website, and company
🧭 Navigation	Smooth navigation between List and Detail screens
🔄 Pull to Refresh	Refresh the list with updated data
🌗 Light & Dark Mode	Adaptive theme support with toggle
⚡ Caching (SharedPreferences)	Stores user data locally for offline access
📡 Error Handling	Graceful UI states for loading, empty, and failure scenarios
🌍 Offline Support	Displays retry button on network failure
🧱 Clean Architecture	Follows presentation → domain → data layer separation
🧠 Dependency Injection	Managed via get_it
🧪 Optional Tests	Includes widget and API test structure (optional)
🧰 Tech Stack
Category	Library
State Management	flutter_bloc

Networking	http

Dependency Injection	get_it

Caching	shared_preferences

UI Components	Flutter Material Widgets
Architecture	Clean Architecture (Presentation, Domain, Data Layers)
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

⚙️ How to Run the Project
Prerequisites

Flutter SDK (latest stable version)

Android Studio / VS Code

Device or Emulator setup

Steps
# Clone the repository
git clone https://github.com/YOUR_GITHUB_USERNAME/flutter-user-list-app.git

# Navigate to project directory
cd flutter-user-list-app

# Install dependencies
flutter pub get

# Run the project
flutter run

🧪 API Endpoint Used

Base URL:
https://reqres.in/api/users

Example:
https://reqres.in/api/users?per_page=10&page=1

🧩 Problem Scenarios Handled
Scenario	Behavior
⏳ Slow API Response	Shows loading spinner with timeout handling
📶 No Internet	Displays error message with retry button
🕳️ Empty Response	Displays friendly “No users found” message
🔎 Search Edge Cases	Works for special characters/spaces
🔙 Navigation	Maintains proper state without leaks
📱 Responsiveness	Adapts layout for all screen sizes
🧹 Cache Management	Clears outdated cached data on refresh
🧭 Screens Overview
Screen	Light Mode	Dark Mode
User List


User Detail


(Replace with actual screenshots from your app if possible)

📥 APK Download

👉 Download Release APK

(Uploaded on OneDrive for quick access)

📄 Evaluation Criteria Reference
Criteria	Weight
Code Quality & Structure	30%
Functionality & Features	30%
UI/UX Design	20%
Error Handling & Optimization	10%
Bonus (Tests)	10%
🧑‍💻 Author

Developer: Vaibhav Shelke
📧 Email: vaibhavshelke2901@gmail.com
🌐 GitHub: Vaibhav9309
🏙️ Location: Nashik, India