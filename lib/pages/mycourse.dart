import 'package:flutter/material.dart';
import 'courseview.dart'; // Import CourseDetailsView untuk navigasi

// Definisikan warna yang sama agar konsisten
const Color primaryColor = Color(0xFF2C3E50);
const Color darkTextColor = Color(0xFF1E2A3B);
const Color lightTextColor = Color(0xFF5A6B80);

// =======================================================
// A. MODEL DATA KURSUS
// =======================================================

class Course {
  final String title;
  final String category;
  final String description;
  final List<String> contents; // List untuk menyimpan poin-poin isi kursus
  final String videoCount;
  final String duration;
  final String imageUrl; // Path gambar lokal

  Course({
    required this.title,
    required this.category,
    required this.description,
    required this.contents, 
    required this.videoCount,
    required this.duration,
    required this.imageUrl,
  });
}

// =======================================================
// B. DATA KURSUS LENGKAP (Termasuk Filosofi Adat Minangkabau)
// =======================================================

final List<Course> allCourses = [
  // 1. FILOSOFI ADAT MINANGKABAU (Data Lengkap)
  Course(
    title: "Filosofi Adat dan Rumah Gadang Minangkabau",
    category: "Adat",
    description: "Pelajari sistem matrilineal, nilai-nilai luhur adat, dan arsitektur ikonik Rumah Gadang Sumatra Barat.",
    videoCount: '18 videos',
    duration: "2h 20m",
    imageUrl: 'assets/sumatra.jpg', // Ganti dengan path gambar Anda
    contents: [
      "Memahami struktur sosial matrilineal Suku Minangkabau.",
      "Menjelaskan peran penting Bundo Kanduang dan Niniak Mamak dalam adat.",
      "Menganalisis filosofi ukiran dan konstruksi Rumah Gadang.",
      "Studi kasus upacara adat pernikahan Minangkabau.",
    ],
  ),
  // 2. TARI KLASIK KERATON JAWA
  Course(
    title: "Gerak Anggun Tari Klasik Keraton Jawa",
    category: "Seni",
    description: "Pengenalan mendalam pada Tari Serimpi dan Bedhaya, termasuk filosofi di balik gerakan lembut dan busana penari Keraton.",
    videoCount: '12 videos',
    duration: "1h 15m",
    imageUrl: 'assets/tarikawa.jpg', // Ganti dengan path gambar Anda
    contents: [
      "Teknik dasar gerakan lambat dan halus Tari Serimpi.",
      "Memahami filosofi ketenangan dan kesabaran dalam Tari Bedhaya.",
      "Peran Gamelan dan Sinden sebagai iringan utama.",
      "Menganalisis makna simbolis busana penari Keraton.",
    ],
  ),
  // 3. MANIK-MANIK SUKU DAYAK
  Course(
    title: "Manik-Manik dan Busana Adat Suku Dayak",
    category: "Kerajinan",
    description: "Eksplorasi Pakaian Adat Dayak Kalimantan, fokus pada teknik pembuatan manik-manik, ukiran, dan busana King Baba/King Bibinge.",
    videoCount: '8 videos',
    duration: "2h 15m",
    imageUrl: 'assets/dayak.jpg', // Ganti dengan path gambar Anda
    contents: [
      "Pengenalan berbagai jenis manik-manik dan bahan dasar.",
      "Langkah-langkah pembuatan aksesoris manik-manik Dayak.",
      "Simbolisme warna dan motif fauna/flora pada ukiran Dayak.",
      "Sejarah dan fungsi busana King Baba dan King Bibinge.",
    ],
  ),
  // 4. PAPEDA DAN KUAH KUNING PAPUA
  Course(
    title: "Memasak Papeda dan Kuah Kuning Ikan Tongkol",
    category: "Makanan",
    description: "Teknik dan resep spesifik untuk hidangan ikonik Papua. Belajar membuat Papeda dari sagu dan mengolahnya bersama Kuah Kuning Ikan Tongkol.",
    videoCount: '8 videos',
    duration: "2h 15m",
    imageUrl: 'assets/papeda.jpg', // Ganti dengan path gambar Anda
    contents: [
      "Cara mengolah sagu menjadi Papeda yang kenyal sempurna.",
      "Resep bumbu lengkap untuk Kuah Kuning Ikan Tongkol.",
      "Filosofi Papeda sebagai makanan pokok dan ritual adat.",
      "Teknik penyajian dan etika makan hidangan Papua.",
    ],
  ),
];

// =======================================================
// C. WIDGET UTAMA (MyCoursePage - Daftar Kursus)
// =======================================================

class MyCoursePage extends StatefulWidget {
  const MyCoursePage({super.key});

  @override
  State<MyCoursePage> createState() => _MyCoursePageState();
}

class _MyCoursePageState extends State<MyCoursePage> {
  String selectedCategory = 'All courses'; 
  
  final List<String> categories = [
    'All courses', 
    'My Favorites', 
    'Makanan', 
    'Seni', 
    'Adat',
    'Kerajinan',
  ];

  List<Course> get filteredCourses {
    if (selectedCategory == 'All courses') {
      return allCourses;
    } 
    return allCourses.where((course) => course.category == selectedCategory).toList();
  }

  Widget _buildCategoryButton(String category) {
    final bool isSelected = selectedCategory == category;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            selectedCategory = category;
          });
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: isSelected ? primaryColor : Colors.white,
          foregroundColor: isSelected ? Colors.white : darkTextColor,
          side: BorderSide(color: isSelected ? primaryColor : lightTextColor.withOpacity(0.5)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(category, style: const TextStyle(fontSize: 14)),
      ),
    );
  }

  Widget _buildCourseCard(BuildContext context, Course course) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman detail dengan membawa objek kursus
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseDetailsView(course: course), // Meneruskan objek course
          ), 
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar Kursus
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  course.imageUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey[200],
                    child: const Center(child: Icon(Icons.image)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Konten Teks
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: darkTextColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      course.description,
                      style: const TextStyle(fontSize: 12, color: lightTextColor),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.video_library, size: 14, color: primaryColor),
                        const SizedBox(width: 4),
                        Text(course.videoCount, style: const TextStyle(fontSize: 12, color: darkTextColor)),
                        const SizedBox(width: 10),
                        const Icon(Icons.timer, size: 14, color: primaryColor),
                        const SizedBox(width: 4),
                        Text(course.duration, style: const TextStyle(fontSize: 12, color: darkTextColor)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Course Saya',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: darkTextColor,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bagian Filter Kategori (Horizontal Scroll)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            child: SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return _buildCategoryButton(categories[index]);
                },
              ),
            ),
          ),
          
          // Daftar Kursus
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: filteredCourses.length,
              itemBuilder: (context, index) {
                final course = filteredCourses[index];
                return _buildCourseCard(context, course);
              },
            ),
          ),
        ],
      ),
    );
  }
}