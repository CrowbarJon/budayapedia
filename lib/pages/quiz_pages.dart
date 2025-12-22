import 'package:flutter/material.dart';
import '../quiz_model.dart';

// --- KONSTANTA WARNA (PASTIKAN SEMUA TERDEFINISI) ---
const Color primaryColor = Color(0xFF2C3E50); 
const Color accentColor = Color(0xFFFFA000); 
const Color darkTextColor = Color(0xFF1E2A3B);
const Color lightTextColor = Color(0xFF5A6B80); // <-- Variabel yang sebelumnya hilang
const Color correctColor = Color(0xFF27AE60); 
const Color incorrectColor = Color(0xFFE74C3C); 

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
    String? _selectedAnswer; 
    
    // List lokal untuk menampung soal yang diacak
    late List<Question> _shuffledQuestions;

    @override
    void initState() {
        super.initState();
        _prepareQuiz(); // Mengacak soal saat halaman pertama kali dimuat
    }

    // FUNGSI UNTUK MENGACAK SOAL DAN OPSI
    void _prepareQuiz() {
        // Clone list dari data asli agar data asli di file module tidak ikut teracak permanen
        _shuffledQuestions = List.from(widget.quizData.questions);
        
        // 1. Acak urutan soal
        _shuffledQuestions.shuffle();
        
        // 2. Acak urutan opsi jawaban di dalam setiap soal
        for (var question in _shuffledQuestions) {
            question.options.shuffle();
        }
    }

    void _handleAnswer(String answer) {
        if (_answerWasPicked) return;

        setState(() {
            _selectedAnswer = answer; 
            _answerWasPicked = true;
            // Cek jawaban berdasarkan list yang sudah diacak
            if (answer == _shuffledQuestions[_currentQuestionIndex].correctAnswer) {
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
            _selectedAnswer = null; 
            _answerWasPicked = false;
            if (_currentQuestionIndex < _shuffledQuestions.length - 1) {
                _currentQuestionIndex++;
            } else {
                _showResultsDialog();
            }
        });
    }

    void _showResultsDialog() {
        final double passRate = 0.6; 
        final bool passed = _score >= _shuffledQuestions.length * passRate;

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
                                'Skor Akhir Anda: $_score dari ${_shuffledQuestions.length}',
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
                                Navigator.pop(context); 
                                Navigator.pop(context, false); 
                            },
                            child: const Text('Keluar Kursus'),
                        ),
                        if (!passed)
                            ElevatedButton(
                                onPressed: () {
                                    Navigator.pop(context); 
                                    setState(() {
                                        _prepareQuiz(); // ACAK ULANG SOAL SAAT USER KLIK ULANGI
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
                                    Navigator.pop(context); 
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

    Widget _buildAnswerButton(String option, String correctAnswer) {
        bool isCorrect = option == correctAnswer;
        bool isUserSelected = option == _selectedAnswer; 
        
        Color buttonColor = primaryColor.withOpacity(0.05); 
        Color textColor = darkTextColor;

        if (_answerWasPicked) {
            if (isCorrect) {
                buttonColor = correctColor; 
                textColor = Colors.white;
            } else if (isUserSelected) {
                buttonColor = incorrectColor;
                textColor = Colors.white;
            } 
        } 

        return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: ElevatedButton(
                onPressed: _answerWasPicked ? null : () => _handleAnswer(option), 
                style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    disabledBackgroundColor: buttonColor, 
                    padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                ),
                child: Row(
                    children: [
                        Expanded(
                            child: Text(
                                option,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: _answerWasPicked && (isCorrect || isUserSelected) ? Colors.white : textColor,
                                ),
                            ),
                        ),
                        if (_answerWasPicked) ...[
                          if (isCorrect)
                            const Icon(Icons.check_circle, color: Colors.white, size: 24)
                          else if (isUserSelected)
                            const Icon(Icons.cancel, color: Colors.white, size: 24)
                        ]
                    ],
                ),
            ),
        );
    }

    @override
    Widget build(BuildContext context) {
        // PENTING: Gunakan _shuffledQuestions agar yang tampil adalah soal yang sudah diacak
        final currentQuestion = _shuffledQuestions[_currentQuestionIndex];
        final totalQuestions = _shuffledQuestions.length;
        final progress = (_currentQuestionIndex + 1) / totalQuestions;
        
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
                title: Text(widget.quizData.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                backgroundColor: Colors.white,
                foregroundColor: darkTextColor,
                elevation: 0,
            ),
            body: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        LinearProgressIndicator(
                            value: progress,
                            backgroundColor: Colors.grey.shade200,
                            color: accentColor,
                            minHeight: 8,
                        ),
                        const SizedBox(height: 20),
                        Text(
                            'Pertanyaan ${_currentQuestionIndex + 1} / $totalQuestions',
                            style: const TextStyle(
                                color: lightTextColor, // Sudah tidak error karena variabel sudah ada
                                fontWeight: FontWeight.bold
                            ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                            currentQuestion.text,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: darkTextColor),
                        ),
                        const SizedBox(height: 30),
                        // Menampilkan opsi jawaban dari currentQuestion (yang sudah diacak di _prepareQuiz)
                        ...currentQuestion.options.map((option) => _buildAnswerButton(option, currentQuestion.correctAnswer)),
                    ],
                ),
            ),
        );
    }
}