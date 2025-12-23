// lib/pages/courseview.dart

import 'package:flutter/material.dart';
import 'course_model.dart'; 
import 'LearningPages.dart'; // Pastikan nama file ini sesuai (learningPages.dart atau learning_page.dart)

const Color primaryColor = Color(0xFF2C3E50);
const Color darkTextColor = Color(0xFF1E2A3B);
const Color lightTextColor = Color(0xFF5A6B80);
const Color accentColor = Color(0xFFFFA000);

class CourseDetailsView extends StatelessWidget {
  final Course course;

  const CourseDetailsView({super.key, required this.course});

  // --- FUNGSI BARU: MENENTUKAN TOKOH ADAT ---
  String _getInstructorName(String courseTitle) {
    if (courseTitle.contains('Minang')) {
      return 'Ibrahim Datuak Sangguno Dirajo';
    } else if (courseTitle.contains('Keraton') || courseTitle.contains('Jawa')) {
      return 'Nyi Raden Retno Dumilah'; 
    } else if (courseTitle.contains('Dayak')) {
      return 'Panglima Burung'; 
    } else if (courseTitle.contains('Papeda') || courseTitle.contains('Papua')) {
      return 'Mama Regina Krey'; 
    } else {
      return 'Instruktur Budaya'; 
    }
  }

  Widget _buildCoursePoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: Icon(Icons.check_circle, color: accentColor, size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                height: 1.4,
                color: Colors.grey.shade800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: darkTextColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Course details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: darkTextColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border, color: darkTextColor),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Course
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  course.imageUrl,
                  fit: BoxFit.cover,
                  height: 220,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 220,
                    color: Colors.grey[200],
                    child: const Center(
                      child: Icon(Icons.image, size: 50, color: lightTextColor),
                    ),
                  ),
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Badge Kategori
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      course.category,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Judul Course
                  Text(
                    course.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: darkTextColor,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Nama Instruktur (SUDAH DINAMIS)
                  Row(
                    children: [
                      const Icon(Icons.person, size: 18, color: lightTextColor),
                      const SizedBox(width: 4),
                      Text(
                        _getInstructorName(course.title), // <-- Panggil Fungsi Disini
                        style: const TextStyle(fontSize: 14, color: lightTextColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Deskripsi
                  Text(
                    course.description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: darkTextColor,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // List Isi Course
                  const Text(
                    'Isi Course:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: darkTextColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...course.contents.map((point) => _buildCoursePoint(point)),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
      
      // Tombol Start Course
      bottomSheet: Container(
        padding: const EdgeInsets.all(16.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            // NAVIGASI KE HALAMAN PEMBELAJARAN
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LearningPage(course: course),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Start course',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}