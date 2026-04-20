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
  String? _selectedAnswer;

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
      _selectedAnswer = selected;

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
        _selectedAnswer = null;
      });
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Quiz Completed 🎉"),
          content: Text("Your Score: $_score / ${_questions.length}"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                restartQuiz();
              },
              child: const Text("Restart"),
            ),
          ],
        ),
      );
    }
  }

  void restartQuiz() {
    setState(() {
      _currentIndex = 0;
      _score = 0;
      _answered = false;
      _selectedAnswer = null;
    });
  }

  Color getButtonColor(String option) {
    if (!_answered) return Colors.blue;

    if (option == _questions[_currentIndex].correctAnswer) {
      return Colors.green;
    } else if (option == _selectedAnswer) {
      return Colors.red;
    }
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final question = _questions[_currentIndex];

    double progress = (_currentIndex + 1) / _questions.length;

    return Scaffold(
      appBar: AppBar(title: const Text("Quiz App")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Question Counter
              Text(
                "Question ${_currentIndex + 1} / ${_questions.length}",
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500),
              ),

              const SizedBox(height: 10),

              // Progress Bar
              LinearProgressIndicator(value: progress),

              const SizedBox(height: 20),

              // Question Text
              Text(
                question.question,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // Answer Buttons
              ...question.options.map((option) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: getButtonColor(option),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed:
                          _answered ? null : () => checkAnswer(option),
                      child: Text(
                        option,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                );
              }),

              const SizedBox(height: 20),

              // Next Button
              ElevatedButton(
                onPressed: nextQuestion,
                child: const Text("Next"),
              ),

              const SizedBox(height: 15),

              // Score
              Text(
                "Score: $_score",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}