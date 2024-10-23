
# Advance Flutter Exam

This Flutter app integrates Firebase and SQLite for backend services and allows navigation between three pages: Home, Fetch, and Firebase Fetch. It uses named routes for easy page transitions and supports local data storage with SQLite.

## Features

- Firebase initialization
- Three pages: Home, Fetch, and Firebase Fetch
- Named route navigation

## Setup

1. Set up Firebase for your project.
2. Configure `firebase_options.dart` using Firebase CLI (`flutterfire configure`).
3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Run the app:

   ```bash
   flutter run
   ```

## Navigation

- `/`: HomePage
- `/fetch`: FetchPage
- `/firebase`: FirebaseFetchPage
