// lib/add_course/add_course.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'form_course.dart';
import 'status_course.dart';
import '../pages/course_model.dart'; 

const Color primaryColor = Color(0xFF2C3E50);
const Color darkTextColor = Color(0xFF1E2A3B);
const Color lightTextColor = Color(0xFF5A6B80);
const Color accentColor = Color(0xFF3498DB);

class AddCoursePage extends StatefulWidget {
  const AddCoursePage({Key? key}) : super(key: key);

  @override
  State<AddCoursePage> createState() => _AddCoursePageState();
}

class _AddCoursePageState extends State<AddCoursePage> {
  final String? userId = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    // 1. Cek Draft Lokal
    if (CourseDatabase.draftCourses.isNotEmpty) {
      return const CourseStatusPage();
    }

    // 2. Cek User Login
    if (userId == null) {
      return const DefaultEmptyPage();
    }

    // 3. Cek Firebase (Apakah user sudah punya course?)
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('courses')
          .where('authorId', isEqualTo: userId)
          .limit(1) 
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Color(0xFFF8F9FA),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // JIKA ADA DATA -> Tampilkan List Status
        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          return const CourseStatusPage();
        }

        // JIKA KOSONG -> Tampilkan Halaman Default (Lingkaran Biru)
        return const DefaultEmptyPage();
      },
    );
  }
}

// --- TAMPILAN KOSONG (Default) ---
class DefaultEmptyPage extends StatelessWidget {
  const DefaultEmptyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            // Background Decoration
            Positioned(top: -100, right: -100, child: _buildCircle(300, [accentColor.withOpacity(0.1), accentColor.withOpacity(0.0)])),
            Positioned(bottom: -150, left: -150, child: _buildCircle(400, [primaryColor.withOpacity(0.08), primaryColor.withOpacity(0.0)])),
            
            // Content
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildAnimatedIcon(),
                    const SizedBox(height: 48),
                    const Text('Bagikan Pengetahuan Anda', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: darkTextColor, letterSpacing: -0.5), textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    const Text('Mulai buat course dan inspirasi\nribuan orang untuk belajar hal baru', style: TextStyle(fontSize: 16, color: lightTextColor, height: 1.6), textAlign: TextAlign.center),
                    const SizedBox(height: 56),
                    _buildStartButton(context),
                    const SizedBox(height: 24),
                    _buildInfoCard(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircle(double size, List<Color> colors) {
    return Container(
      width: size, height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, gradient: RadialGradient(colors: colors)),
    );
  }

  Widget _buildAnimatedIcon() {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 800),
      tween: Tween<double>(begin: 0.8, end: 1.0),
      builder: (context, double value, child) => Transform.scale(scale: value, child: child),
      child: Container(
        width: 180, height: 180,
        decoration: BoxDecoration(
          gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [primaryColor, accentColor]),
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: primaryColor.withOpacity(0.3), blurRadius: 40, offset: const Offset(0, 20))],
        ),
        child: const Icon(Icons.school_outlined, size: 90, color: Colors.white),
      ),
    );
  }

  Widget _buildStartButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const FormCoursePage()));
      },
      child: Container(
        width: 200, height: 60,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [primaryColor, accentColor]),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [BoxShadow(color: primaryColor.withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 10))],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.add_circle_outline, color: Colors.white, size: 24),
            SizedBox(width: 12),
            Text('Mulai Sekarang', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 4))]),
      child: Row(mainAxisSize: MainAxisSize.min, children: const [Icon(Icons.info_outline, size: 18, color: accentColor), SizedBox(width: 8), Text('Gratis dan mudah digunakan', style: TextStyle(fontSize: 14, color: lightTextColor, fontWeight: FontWeight.w500))]),
    );
  }
}