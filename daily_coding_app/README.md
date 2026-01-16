#  Daily Coding Question App

A minimal, distraction-free mobile application that delivers **one curated coding problem per day**, designed to help students build **consistent problem-solving habits**.

---

##  Key Highlights

-  Secure authentication using **Firebase Auth**
-  Exactly **one coding question per day**, same for all users
-  Question locked once attempted
-  Solution revealed **only after submission**
-  Streak tracking & attempt analytics
-  Bookmark questions for later revision
-  **Codeforces API integration** (external challenge)
-  Offline-first design with local caching
-  Clean, minimal UI optimized for daily use

---

## Core Features

###  Authentication
- Email & password authentication using Firebase Auth
- Login, signup, and logout supported
- Navigation controlled by auth-state streams

---

###  Daily Question System
- One deterministic question per day
- Same question for all users on a given day
- Locked after submission to prevent skipping
- Encourages daily consistency over binge solving

---

###  Submit Before Solution
- Users submit text or pseudo-code attempts
- Official solution revealed only after submission
- Reinforces genuine problem-solving

---

###  Analytics & Streaks
- Tracks:
  - Current streak
  - Longest streak
  - Total attempts
- Displays consistency via a clean analytics screen
- Progress persists across app restarts

---

###  Bookmarks
- Bookmark important questions
- Stored locally for offline access
- Accessible anytime for revision

---

###  Codeforces Integration (Brownie Point )
- Integrates Codeforces Public API
- Displays a real competitive programming problem
- Shows:
  - Problem name
  - Difficulty rating
  - Tags (Arrays, Math, Strings, etc.)
- Opens problem directly in browser
- Read-only integration (no Codeforces login required)

---

###  Offline-First Architecture
- App works fully offline
- Local caching used for:
  - Streaks
  - Attempts
  - Bookmarks
- Internet required only for:
  - Authentication
  - Codeforces external challenge

---

##  Project Structure
lib/
- models/ # Data models
- screens/ # UI screens
- services/ # Business logic & integrations
- - auth_service.dart
- - local_storage_service.dart
- - codeforces_service.dart
- main.dart # App entry point & auth-gated 
- navigation


---

##  Tech Stack

- **Flutter** – Cross-platform UI
- **Firebase Auth** – Authentication
- **SharedPreferences** – Local storage
- **Codeforces REST API** – External problem source
- **Dart** – Programming language

---

##  Firestore Note

Firestore integration was designed and attempted.  
Due to billing constraints, the app uses a **local-first architecture** while retaining Firebase Auth.

The data layer is abstracted so cloud sync can be added later without UI changes.

---

##  Running the App

### Prerequisites
- Flutter SDK
- Android Studio / Emulator
- Firebase project with Email/Password Auth enabled

### Run
```bash
flutter pub get
flutter run
```

## Philosophy
Most coding apps overwhelm users with endless problems.
This app focuses on:
- One question. One day. One habit.

## Future Enhancements
- Cloud sync using Firestore
- Daily reminder notifications
- Streak calendar visualization
- Topic-based filtering
- Difficulty rotation