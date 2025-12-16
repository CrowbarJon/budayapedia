// lib/pages/learning_page.dart - COMPLETE VERSION WITH ALL FEATURES

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'course_model.dart';
import 'module_content_model.dart'; 

// Import data modul
import '../data/minangkabau.dart';
import '../data/tari_keraton.dart';
import '../data/dayak.dart';
import '../data/papeda.dart';

// Import untuk quiz
import 'quiz_pages.dart';
import '../quizz/minangkabau_quiz.dart'; 
import '../quiz_model.dart'; 

const Color primaryColor = Color(0xFF2C3E50);
const Color darkTextColor = Color(0xFF1E2A3B);
const Color lightTextColor = Color(0xFF5A6B80);
const Color accentColor = Color(0xFFFFA000);
const Color correctColor = Color(0xFF27AE60); 

class LearningPage extends StatefulWidget {
    final Course course;

    const LearningPage({super.key, required this.course});

    @override
    _LearningPageState createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> with SingleTickerProviderStateMixin {
    int _activeModuleIndex = 0;
    late List<bool> _moduleCompleted;
    late TabController _tabController;
    
    // Key untuk menyimpan progress
    String get _progressKey => 'progress_${widget.course.title}';

    @override
    void initState() {
        super.initState();
        _moduleCompleted = List<bool>.filled(courseModules.length, false);
        _tabController = TabController(length: 3, vsync: this);
        _loadProgress();
    }

    // === LOAD & SAVE PROGRESS WITH SHARED PREFERENCES ===
    Future<void> _loadProgress() async {
        try {
            final prefs = await SharedPreferences.getInstance();
            final String? savedData = prefs.getString(_progressKey);
            
            if (savedData != null) {
                List<dynamic> decoded = jsonDecode(savedData);
                setState(() {
                    _moduleCompleted = decoded.map((e) => e as bool).toList();
                    
                    // Set ke modul terakhir yang belum selesai
                    _activeModuleIndex = _moduleCompleted.indexWhere((completed) => !completed);
                    if (_activeModuleIndex == -1) {
                        _activeModuleIndex = 0; // Semua selesai, mulai dari awal
                    }
                });
            }
        } catch (e) {
            debugPrint('Error loading progress: $e');
        }
    }

    Future<void> _saveProgress() async {
        try {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString(_progressKey, jsonEncode(_moduleCompleted));
        } catch (e) {
            debugPrint('Error saving progress: $e');
        }
    }

    @override
    void dispose() {
        _tabController.dispose();
        super.dispose();
    }

    List<ModuleContent> get courseModules {
        if (widget.course.title.contains('Minangkabau')) {
            return minangkabauModules;
        } else if (widget.course.title.contains('Tari Klasik Keraton')) {
            return tariKeratonModules;
        } else if (widget.course.title.contains('Suku Dayak')) {
            return dayakModules;
        } else if (widget.course.title.contains('Papeda')) {
            return papedaModules;
        }
        return [];
    }

    List<Map<String, dynamic>> get sidebarSections {
        if (widget.course.title.contains('Minangkabau')) {
            return const [
                {'title': 'COURSE OVERVIEW', 'start_index': 0, 'end_index': 0},
                {'title': 'MODUL 1: STRUKTUR SOSIAL', 'start_index': 1, 'end_index': 2}, 
                {'title': 'MODUL 2: PERAN ADAT', 'start_index': 3, 'end_index': 4},
                {'title': 'QUIZ MODUL 1 & 2', 'start_index': 5, 'end_index': 5},
                {'title': 'MODUL 3: RUMAH GADANG', 'start_index': 6, 'end_index': 8},
                {'title': 'MODUL 4: UPACARA ADAT', 'start_index': 9, 'end_index': 11},
                {'title': 'SUMMARY AND FINAL ASSESSMENT', 'start_index': 12, 'end_index': 12}, 
            ];
        } else if (widget.course.title.contains('Papeda')) {
             return const [
                {'title': 'COURSE OVERVIEW', 'start_index': 0, 'end_index': 0},
                {'title': 'MODUL 1: PAPEDA: BAHAN DAN TEKNIK', 'start_index': 1, 'end_index': 2},
                {'title': 'MODUL 2: KUAH KUNING IKAN', 'start_index': 3, 'end_index': 4},
                {'title': 'QUIZ MODUL 1 & 2', 'start_index': 5, 'end_index': 5},
                {'title': 'MODUL 3: PENYAJIAN DAN ADAB', 'start_index': 6, 'end_index': 7},
                {'title': 'FINAL ASSESSMENT', 'start_index': 8, 'end_index': 8},
            ];
        } else if (widget.course.title.contains('Tari Klasik Keraton')) {
            return const [
                {'title': 'COURSE OVERVIEW', 'start_index': 0, 'end_index': 0},
                {'title': 'MODUL 1: FILOSOFI DAN PERAN', 'start_index': 1, 'end_index': 2},
                {'title': 'MODUL 2: TEKNIK DASAR GERAKAN', 'start_index': 3, 'end_index': 4},
                {'title': 'QUIZ MODUL 1 & 2', 'start_index': 5, 'end_index': 5},
                {'title': 'MODUL 3: BUSANA DAN ATRIBUT', 'start_index': 6, 'end_index': 8},
                {'title': 'MODUL 4: STUDI KASUS DAN PENUTUP', 'start_index': 9, 'end_index': 10},
                {'title': 'FINAL ASSESSMENT', 'start_index': 11, 'end_index': 11},
            ];
        } else if (widget.course.title.contains('Dayak')) {
            return const [
                {'title': 'COURSE OVERVIEW', 'start_index': 0, 'end_index': 0},
                {'title': 'MODUL 1: FILOSOFI MANIK-MANIK', 'start_index': 1, 'end_index': 2},
                {'title': 'MODUL 2: BUSANA TRADISIONAL', 'start_index': 3, 'end_index': 4},
                {'title': 'QUIZ MODUL 1 & 2', 'start_index': 5, 'end_index': 5},
                {'title': 'MODUL 3: UKIRAN DAN SIMBOLISME', 'start_index': 6, 'end_index': 7},
                {'title': 'MODUL 4: STUDI KASUS DAN PENUTUP', 'start_index': 8, 'end_index': 9},
                {'title': 'FINAL ASSESSMENT', 'start_index': 10, 'end_index': 10},
            ];
        }
        return [];
    }

    // === MAPPING GAMBAR PER MODUL ===
    String? _getModuleImage() {
        if (!widget.course.title.contains('Minangkabau')) return null;
        
        switch (_activeModuleIndex) {
            case 1: return 'assets/course1/matrilineal.jpg';
            case 2: return 'assets/course1/nagari.jpeg';
            case 3: return 'assets/course1/adat_basandi.jpg';
            case 4: return 'assets/course1/bundo_kanduang.jpg';
            case 7: return 'assets/course1/atap_gonjong.jpg';
            default: return null;
        }
    }

    String _getImageCaption() {
        switch (_activeModuleIndex) {
            case 1: return 'Keluarga Minangkabau dengan Sistem Matrilineal';
            case 2: return 'Pemandangan Nagari di Minangkabau';
            case 3: return 'Filosofi Adat Basandi Syarak';
            case 4: return 'Bundo Kanduang: Pemimpin Spiritual Kaum';
            case 7: return 'Atap Gonjong Rumah Gadang';
            default: return 'Budaya Minangkabau';
        }
    }

    // === PEMBAGIAN KONTEN IMPROVED ===
    Map<String, List<String>> _splitContentIntoTabs(List<String> paragraphs) {
        int totalParagraphs = paragraphs.length;
        
        if (totalParagraphs <= 3) {
            return {
                'konsep': [paragraphs.first],
                'penjelasan': paragraphs.length > 1 ? paragraphs.sublist(0, paragraphs.length) : paragraphs,
                'contoh': paragraphs.length > 1 ? [paragraphs.last] : paragraphs,
            };
        }
        
        // Formula: 25% konsep, 45% penjelasan, 30% contoh
        int konsepEnd = (totalParagraphs * 0.25).ceil().clamp(1, 2);
        int contohStart = totalParagraphs - (totalParagraphs * 0.35).ceil().clamp(1, totalParagraphs - konsepEnd);
        
        return {
            'konsep': paragraphs.sublist(0, konsepEnd),
            'penjelasan': paragraphs.sublist(konsepEnd, contohStart.clamp(konsepEnd, totalParagraphs)),
            'contoh': paragraphs.sublist(contohStart, totalParagraphs),
        };
    }

    String _getFunFact() {
        if (widget.course.title.contains('Minangkabau')) {
            return 'Filosofi "Adat Basandi Syarak, Syarak Basandi Kitabullah" (ABS-SBK) berhasil menyelaraskan sistem matrilineal dengan ajaran Islam, menciptakan identitas unik Minangkabau sebagai masyarakat matrilineal yang religius.';
        } else if (widget.course.title.contains('Tari Klasik Keraton')) {
            return 'Tari Bedhaya Ketawang dipercaya sebagai tarian persembahan Kanjeng Ratu Kidul kepada Raja Mataram. Tarian ini sangat sakral dan hanya dipentaskan pada acara khusus, di mana dipercaya Ratu Kidul hadir secara gaib saat pementasan.';
        } else if (widget.course.title.contains('Dayak')) {
            return 'Manik-manik kuno (Manik Lawas) bagi Suku Dayak memiliki nilai setara dengan properti berharga. Beberapa manik bahkan dianggap memiliki "roh" dan digunakan sebagai mahar atau denda adat yang sangat tinggi nilainya.';
        } else if (widget.course.title.contains('Papeda')) {
            return 'Pohon sagu disebut "Ibu yang Menyusui Anak-anaknya" karena satu batang pohon sagu dewasa dapat menghasilkan hingga 300 kg tepung, cukup untuk menghidupi satu keluarga selama berbulan-bulan tanpa perlu dipupuk.';
        }
        return 'Budaya Indonesia sangat beragam dan kaya akan nilai-nilai luhur yang patut dilestarikan.';
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
                        _tabController.animateTo(0);
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
                        }),
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
        
        String? moduleImage = _getModuleImage();
        List<String> paragraphs = activeItem.contentText;
        Map<String, List<String>> tabContents = _splitContentIntoTabs(paragraphs);

        return SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                        Flexible(
                                            child: Text(
                                                activeItem.contentTitle,
                                                style: const TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                    color: darkTextColor,
                                                ),
                                            ),
                                        ),
                                        if (!activeItem.isQuiz)
                                            Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                                decoration: BoxDecoration(
                                                    color: accentColor.withOpacity(0.1),
                                                    borderRadius: BorderRadius.circular(20),
                                                ),
                                                child: Text(
                                                    lessonCount,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.bold,
                                                        color: accentColor,
                                                    ),
                                                ),
                                            ),
                                    ],
                                ),
                                const SizedBox(height: 16),
                                
                                if (!activeItem.isQuiz)
                                    Container(
                                        height: 45,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            borderRadius: BorderRadius.circular(25),
                                        ),
                                        child: TabBar(
                                            controller: _tabController,
                                            indicator: BoxDecoration(
                                                color: primaryColor,
                                                borderRadius: BorderRadius.circular(25),
                                            ),
                                            labelColor: Colors.white,
                                            unselectedLabelColor: darkTextColor,
                                            labelStyle: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13,
                                            ),
                                            tabs: const [
                                                Tab(text: 'KONSEP DASAR'),
                                                Tab(text: 'PENJELASAN'),
                                                Tab(text: 'CONTOH & APLIKASI'),
                                            ],
                                        ),
                                    ),
                            ],
                        ),
                    ),

                    Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: activeItem.isQuiz
                            ? _buildQuizContent(activeItem, totalModules)
                            : SizedBox(
                                height: MediaQuery.of(context).size.height * 0.6,
                                child: TabBarView(
                                    controller: _tabController,
                                    children: [
                                        _buildTabContent(
                                            tabContents['konsep']!,
                                            null,
                                            'Konsep Dasar',
                                            Icons.lightbulb_outline,
                                        ),
                                        _buildTabContent(
                                            tabContents['penjelasan']!,
                                            moduleImage,
                                            'Penjelasan Detail',
                                            Icons.menu_book,
                                        ),
                                        _buildTabContent(
                                            tabContents['contoh']!,
                                            null,
                                            'Aplikasi dalam Kehidupan',
                                            Icons.people,
                                        ),
                                    ],
                                ),
                            ),
                    ),

                    Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: _buildNavigationButtons(activeItem, totalModules),
                    ),
                ],
            ),
        );
    }

    Widget _buildTabContent(
        List<String> paragraphs, 
        String? imagePath,
        String sectionTitle,
        IconData sectionIcon,
    ) {
        return SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: primaryColor.withOpacity(0.2)),
                        ),
                        child: Row(
                            children: [
                                Icon(sectionIcon, color: primaryColor, size: 24),
                                const SizedBox(width: 10),
                                Text(
                                    sectionTitle,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                    ),
                                ),
                            ],
                        ),
                    ),

                    ...paragraphs.asMap().entries.map((entry) {
                        int index = entry.key;
                        String paragraph = entry.value;
                        
                        return Column(
                            children: [
                                _buildTextCard(paragraph),
                                const SizedBox(height: 16),
                                
                                if (imagePath != null && index == 0)
                                    Column(
                                        children: [
                                            _buildImageCard(imagePath, _getImageCaption()),
                                            const SizedBox(height: 16),
                                        ],
                                    ),
                            ],
                        );
                    }),

                    if (sectionTitle == 'Aplikasi dalam Kehidupan')
                        _buildInfoBox(
                            'Tahukah Anda?',
                            _getFunFact(),
                            Icons.info_outline,
                        ),
                ],
            ),
        );
    }

    Widget _buildTextCard(String text) {
        return Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                    ),
                ],
            ),
            child: Text(
                text,
                style: const TextStyle(
                    fontSize: 16,
                    height: 1.7,
                    color: darkTextColor,
                    fontWeight: FontWeight.w400,
                ),
            ),
        );
    }

    Widget _buildImageCard(String imagePath, String caption) {
        return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 5),
                    ),
                ],
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                    children: [
                        Image.asset(
                            imagePath,
                            fit: BoxFit.cover,
                            height: 250,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) {
                                return Container(
                                    height: 250,
                                    color: Colors.grey.shade200,
                                    child: const Center(
                                        child: Icon(Icons.image_not_supported, size: 60, color: Colors.grey),
                                    ),
                                );
                            },
                        ),
                        Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                    ),
                                ),
                                child: Text(
                                    caption,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                ),
                            ),
                        ),
                    ],
                ),
            ),
        );
    }

    Widget _buildInfoBox(String title, String content, IconData icon) {
        return Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: accentColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: accentColor.withOpacity(0.3)),
            ),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Icon(icon, color: accentColor, size: 28),
                    const SizedBox(width: 12),
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text(
                                    title,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: accentColor,
                                    ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                    content,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: darkTextColor.withOpacity(0.8),
                                        height: 1.4,
                                    ),
                                ),
                            ],
                        ),
                    ),
                ],
            ),
        );
    }

    Widget _buildQuizContent(ModuleContent activeItem, int totalModules) {
        return Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [primaryColor.withOpacity(0.1), accentColor.withOpacity(0.1)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
                children: [
                    const Icon(Icons.quiz, size: 80, color: primaryColor),
                    const SizedBox(height: 20),
                    const Text(
                        'Siap untuk menguji pemahaman Anda?',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: darkTextColor,
                        ),
                        textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                        'Kuis ini berisi pertanyaan pilihan ganda untuk menguji pemahaman Anda tentang materi yang telah dipelajari.',
                        style: TextStyle(
                            fontSize: 15,
                            color: lightTextColor,
                            height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                    ),
                ],
            ),
        );
    }

    Widget _buildNavigationButtons(ModuleContent activeItem, int totalModules) {
        if (activeItem.isQuiz) {
            return _buildQuizButton(activeItem, totalModules);
        } else if (_activeModuleIndex < totalModules - 1) {
            return _buildNextButton();
        } else {
            return _buildFinishButton();
        }
    }

    Widget _buildQuizButton(ModuleContent activeItem, int totalModules) {
        return ElevatedButton(
            onPressed: () async { 
                QuizData? quizToLoad;

                if (widget.course.title.contains('Minangkabau')) {
                    if (activeItem.title.contains('Modul 1 & 2')) {
                        quizToLoad = minangkabauQuiz1;
                    } else if (activeItem.title.contains('Final Assessment') || activeItem.title.contains('SUMMARY')) {
                        quizToLoad = minangkabauQuizFinal;
                    }
                }
                
                if (quizToLoad != null) {
                    final bool? quizPassed = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QuizPage(quizData: quizToLoad!),
                        ),
                    );
                    
                    if (quizPassed == true && mounted) {
                        setState(() {
                            _moduleCompleted[_activeModuleIndex] = true;
                            
                            if (_activeModuleIndex < totalModules - 1) {
                                _activeModuleIndex++;
                                _tabController.animateTo(0);
                            } else {
                                Navigator.popUntil(context, (route) => route.isFirst);
                            }
                        });
                        _saveProgress();
                    }
                } else {
                    if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Data kuis belum tersedia untuk modul ini.")),
                        );
                    }
                }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 2,
            ),
            child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Icon(Icons.play_arrow, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                        'Mulai Kuis Sekarang',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                        ),
                    ),
                ],
            ),
        );
    }

    Widget _buildNextButton() {
        return ElevatedButton(
            onPressed: () {
                setState(() {
                    _moduleCompleted[_activeModuleIndex] = true;
                    _activeModuleIndex++;
                    _tabController.animateTo(0);
                });
                _saveProgress();
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: accentColor,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 2,
            ),
            child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Text(
                        'Lanjut ke Modul Berikutnya',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                        ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, color: Colors.white),
                ],
            ),
        );
    }

    Widget _buildFinishButton() {
        return ElevatedButton(
            onPressed: () {
                setState(() {
                    _moduleCompleted[_activeModuleIndex] = true;
                });
                _saveProgress();
                Navigator.popUntil(context, (route) => route.isFirst);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: correctColor,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 2,
            ),
            child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Icon(Icons.check_circle, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                        'Selesaikan Kursus',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                        ),
                    ),
                ],
            ),
        );
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.grey.shade50,
            appBar: AppBar(
                title: Text(
                    widget.course.title,
                    style: const TextStyle(
                        color: darkTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                    ),
                ),
                centerTitle: false,
                backgroundColor: Colors.white,
                elevation: 1,
                actions: [
                    TextButton.icon(
                        onPressed: () {
                            Navigator.pop(context); 
                        },
                        icon: const Icon(Icons.close, color: primaryColor),
                        label: const Text(
                            'EXIT',
                            style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                            ),
                        ),
                    ),
                ],
            ),
            drawer: _buildDrawerContent(),
            body: _buildMainContent(),
        );
    }
}