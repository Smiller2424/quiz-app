# Quiz App (Flutter API Project)

## Overview

This project is a Flutter-based quiz application that fetches real-time questions from the Open Trivia Database API and displays them in an interactive multiple-choice format. The goal of this app was to practice working with REST APIs, JSON parsing, and state management in Flutter while building a fully functional user interface.

---

## Features

* Fetches quiz questions from an external API
* Displays multiple-choice answers
* Randomizes answer order
* Tracks user score
* Disables buttons after selection
* Highlights correct (green) and incorrect (red) answers
* Progress bar and question counter
* Final score popup with restart functionality

---

## Technologies Used

* Flutter & Dart
* HTTP package (API requests)
* Open Trivia Database API
* StatefulWidget for state management

---

## How the App Works

1. The app sends a request to the Open Trivia DB API using the HTTP package.
2. The API returns quiz questions in JSON format.
3. The JSON data is converted into Dart objects using a Question model.
4. The UI displays each question with shuffled answer choices.
5. The user selects an answer, and the app updates the score and provides feedback.
6. After all questions are completed, a final score dialog is shown with an option to restart the quiz.

---

## Project Structure

```
lib/
├── main.dart          # App entry point
├── question.dart      # Data model for quiz questions
├── api_service.dart   # Handles API requests and JSON parsing
└── quiz_screen.dart   # UI and state management
```

---

## Setup Instructions

1. Clone the repository:
   git clone https://github.com/YOUR_USERNAME/quiz-app.git

2. Navigate to the project folder:
   cd quiz-app

3. Install dependencies:
   flutter pub get

4. Run the app:
   flutter run

---

## Challenges & Learning

One challenge was handling JSON data from the API and converting it into a usable format for the UI. Another was managing state correctly so that the UI updates after each answer selection. Through this project, I learned how to connect Flutter apps to APIs, structure a project cleanly, and manage dynamic data using setState().

---

## Future Improvements

* Add difficulty selection
* Add categories for quizzes
* Store high scores locally or in the cloud
* Improve UI design with animations

---



