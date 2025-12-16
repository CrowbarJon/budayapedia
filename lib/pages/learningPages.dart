// lib/pages/learning_page.dart

import 'package:flutter/material.dart';
// Import Model Course dari file tunggal
import 'course_model.dart';
// Import Model ModuleContent dari file tunggal
import 'module_content_model.dart'; 

// Import data modul
import '../data/minangkabau.dart';
import '../data/tari_keraton.dart';
import '../data/dayak.dart';
import '../data/papeda.dart';

// >>> IMPORT UNTUK QUIZ <<<
import 'quiz_pages.dart'; 
import '../quizz/minangkabau_quiz.dart'; 
import '../quiz_model.dart'; 
// Asumsikan data kuis lain akan diimpor di sini:
// import '../quizzes/tari_keraton_quiz.dart';
// ...
// >>> END IMPORT UNTUK QUIZ <<<


const Color primaryColor = Color(0xFF2C3E50);
const Color darkTextColor = Color(0xFF1E2A3B);
const Color lightTextColor = Color(0xFF5A6B80);
const Color accentColor = Color(0xFFFFA000);
const Color correctColor = Color(0xFF27AE60); // Hijau untuk ikon selesai

class LearningPage extends StatefulWidget {
    final Course course;

    const LearningPage({super.key, required this.course});

    @override
    _LearningPageState createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> {
    // Variabel state untuk navigasi dan tracking
    int _activeModuleIndex = 0;
    late List<bool> _moduleCompleted; 

    @override
    void initState() {
        super.initState();
        // Inisialisasi status kelulusan (semua false)
        _moduleCompleted = List<bool>.filled(courseModules.length, false);
    }

    // --- FUNGSI HILANG: DIDEFINISIKAN KEMBALI DI DALAM STATE ---
    List<ModuleContent> get courseModules {
        if (widget.course.title.contains('Minangkabau')) {
            return minangkabauModules;
        } else if (widget.course.title.contains('Tari Klasik Keraton Jawa')) {
            return tariKeratonModules;
        } else if (widget.course.title.contains('Suku Dayak')) {
            return dayakModules;
        } else if (widget.course.title.contains('Papeda')) {
            return papedaModules;
        }
        return [];
    }
    
    // PERBAIKAN: Indexing Sidebar Minangkabau
    List<Map<String, dynamic>> get sidebarSections {
        // Logika Papeda, Dayak, Tari Keraton (Tidak diubah)
        
        // Default: Struktur Minangkabau (INDEXING DIPERBAIKI)
        return const [
            {'title': 'COURSE OVERVIEW', 'start_index': 0, 'end_index': 0},
            // Modul 1 (3 item: Index 1, 2, 3)
            {'title': 'MODUL 1: STRUKTUR SOSIAL', 'start_index': 1, 'end_index': 3}, 
            // Modul 2 (2 item: Index 4, 5)
            {'title': 'MODUL 2: PERAN ADAT', 'start_index': 4, 'end_index': 5},
            // Quiz Modul 1 & 2 (1 item: Index 6)
            {'title': 'QUIZ MODUL 1 & 2', 'start_index': 6, 'end_index': 6},
            // Modul 3 (3 item: Index 7, 8, 9)
            {'title': 'MODUL 3: RUMAH GADANG', 'start_index': 7, 'end_index': 9},
            // Modul 4 (2 item: Index 10, 11)
            {'title': 'MODUL 4: UPACARA ADAT', 'start_index': 10, 'end_index': 11},
            // Final Assessment (1 item: Index 12)
            {'title': 'SUMMARY AND FINAL ASSESSMENT', 'start_index': 12, 'end_index': 12}, 
        ];
    }

    Widget _buildSidebarItem(int index, ModuleContent content) {
        bool isActive = index == _activeModuleIndex;
        bool isCompleted = index < _moduleCompleted.length ? _moduleCompleted[index] : false; 
        IconData leadingIcon = content.isQuiz ? Icons.quiz : Icons.menu_book;

        return Container(
            margin: const EdgeInsets.only(bottom: 2),
            decoration: BoxDecoration(
                color: isActive ? primaryColor.withOpacity(0.1) : Colors.transparent,
                borderRadius: BorderRadius.circular(5),
            ),
            child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                leading: Icon(
                    leadingIcon,
                    color: isActive ? primaryColor : (isCompleted ? correctColor : Colors.grey.shade700),
                ),
                title: Text(
                    content.title,
                    style: TextStyle(
                        fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                        color: isActive ? primaryColor : darkTextColor,
                        fontSize: 14,
                    ),
                ),
                trailing: Icon(
                    isCompleted ? Icons.check_circle : Icons.radio_button_off, 
                    color: isCompleted ? correctColor : Colors.grey
                ),
                onTap: () {
                    setState(() {
                        _activeModuleIndex = index;
                    });
                    Navigator.pop(context);
                },
            ),
        );
    }

    Widget _buildDrawerContent() {
        if (courseModules.isEmpty) {
             return const Drawer(width: 300, child: Center(child: Text("Modul tidak ditemukan")));
        }

        double completedModules = _moduleCompleted.where((c) => c).length.toDouble();
        double totalModules = courseModules.length.toDouble();
        double progress = totalModules > 0 ? completedModules / totalModules : 0;
        
        return Drawer(
            width: 300,
            child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                    top: 40.0, left: 16.0, right: 16.0, bottom: 50.0,
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        // Progress Bar 
                        const Text(
                            'PROGRESS', style: TextStyle(fontSize: 12, color: lightTextColor),
                        ),
                        const SizedBox(height: 4),
                        LinearProgressIndicator(
                            value: progress,
                            backgroundColor: Colors.grey.shade300,
                            color: accentColor,
                        ),
                        const SizedBox(height: 4),
                        Text(
                            '${(progress * 100).toStringAsFixed(0)}% COMPLETE',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14, color: primaryColor,
                            ),
                        ),
                        const Divider(height: 30, thickness: 1),

                        // Daftar Modul dengan Header Pengelompokan
                        ...sidebarSections.map((section) {
                            List<Widget> items = [];

                            items.add(
                                Padding(
                                    padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
                                    child: Text(
                                        '▼ ${section['title']}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold, fontSize: 13, color: darkTextColor,
                                        ),
                                    ),
                                ),
                            );

                            for (
                                int i = section['start_index'];
                                i <= section['end_index'];
                                i++
                            ) {
                                if (i < courseModules.length) {
                                    items.add(_buildSidebarItem(i, courseModules[i]));
                                }
                            }
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: items,
                            );
                        }).toList(),
                    ],
                ),
            ),
        );
    }


    Widget _buildMainContent() {
        if (courseModules.isEmpty || _activeModuleIndex >= courseModules.length) {
            return const Center(child: Text('Konten modul tidak tersedia.', style: TextStyle(color: darkTextColor)));
        }

        final activeItem = courseModules[_activeModuleIndex];
        int totalModules = courseModules.length;
        int lessonNumber = _activeModuleIndex + 1;
        String lessonCount = 'Lesson $lessonNumber of $totalModules';
        
        // ... (Logika konten utama)

        return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    // Header Konten
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            Flexible(
                                child: Text(
                                    activeItem.contentTitle,
                                    style: const TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w900,
                                        color: darkTextColor,
                                    ),
                                ),
                            ),
                            if (!activeItem.isQuiz)
                                Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(lessonCount, style: const TextStyle(fontSize: 14, color: lightTextColor)),
                                ),
                        ],
                    ),
                    const Divider(height: 30),
                    
                    // Area Video Player/Konten Visual (Placeholder)
                    Container( /* ... */ ),
                    const SizedBox(height: 20),

                    // Teks Materi
                    SingleChildScrollView(
                        child: Text(activeItem.contentText, style: const TextStyle(fontSize: 16, height: 1.5, color: darkTextColor)),
                    ),
                    const SizedBox(height: 40),

                    // --- TOMBOL NAVIGASI LANJUT (FIXED LOGIKA NAVIGASI) ---
                    if (activeItem.isQuiz)
                        ElevatedButton(
                            onPressed: () async { 
                                QuizData? quizToLoad;

                                // LOGIKA PEMILIHAN QUIZ (Hanya Minangkabau yang memiliki data kuis di sini)
                                if (widget.course.title.contains('Minangkabau')) {
                                    if (activeItem.title.contains('Modul 1 & 2')) {
                                        quizToLoad = minangkabauQuiz1;
                                    } else if (activeItem.title.contains('Final Assessment') || activeItem.title.contains('SUMMARY')) {
                                        quizToLoad = minangkabauQuizFinal;
                                    }
                                } 
                                
                                if (quizToLoad != null) {
                                    // Tunggu hasil kuis (true jika lulus)
                                    final bool? quizPassed = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => QuizPage(quizData: quizToLoad!),
                                        ),
                                    );
                                    
                                    // FIXED NAVIGASI: Jika kuis lulus (quizPassed == true), lanjut modul
                                    if (quizPassed == true) {
                                        setState(() {
                                            if (_activeModuleIndex < totalModules) {
                                                _moduleCompleted[_activeModuleIndex] = true; // Tandai kuis selesai
                                                _activeModuleIndex++; // Pindah ke modul berikutnya
                                            }
                                        });
                                    }
                                } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text("Data kuis belum tersedia untuk modul ini.")),
                                    );
                                }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                minimumSize: const Size(double.infinity, 45),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text('Mulai Kuis Sekarang', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        )
                    // Tombol Lanjut ke Modul Berikutnya (Non-Kuis)
                    else if (_activeModuleIndex < totalModules - 1)
                        ElevatedButton(
                            onPressed: () {
                                setState(() {
                                    _moduleCompleted[_activeModuleIndex] = true; // Tandai modul selesai
                                    _activeModuleIndex++;
                                });
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: accentColor,
                                minimumSize: const Size(double.infinity, 45),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text('Lanjut ke Modul Berikutnya', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        )
                    // Tombol Selesaikan Kursus (Modul Terakhir)
                    else if (_activeModuleIndex == totalModules - 1)
                        ElevatedButton(
                            onPressed: () {
                                setState(() {
                                    _moduleCompleted[_activeModuleIndex] = true; 
                                });
                                // Pop ke halaman home (root)
                                Navigator.popUntil(context, (route) => route.isFirst);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green.shade600,
                                minimumSize: const Size(double.infinity, 45),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text('Selesaikan Kursus', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                ],
            ),
        );
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text(widget.course.title, style: const TextStyle(color: darkTextColor, fontWeight: FontWeight.bold)),
                centerTitle: false,
                backgroundColor: Colors.white,
                elevation: 1,
                actions: [
                    TextButton(
                        onPressed: () {
                            // FIXED STATE LOSS: Pop kembali ke halaman Home (root)
                            // Jika Anda ingin mempertahankan state, Anda harus menyimpan _activeModuleIndex di database/SharedPrefs saat ini, 
                            // tetapi untuk tujuan navigasi, kita pop ke root.
                            Navigator.pop(context); 
                        },
                        child: const Text('EXIT COURSE', style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
                    ),
                ],
            ),
            drawer: _buildDrawerContent(),
            body: SingleChildScrollView(child: _buildMainContent()),
        );
    }
}