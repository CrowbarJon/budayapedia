// =======================================================
// ISI FILE: lib/pages/course_model.dart
// =======================================================
import 'package:flutter/material.dart';
import 'dart:io'; 

const Color primaryColor = Color(0xFF2C3E50);

// ==========================================
// 1. MODEL SEDERHANA (Simple Course)
// ==========================================
class Course {
  final String title;
  final String category;
  final String description;
  
  final List<dynamic> contents; 
  
  final String videoCount;
  final String duration;
  final String imageUrl;
  final String status;

  Course({
    required this.title,
    this.category = 'Umum',     
    this.description = '',      
    this.contents = const [],   // Default kosong
    this.videoCount = '0',      
    this.duration = '0m',       
    required this.imageUrl,
    this.status = 'approved',   
  });
}

// Data Dummy Katalog LAMA (Masih tersimpan aman disini)
final List<Course> allCourses = [
  Course(
    title: "Filosofi Adat dan Rumah Gadang Minangkabau",
    category: "Adat",
    description: "Pelajari sistem matrilineal, nilai-nilai luhur adat, dan arsitektur ikonik Rumah Gadang Sumatra Barat.",
    videoCount: '18 videos',
    duration: "2h 20m",
    imageUrl: 'assets/sumatra.jpg',
    status: 'approved',
    contents: [
      "Memahami struktur sosial matrilineal Suku Minangkabau.",
      "Menjelaskan peran penting Bundo Kanduang.",
      "Menganalisis filosofi ukiran Rumah Gadang.",
    ],
  ),
  Course(
    title: "Gerak Anggun Tari Klasik Keraton Jawa",
    category: "Seni",
    description: "Pengenalan mendalam pada Tari Serimpi dan Bedhaya.",
    videoCount: '12 videos',
    duration: "1h 15m",
    imageUrl: 'assets/tarikawa.jpg',
    status: 'approved',
    contents: ["Teknik dasar gerakan.", "Filosofi ketenangan."],
  ),
  Course(
    title: "Manik-Manik dan Busana Adat Suku Dayak",
    category: "Kerajinan",
    description: "Eksplorasi Pakaian Adat Dayak Kalimantan.",
    videoCount: '8 videos',
    duration: "2h 15m",
    imageUrl: 'assets/dayak.jpg',
    status: 'approved',
    contents: ["Pengenalan manik-manik.", "Simbolisme warna."],
  ),
  Course(
    title: "Memasak Papeda dan Kuah Kuning",
    category: "Makanan",
    description: "Teknik dan resep spesifik untuk hidangan ikonik Papua.",
    videoCount: '8 videos',
    duration: "2h 15m",
    imageUrl: 'assets/papeda.jpg',
    status: 'approved',
    contents: ["Cara mengolah sagu.", "Resep bumbu kuning."],
  ),
];

// ==========================================
// 2. MODEL KOMPLEKS (UNTUK HALAMAN BARU)
// ==========================================

enum CourseStatus { draft, pending, published, rejected }

class CourseData {
  String? id;
  String title;
  String subtitle;
  String author;
  String? category;
  String duration;
  String description;
  dynamic thumbnail; 
  List<String> learningOutcomes;
  List<CourseSection> sections;
  CourseStatus status;
  String? uploadDate;
  bool isDraft;

  CourseData({
    this.id,
    required this.title,
    required this.subtitle,
    required this.author,
    this.category,
    required this.duration,
    required this.description,
    this.thumbnail,
    required this.learningOutcomes,
    required this.sections,
    this.status = CourseStatus.draft,
    this.uploadDate,
    this.isDraft = true,
  });

  // --- FITUR BARU: KONVERTER DARI DATA LAMA KE DATA BARU ---
  // Ini jembatannya, biar data dummy bisa masuk ke halaman detail baru
  factory CourseData.fromSimpleCourse(Course simple) {
    
    // Konversi string status simple ke Enum CourseStatus
    CourseStatus convertedStatus = CourseStatus.draft;
    if (simple.status == 'approved' || simple.status == 'Diterima') {
      convertedStatus = CourseStatus.published;
    } else if (simple.status == 'pending') {
      convertedStatus = CourseStatus.pending;
    }

    return CourseData(
      id: DateTime.now().toString(), // ID acak
      title: simple.title,
      subtitle: "${simple.videoCount} • ${simple.category}",
      author: "Admin BudayaPedia", // Default Author
      category: simple.category,
      duration: simple.duration,
      description: simple.description,
      thumbnail: simple.imageUrl, // String URL asset
      status: convertedStatus, // Menggunakan status hasil konversi
      isDraft: false,
      
      // [PERBAIKAN] Tambahkan .map((e) => e.toString()) agar dynamic aman dikonversi ke String
      learningOutcomes: simple.contents.map((e) => e.toString()).toList(),
      
      sections: [
        // Bikin section dummy biar nggak kosong
        CourseSection(
          title: "Pendahuluan", 
          // [PERBAIKAN] Tambahkan .toString() pada title
          lessons: simple.contents.map((c) => Lesson(title: c.toString(), type: 'text')).toList()
        )
      ], 
    );
  }
}

class CourseSection {
  String title;
  List<Lesson> lessons;

  CourseSection({
    required this.title,
    required this.lessons,
  });
}

class Lesson {
  String title;
  String type; 
  String? contentPath; 
  List<QuizQuestion>? quizQuestions;

  Lesson({
    required this.title,
    required this.type,
    this.contentPath,
    this.quizQuestions,
  });
}

class QuizQuestion {
  String question;
  List<String> options;
  int correctAnswer;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswer,
  });
}

class CourseDatabase {
  static List<CourseData> draftCourses = [];
  
  // --- BAGIAN PENTING: GABUNGKAN DATA ---
  // List ini sekarang otomatis berisi Data Dummy LAMA yang sudah dikonversi
  static List<CourseData> uploadedCourses = [
    ...allCourses.map((c) => CourseData.fromSimpleCourse(c)).toList(),
  ]; 
}