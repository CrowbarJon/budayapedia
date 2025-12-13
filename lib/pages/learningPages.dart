// lib/pages/learning_page.dart (Versi FINAL yang Dimodifikasi)

import 'package:flutter/material.dart';
import 'mycourse.dart'; 
// PASTI DITEMPATKAN DI lib/data/
import '../data/minangkabau.dart'; 

const Color primaryColor = Color(0xFF2C3E50);
const Color darkTextColor = Color(0xFF1E2A3B);
const Color lightTextColor = Color(0xFF5A6B80);
const Color accentColor = Color(0xFFFFA000); 

class LearningPage extends StatefulWidget {
  final Course course;

  const LearningPage({super.key, required this.course});

  @override
  _LearningPageState createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> {
  int _activeModuleIndex = 0;

  List<ModuleContent> get courseModules {
    if (widget.course.title.contains('Minangkabau')) {
      return minangkabauModules;
    }
    return minangkabauModules; 
  }

  // Struktur untuk mengelompokkan modul di sidebar
  final List<Map<String, dynamic>> sidebarSections = const [
    {'title': 'COURSE OVERVIEW', 'start_index': 0, 'end_index': 0},
    {'title': 'MODUL 1: STRUKTUR SOSIAL', 'start_index': 0, 'end_index': 2},
    {'title': 'MODUL 2: PERAN ADAT', 'start_index': 3, 'end_index': 4},
    {'title': 'QUIZ MODUL 1 & 2', 'start_index': 5, 'end_index': 5},
    {'title': 'MODUL 3: RUMAH GADANG', 'start_index': 6, 'end_index': 8},
    {'title': 'MODUL 4: UPACARA ADAT', 'start_index': 9, 'end_index': 10},
    {'title': 'SUMMARY AND FINAL ASSESSMENT', 'start_index': 11, 'end_index': 11},
  ];

  Widget _buildSidebarItem(int index, ModuleContent content) {
    bool isActive = index == _activeModuleIndex;
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
          color: isActive ? primaryColor : Colors.grey.shade700,
        ),
        title: Text(
          content.title,
          style: TextStyle(
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            color: isActive ? primaryColor : darkTextColor,
            fontSize: 14,
          ),
        ),
        trailing: const Icon(Icons.radio_button_off, color: Colors.grey),
        onTap: () {
          setState(() {
            _activeModuleIndex = index;
          });
          // Tutup drawer setelah item diklik
          Navigator.pop(context); 
        },
      ),
    );
  }

  // Widget untuk membuat isi Drawer (Sidebar Navigasi)
  Widget _buildDrawerContent() {
    double progress = (_activeModuleIndex + 1) / courseModules.length;
    return Drawer(
      width: 300, // Lebar sidebar
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0, bottom: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Bar
            const Text('PROGRESS', style: TextStyle(fontSize: 12, color: lightTextColor)),
            const SizedBox(height: 4),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey.shade300,
              color: accentColor,
            ),
            const SizedBox(height: 4),
            Text('${(progress * 100).toStringAsFixed(0)}% COMPLETE', 
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: primaryColor)),
            const Divider(height: 30, thickness: 1),
            
            // Daftar Modul dengan Header Pengelompokan
            ...sidebarSections.map((section) {
              List<Widget> items = [];

              items.add(
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
                  child: Text('▼ ${section['title']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: darkTextColor)),
                ),
              );

              for (int i = section['start_index']; i <= section['end_index']; i++) {
                if (i < courseModules.length) {
                  items.add(_buildSidebarItem(i, courseModules[i]));
                }
              }
              return Column(crossAxisAlignment: CrossAxisAlignment.start, children: items);
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent() {
    if (courseModules.isEmpty || _activeModuleIndex >= courseModules.length) {
      return const Center(child: Text('Konten modul tidak valid.'));
    }

    final activeItem = courseModules[_activeModuleIndex];
    int totalModules = courseModules.length;
    int lessonNumber = _activeModuleIndex + 1;
    String lessonCount = 'Lesson $lessonNumber of $totalModules';

    return Padding( // Konten utama kini bisa dibungkus Padding saja
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
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: darkTextColor),
                ),
              ),
              if (!activeItem.isQuiz) 
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    lessonCount,
                    style: const TextStyle(fontSize: 14, color: lightTextColor),
                  ),
                ),
            ],
          ),
          const Divider(height: 30),

          // Area Video Player/Konten Visual (Placeholder)
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: activeItem.isQuiz
                  ? const Icon(Icons.assignment, color: Colors.white, size: 60)
                  : const Icon(Icons.ondemand_video, color: Colors.white, size: 60),
            ),
          ),
          const SizedBox(height: 20),

          // Teks Materi
          Text(
            activeItem.contentText,
            style: const TextStyle(fontSize: 16, height: 1.5, color: darkTextColor),
          ),
          const SizedBox(height: 40),

          // Tombol Navigasi Lanjut
          if (_activeModuleIndex < totalModules - 1)
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _activeModuleIndex++;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: accentColor,
                minimumSize: const Size(double.infinity, 45),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Lanjut ke Modul Berikutnya', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          if (_activeModuleIndex == totalModules - 1)
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/home'));
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
        // Menu Hamburger (Garis Tiga) muncul otomatis karena ada Drawer
        title: Text(widget.course.title, style: const TextStyle(color: darkTextColor, fontWeight: FontWeight.bold)),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
            TextButton(
                onPressed: () {
                    // Kembali ke halaman detail kursus
                    Navigator.pop(context); 
                },
                child: const Text('EXIT COURSE', style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
            ),
        ],
      ),
      
      // 1. TAMBAHKAN DRAWER UNTUK SIDEBAR YANG BISA DI-TOGGLE
      drawer: _buildDrawerContent(),

      // 2. BODY KINI HANYA BERISI KONTEN UTAMA DAN AKAN MENGISI FULL PAGE
      body: SingleChildScrollView(
        child: _buildMainContent(),
      ),
    );
  }
}