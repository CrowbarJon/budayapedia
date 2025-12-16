// lib/pages/quiz_page.dart

import 'package:flutter/material.dart';
import '../quiz_model.dart'; // Menggunakan path yang Anda berikan

// DEFINISI KONSTANTA WARNA (Semua yang dibutuhkan didefinisikan di sini)
const Color primaryColor = Color(0xFF2C3E50); // Navy Blue
const Color accentColor = Color(0xFFFFA000); // Orange/Amber
const Color darkTextColor = Color(0xFF1E2A3B);
const Color lightTextColor = Color(0xFF5A6B80); 
const Color correctColor = Color(0xFF27AE60); // Hijau untuk Benar
const Color incorrectColor = Color(0xFFE74C3C); // Merah untuk Salah

class QuizPage extends StatefulWidget {
    final QuizData quizData;

    const QuizPage({super.key, required this.quizData});

    @override
    _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
    int _currentQuestionIndex = 0;
    int _score = 0;
    bool _answerWasPicked = false;
    String? _selectedAnswer; // Ini diperlukan untuk menyimpan jawaban yang dipilih

    // --- LOGIKA UTAMA & NAVIGASI ---

    void _handleAnswer(String answer) {
        if (_answerWasPicked) return;

        setState(() {
            _selectedAnswer = answer; // <-- Perbaikan: Simpan jawaban yang dipilih
            _answerWasPicked = true;
            if (answer == widget.quizData.questions[_currentQuestionIndex].correctAnswer) {
                _score++;
            }
        });

        Future.delayed(const Duration(seconds: 1), () {
            if (mounted) {
                _nextQuestion();
            }
        });
    }

    void _nextQuestion() {
        setState(() {
            _selectedAnswer = null; // Reset jawaban yang dipilih
            _answerWasPicked = false;
            if (_currentQuestionIndex < widget.quizData.questions.length - 1) {
                _currentQuestionIndex++;
            } else {
                _showResultsDialog();
            }
        });
    }

    void _showResultsDialog() {
        final double passRate = 0.6; 
        final bool passed = _score >= widget.quizData.questions.length * passRate;

        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
                return AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    title: Text(passed ? '🎉 Kuis Lulus!' : '😔 Kuis Gagal!'),
                    content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                            Text(
                                'Skor Akhir Anda: $_score dari ${widget.quizData.questions.length}',
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryColor),
                            ),
                            const SizedBox(height: 10),
                            Text(
                                passed 
                                    ? 'Selamat! Anda menguasai materi ini dan dapat melanjutkan.' 
                                    : 'Skor Anda di bawah 60%. Anda harus ulangi kuis untuk melanjutkan.',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: passed ? correctColor : incorrectColor),
                            ),
                        ],
                    ),
                    actions: [
                        TextButton(
                            onPressed: () {
                                Navigator.popUntil(context, (route) => route.isFirst); 
                            },
                            child: const Text('Keluar Kursus'),
                        ),
                        if (!passed)
                            ElevatedButton(
                                onPressed: () {
                                    Navigator.pop(context); 
                                    setState(() {
                                        _currentQuestionIndex = 0;
                                        _score = 0;
                                        _answerWasPicked = false;
                                        _selectedAnswer = null;
                                    });
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: accentColor),
                                child: const Text('Ulangi Kuis', style: TextStyle(color: Colors.white)),
                            )
                        else
                            ElevatedButton(
                                onPressed: () {
                                    Navigator.pop(context, true); 
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: correctColor),
                                child: const Text('Lanjut Modul Berikutnya', style: TextStyle(color: Colors.white)),
                            ),
                    ],
                );
            }
        );
    }

    // --- WIDGET PEMBANGUN UI (DIPERBAIKI: Error Tipe Data, Visual & Typos) ---

    Widget _buildAnswerButton(String option, String correctAnswer) {
        bool isCorrect = option == correctAnswer;
        
        // Cek apakah opsi ini adalah jawaban yang diklik oleh pengguna
        bool isUserSelected = option == _selectedAnswer; 
        
        Color buttonColor = primaryColor.withOpacity(0.05); 
        Color borderColor = primaryColor.withOpacity(0.2);
        Color textColor = darkTextColor;
        
        Color? overlayColor;

        // LOGIKA SETELAH JAWABAN DIPILIH (Feedback Visual Kuat)
        if (_answerWasPicked) {
            // Menonaktifkan hover/splash untuk semua tombol
            overlayColor = const Color.fromARGB(0, 218, 7, 7); 
            borderColor = const Color.fromARGB(0, 247, 3, 3);
            
            if (isCorrect) {
                // Jawaban yang BENAR (Hijau SOLID)
                buttonColor = const Color.fromARGB(255, 39, 174, 96); 
                textColor = const Color.fromARGB(255, 39, 174, 96);
            } else if (isUserSelected) {
                // Jawaban yang DIPILIH dan SALAH (Merah SOLID)
                buttonColor = const Color.fromARGB(255, 231, 76, 60);
                textColor = const Color.fromARGB(255, 231, 76, 60);
            } 
        } 
        // LOGIKA SEBELUM JAWABAN DIPILIH (Active State)
        else if (isUserSelected) {
             buttonColor = primaryColor.withOpacity(0.2); 
             borderColor = primaryColor;
        }

        return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: ElevatedButton(
                // Tombol dinonaktifkan setelah jawaban dipilih
                onPressed: _answerWasPicked ? null : () => _handleAnswer(option), 
                style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                            color: _answerWasPicked ? Colors.transparent : borderColor, 
                            width: _answerWasPicked ? 0 : 1,
                        ),
                    ),
                    elevation: _answerWasPicked ? 2 : 0, 
                    // PERBAIKAN KRITIS: Menggunakan overlayColor di dalam styleFrom
                    overlayColor: overlayColor, 
                ),
                child: Row(
                    children: [
                        Expanded(
                            child: Text(
                                option,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: textColor,
                                ),
                            ),
                        ),
                        // Ikon Feedback
                        if (_answerWasPicked) ...[
                          if (isCorrect)
                            // Ikon Check (Putih Solid)
                            Icon(Icons.check_circle, color: const Color.fromARGB(255, 14, 238, 7), size: 24)
                          else
                            // Ikon X (Putih Solid)
                            Icon(Icons.cancel, color: const Color.fromARGB(255, 245, 3, 3), size: 24)
                        ]
                    ],
                ),
            ),
        );
    }

    @override
    Widget build(BuildContext context) {
        final currentQuestion = widget.quizData.questions[_currentQuestionIndex];
        final totalQuestions = widget.quizData.questions.length;
        final progress = (_currentQuestionIndex + 1) / totalQuestions;
        
        return Scaffold(
            appBar: AppBar(
                title: Text(widget.quizData.title, style: const TextStyle(fontWeight: FontWeight.bold, color: darkTextColor)),
                backgroundColor: Colors.white,
                elevation: 1,
                actions: [
                    Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Center(
                            child: Text(
                                'Skor: $_score',
                                style: const TextStyle(
                                    fontSize: 16, 
                                    fontWeight: FontWeight.w600, 
                                    color: primaryColor
                                ),
                            ),
                        ),
                    ),
                ],
            ),
            body: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Text(
                            'Pertanyaan ${_currentQuestionIndex + 1} dari $totalQuestions',
                            style: const TextStyle(fontSize: 14, color: accentColor, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                            value: progress,
                            backgroundColor: Colors.grey.shade300,
                            color: accentColor,
                        ),
                        const SizedBox(height: 30),

                        Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            elevation: 5,
                            child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                    currentQuestion.text,
                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: darkTextColor),
                                ),
                            ),
                        ),
                        const SizedBox(height: 30),
                        ...currentQuestion.options.map((option) => _buildAnswerButton(option, currentQuestion.correctAnswer)),
                    ],
                ),
            ),
        );
    }
}