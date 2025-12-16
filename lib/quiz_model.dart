// lib/quiz_model.dart

class Question {
  final String text; // Teks Pertanyaan
  final List<String> options; // Daftar Opsi Jawaban
  final String correctAnswer; // Jawaban yang Benar

  Question({
    required this.text,
    required this.options,
    required this.correctAnswer,
  });
}

class QuizData {
  final String title;
  final List<Question> questions;

  QuizData({
    required this.title,
    required this.questions,
  });
}