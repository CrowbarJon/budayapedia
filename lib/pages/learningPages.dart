// lib/pages/learning_page.dart - FINAL VERSION

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:math' as math;
import 'course_model.dart';
import 'module_content_model.dart'; 

// Import data modul
import '../data/minangkabau.dart';
import '../data/tari_keraton.dart';
import '../data/dayak.dart';
import '../data/papeda.dart';

// Import untuk quiz
import 'quiz_pages.dart';
import '../quiz_model.dart'; 
import '../quizz/minangkabau_quiz.dart';
import '../quizz/papeda_quiz.dart'; 
import '../quizz/dayak_quiz.dart'; 
import '../quizz/tari_keraton_quiz.dart';

const Color primaryColor = Color(0xFF2C3E50);
const Color darkTextColor = Color(0xFF1E2A3B);
const Color lightTextColor = Color(0xFF5A6B80);
const Color accentColor = Color(0xFFFFA000);
const Color correctColor = Color(0xFF27AE60);
const Color cardBg = Color(0xFFF5F7FA);

class LearningPage extends StatefulWidget {
  final Course course;

  const LearningPage({super.key, required this.course});

  @override
  _LearningPageState createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> with TickerProviderStateMixin {
  int _activeModuleIndex = 0;
  late List<bool> _moduleCompleted;
  late TabController _segmentController;
  final Map<int, bool> _flippedCards = {};
  
  String get _progressKey => 'progress_${widget.course.title}';

  @override
  void initState() {
    super.initState();
    // Inisialisasi status modul
    _moduleCompleted = List<bool>.filled(courseModules.length, false);
    _segmentController = TabController(length: 3, vsync: this);
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? savedData = prefs.getString(_progressKey);
      
      if (savedData != null) {
        List<dynamic> decoded = jsonDecode(savedData);
        setState(() {
          _moduleCompleted = decoded.map((e) => e as bool).toList();
          // Cari modul terakhir yang belum selesai
          _activeModuleIndex = _moduleCompleted.indexWhere((c) => !c);
          if (_activeModuleIndex == -1) _activeModuleIndex = 0;
        });
      }
    } catch (e) {
      debugPrint('Error loading: $e');
    }
  }

  Future<void> _saveProgress() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_progressKey, jsonEncode(_moduleCompleted));
    } catch (e) {
      debugPrint('Error saving: $e');
    }
  }

  // --- LOGIKA MENYIMPAN RIWAYAT (HISTORY) ---
  Future<void> _markCourseAsFinished() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // 1. Ambil daftar kursus yang sudah selesai
      List<String> finishedCourses = prefs.getStringList('completed_courses') ?? [];
      
      // 2. Cek apakah kursus ini sudah ada? Jika belum, tambahkan.
      if (!finishedCourses.contains(widget.course.title)) {
        finishedCourses.add(widget.course.title);
        await prefs.setStringList('completed_courses', finishedCourses);
        
        // 3. Tambah Jam Belajar (Simulasi +5 jam per course)
        int currentHours = prefs.getInt('total_study_hours') ?? 0;
        await prefs.setInt('total_study_hours', currentHours + 5);
        
        debugPrint("Course ${widget.course.title} marked as finished!");
      }
    } catch (e) {
      debugPrint("Error marking course as finished: $e");
    }
  }

  @override
  void dispose() {
    _segmentController.dispose();
    super.dispose();
  }

  // --- LOGIKA DATA DINAMIS ---

  List<ModuleContent> get courseModules {
    if (widget.course.title.contains('Minangkabau')) return minangkabauModules;
    if (widget.course.title.contains('Tari Klasik Keraton')) return tariKeratonModules;
    if (widget.course.title.contains('Suku Dayak')) return dayakModules;
    if (widget.course.title.contains('Papeda')) return papedaModules;
    return [];
  }

  // Struktur Sidebar Dinamis yang SUDAH DIPERBAIKI (Dayak & Papeda)
  List<Map<String, dynamic>> get sidebarSections {
    String title = widget.course.title;

    if (title.contains('Minangkabau')) {
      return const [
        {'title': 'OVERVIEW', 'start_index': 0, 'end_index': 0},
        {'title': 'STRUKTUR SOSIAL', 'start_index': 1, 'end_index': 2}, 
        {'title': 'PERAN ADAT', 'start_index': 3, 'end_index': 4},
        {'title': 'QUIZ 1', 'start_index': 5, 'end_index': 5},
        {'title': 'RUMAH GADANG', 'start_index': 6, 'end_index': 8},
        {'title': 'UPACARA ADAT', 'start_index': 9, 'end_index': 11},
        {'title': 'FINAL', 'start_index': 12, 'end_index': 12}, 
      ];
    } else if (title.contains('Tari Klasik Keraton')) {
      return const [
        {'title': 'PENGANTAR', 'start_index': 0, 'end_index': 0},
        {'title': 'FILOSOFI & MAKNA', 'start_index': 1, 'end_index': 2},
        {'title': 'TEKNIK DASAR', 'start_index': 3, 'end_index': 4},
        {'title': 'QUIZ TENGAH', 'start_index': 5, 'end_index': 5},
        {'title': 'BUSANA & ATRIBUT', 'start_index': 6, 'end_index': 8},
        {'title': 'STUDI KASUS', 'start_index': 9, 'end_index': 10},
        {'title': 'FINAL EXAM', 'start_index': 11, 'end_index': 11},
      ];
    } else if (title.contains('Suku Dayak')) {
      // PERBAIKAN: Index disesuaikan agar Quiz ada di index 5
      return [
        {'title': 'MATERI DASAR', 'start_index': 0, 'end_index': 4}, 
        {'title': 'QUIZ TENGAH', 'start_index': 5, 'end_index': 5},
        {'title': 'PENDALAMAN', 'start_index': 6, 'end_index': courseModules.length - 2},
        {'title': 'UJIAN AKHIR', 'start_index': courseModules.length - 1, 'end_index': courseModules.length - 1},
      ];
    } else if (title.contains('Papeda')) {
      // PERBAIKAN: Index disesuaikan agar Quiz ada di index 5
      return [
        {'title': 'RESEP & TEKNIK', 'start_index': 0, 'end_index': 4},
        {'title': 'QUIZ MASAK', 'start_index': 5, 'end_index': 5},
        {'title': 'ETIKA MAKAN', 'start_index': 6, 'end_index': courseModules.length - 2},
        {'title': 'UJIAN AKHIR', 'start_index': courseModules.length - 1, 'end_index': courseModules.length - 1},
      ];
    }
    return [];
  }

  String? _getModuleImage(int index) {
    if (!widget.course.title.contains('Minangkabau')) return null;
    
    switch (index) {
      case 1: return 'assets/course1/matrilineal.jpg';
      case 2: return 'assets/course1/nagari.jpeg';
      case 3: return 'assets/course1/adat_basandi.jpg';
      case 4: return 'assets/course1/bundo_kanduang.jpg';
      case 7: return 'assets/course1/atap_gonjong.jpg';
      default: return null;
    }
  }

  // --- WIDGET BUILDERS ---

  Widget _buildFlipCard(int cardIndex, String frontTitle, String backContent, IconData icon) {
    bool isFlipped = _flippedCards[cardIndex] ?? false;

    return GestureDetector(
      onTap: () {
        setState(() {
          _flippedCards[cardIndex] = !isFlipped;
        });
      },
      child: TweenAnimationBuilder(
        duration: const Duration(milliseconds: 400),
        tween: Tween<double>(begin: 0, end: isFlipped ? math.pi : 0),
        builder: (context, double value, child) {
          bool showBack = value > math.pi / 2;
          
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(value),
            child: Container(
              height: 180,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: showBack ? accentColor.withOpacity(0.1) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: primaryColor.withOpacity(0.2)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  if (!showBack)
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(icon, size: 48, color: primaryColor),
                          const SizedBox(height: 12),
                          Text(
                            frontTitle,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: darkTextColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Tap untuk flip',
                            style: TextStyle(fontSize: 12, color: lightTextColor),
                          ),
                        ],
                      ),
                    ),
                  if (showBack)
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..rotateY(math.pi),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Center(
                          child: SingleChildScrollView(
                            child: Text(
                              backContent,
                              style: const TextStyle(
                                fontSize: 15,
                                color: darkTextColor,
                                height: 1.6,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Icon(Icons.sync, color: lightTextColor.withOpacity(0.5), size: 20),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSegmentedTabs(List<String> paragraphs) {
    Map<String, List<String>> segments = _splitIntoSegments(paragraphs);

    return Column(
      children: [
        Container(
          height: 48,
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16), 
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(17),
          ),
          child: TabBar(
            controller: _segmentController,
            indicatorSize: TabBarIndicatorSize.tab, 
            indicatorPadding: EdgeInsets.zero, 
            indicator: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(17),
            ),
            labelColor: Colors.white,
            unselectedLabelColor: darkTextColor,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            tabs: const [
              Tab(text: 'KONSEP'),
              Tab(text: 'ANALISIS'),
              Tab(text: 'APLIKASI'),
            ],
          ),
        ),
        SizedBox(
          height: 400,
          child: TabBarView(
            controller: _segmentController,
            children: [
              _buildSegmentContent(segments['konsep']!, 0),
              _buildSegmentContent(segments['analisis']!, 1),
              _buildSegmentContent(segments['aplikasi']!, 2),
            ],
          ),
        ),
      ],
    );
  }

  Map<String, List<String>> _splitIntoSegments(List<String> paragraphs) {
    int total = paragraphs.length;
    if (total <= 3) {
      return {
        'konsep': [paragraphs.first],
        'analisis': paragraphs.length > 1 ? paragraphs.sublist(1) : [paragraphs.first],
        'aplikasi': [paragraphs.last],
      };
    }
    int konsepEnd = (total * 0.3).ceil().clamp(1, total);
    int analisisEnd = (total * 0.7).ceil().clamp(konsepEnd, total);
    return {
      'konsep': paragraphs.sublist(0, konsepEnd),
      'analisis': paragraphs.sublist(konsepEnd, analisisEnd),
      'aplikasi': paragraphs.sublist(analisisEnd, total),
    };
  }

  Widget _buildSegmentContent(List<String> content, int segmentIndex) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: content.asMap().entries.map((entry) {
          int cardIndex = segmentIndex * 100 + entry.key;
          String paragraph = entry.value;
          String title = paragraph.split('.').first;
          if (title.length > 50) title = '${title.substring(0, 50)}...';

          return _buildFlipCard(
            cardIndex,
            title,
            paragraph,
            _getSegmentIcon(segmentIndex),
          );
        }).toList(),
      ),
    );
  }

  IconData _getSegmentIcon(int index) {
    switch (index) {
      case 0: return Icons.lightbulb_outline;
      case 1: return Icons.analytics_outlined;
      case 2: return Icons.psychology_outlined;
      default: return Icons.article;
    }
  }

  Widget _buildCaseStudyCard(String title, String description) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [accentColor.withOpacity(0.1), accentColor.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: accentColor.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.cases, color: accentColor, size: 20),
              ),
              const SizedBox(width: 12),
              const Text(
                'STUDI KASUS',
                style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.bold,
                  color: accentColor, letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: darkTextColor),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(fontSize: 14, color: darkTextColor.withOpacity(0.8), height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    if (courseModules.isEmpty) {
      return const Drawer(width: 300, child: Center(child: Text("Tidak ada modul")));
    }
    double progress = _moduleCompleted.where((c) => c).length / courseModules.length;

    return Drawer(
      width: 300,
      child: Container(
        color: cardBg,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('PROGRESS', style: TextStyle(fontSize: 11, color: lightTextColor, letterSpacing: 1)),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey.shade300,
                color: accentColor,
                minHeight: 6,
                borderRadius: BorderRadius.circular(3),
              ),
              const SizedBox(height: 6),
              Text(
                '${(progress * 100).toInt()}% SELESAI',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: primaryColor),
              ),
              const Divider(height: 30, thickness: 1),
              ...sidebarSections.map((section) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 6),
                      child: Text(
                        section['title'],
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: darkTextColor, letterSpacing: 1),
                      ),
                    ),
                    for (int i = section['start_index']; i <= section['end_index']; i++)
                      if (i < courseModules.length) _buildSidebarItem(i, courseModules[i]),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSidebarItem(int index, ModuleContent content) {
    bool isActive = index == _activeModuleIndex;
    bool isCompleted = _moduleCompleted[index];

    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: isActive ? primaryColor.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        dense: true,
        leading: Icon(
          content.isQuiz ? Icons.quiz : Icons.circle,
          size: content.isQuiz ? 20 : 8,
          color: isActive ? primaryColor : (isCompleted ? correctColor : lightTextColor),
        ),
        title: Text(
          content.title,
          style: TextStyle(
            fontWeight: isActive ? FontWeight.w700 : FontWeight.normal,
            color: isActive ? primaryColor : darkTextColor,
            fontSize: 13,
          ),
        ),
        trailing: isCompleted ? const Icon(Icons.check_circle, color: correctColor, size: 18) : null,
        onTap: () {
          setState(() {
            _activeModuleIndex = index;
            _segmentController.animateTo(0);
          });
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _buildQuizScreen(ModuleContent quiz, int total) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.quiz, size: 100, color: primaryColor),
          const SizedBox(height: 24),
          const Text(
            'Siap Uji Pemahaman?',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: darkTextColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          const Text(
            'Kuis ini menguji pemahaman Anda tentang materi yang telah dipelajari.',
            style: TextStyle(fontSize: 16, color: lightTextColor, height: 1.6),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          _buildNavButton(quiz, total),
        ],
      ),
    );
  }

  Widget _buildNavButton(ModuleContent activeItem, int total) {
    if (activeItem.isQuiz) {
      return ElevatedButton(
        onPressed: () async {
          QuizData? quiz;
          String courseTitle = widget.course.title;

          if (courseTitle.contains('Minangkabau')) {
            quiz = activeItem.title.contains('Final') ? minangkabauQuizFinal : minangkabauQuiz1;
          } else if (courseTitle.contains('Tari Klasik Keraton')) {
            quiz = activeItem.title.contains('Final') ? tariKeratonQuizFinal : tariKeratonQuiz1;
          } else if (courseTitle.contains('Suku Dayak')) {
            quiz = activeItem.title.contains('Final') ? dayakQuizFinal : dayakQuiz1;
          } else if (courseTitle.contains('Papeda')) {
            quiz = activeItem.title.contains('Final') ? papedaQuizFinal : papedaQuiz1;
          }

          if (quiz != null) {
            final passed = await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => QuizPage(quizData: quiz!)),
            );

            if (passed == true && mounted) {
              setState(() {
                _moduleCompleted[_activeModuleIndex] = true;
                if (_activeModuleIndex < total - 1) {
                  _activeModuleIndex++;
                } else {
                  // --- FIX: Jika Kuis Terakhir lulus, tandai course selesai ---
                  _markCourseAsFinished(); 
                  Navigator.popUntil(context, (route) => route.isFirst);
                }
              });
              _saveProgress();
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: const Text(
          'Mulai Kuis',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      );
    }

    // Tombol Lanjut / Selesai (Untuk Modul Materi)
    return ElevatedButton(
      onPressed: () async {
        setState(() {
          _moduleCompleted[_activeModuleIndex] = true;
          if (_activeModuleIndex < total - 1) {
            _activeModuleIndex++;
            _segmentController.animateTo(0);
          } else {
            // --- FIX: Jika Materi Terakhir selesai, tandai course selesai ---
            _markCourseAsFinished();
            Navigator.popUntil(context, (route) => route.isFirst);
          }
        });
        _saveProgress();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: _activeModuleIndex < total - 1 ? accentColor : correctColor,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _activeModuleIndex < total - 1 ? 'Lanjut' : 'Selesai',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(width: 8),
          Icon(
            _activeModuleIndex < total - 1 ? Icons.arrow_forward : Icons.check_circle, 
            color: Colors.white
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    if (_activeModuleIndex >= courseModules.length) {
      return const Center(child: Text('Konten tidak tersedia'));
    }
    final activeItem = courseModules[_activeModuleIndex];
    int lessonNum = _activeModuleIndex + 1;
    int total = courseModules.length;

    if (activeItem.isQuiz) {
      return _buildQuizScreen(activeItem, total);
    }

    List<String> paragraphs = activeItem.contentText;
    String? imageUrl = _getModuleImage(_activeModuleIndex);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  activeItem.contentTitle,
                  style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: darkTextColor),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$lessonNum/$total',
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: accentColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (imageUrl != null) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 200, color: cardBg,
                  child: const Icon(Icons.image, size: 60, color: lightTextColor),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
          if (paragraphs.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: primaryColor.withOpacity(0.2)),
              ),
              child: Text(
                paragraphs.first,
                style: const TextStyle(fontSize: 16, height: 1.7, color: darkTextColor, fontWeight: FontWeight.w500),
              ),
            ),
          const SizedBox(height: 20),
          _buildCaseStudyCard('Konsep Utama', 'Pahami konsep ini sebelum melanjutkan ke analisis yang lebih dalam pada tab berikutnya.'),
          _buildSegmentedTabs(paragraphs),
          const SizedBox(height: 20),
          _buildNavButton(activeItem, total),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cardBg,
      appBar: AppBar(
        title: Text(
          widget.course.title,
          style: const TextStyle(color: darkTextColor, fontWeight: FontWeight.bold, fontSize: 17),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('EXIT', style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      drawer: _buildSidebar(),
      body: _buildMainContent(),
    );
  }
}