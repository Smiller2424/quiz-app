import 'package:flutter/material.dart';
import 'api_service.dart';
import 'question.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  QuizScreenState createState() => QuizScreenState();
}

class QuizScreenState extends State<QuizScreen> {
  List<Question> _questions = [];
  int _currentIndex = 0;
  int _score = 0;
  bool _answered = false;

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  void loadQuestions() async {
    final questions = await ApiService.fetchQuestions();
    setState(() {
      _questions = questions;
    });
  }

  void checkAnswer(String selected) {
    if (_answered) return;

    setState(() {
      _answered = true;
      if (selected == _questions[_currentIndex].correctAnswer) {
        _score++;
      }
    });
  }

  void nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
        _answered = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final question = _questions[_currentIndex];

    return Scaffold(
      appBar: AppBar(title: const Text("Quiz App")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(question.question),
            const SizedBox(height: 20),

            ...question.options.map((option) {
              return ElevatedButton(
                onPressed: _answered ? null : () => checkAnswer(option),
                child: Text(option),
              );
            }),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: nextQuestion,
              child: const Text("Next"),
            ),

            Text("Score: $_score"),
          ],
        ),
      ),
    );
  }
}