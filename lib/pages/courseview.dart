import 'package:flutter/material.dart';
import 'mycourse.dart'; // Wajib: Import Course Model dari mycourse.dart

// Definisikan warna yang sama agar konsisten
const Color primaryColor = Color(0xFF2C3E50);
const Color darkTextColor = Color(0xFF1E2A3B);
const Color lightTextColor = Color(0xFF5A6B80);
const Color accentColor = Color(0xFFFFA000); // Warna Oranye

// =======================================================
// WIDGET UTAMA
// =======================================================

class CourseDetailsView extends StatelessWidget {
  // Wajib menerima objek Course saat dipanggil
  final Course course;

  const CourseDetailsView({
    super.key,
    required this.course,
  });

  // Widget Pembantu untuk membuat Poin Isi Course
  Widget _buildCoursePoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: Icon(
              Icons.check_circle,
              color: accentColor, 
              size: 20,
            ),
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
        // Tombol kembali (panah kiri)
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: darkTextColor),
          onPressed: () {
            Navigator.pop(context); 
          },
        ),
        title: const Text(
          'Course details',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: darkTextColor),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        // Tombol bookmark/save
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border, color: darkTextColor),
            onPressed: () {
              // Aksi untuk menyimpan/bookmark
            },
          ),
        ],
      ),
      // Menggunakan SingleChildScrollView agar seluruh konten dapat di-scroll
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100), // Padding bawah untuk tombol
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Gambar Utama Course (Dinamis)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  course.imageUrl, // MENGGUNAKAN DATA DINAMIS DARI course.imageUrl
                  fit: BoxFit.cover,
                  height: 220,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 220,
                    color: Colors.grey[200],
                    child: const Center(child: Icon(Icons.image, size: 50, color: lightTextColor)),
                  ),
                ),
              ),
            ),

            // Konten Utama di bawah gambar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 2. Tag Kategori (Dinamis)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      course.category, // MENGGUNAKAN DATA DINAMIS DARI course.category
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // 3. Judul Course (Dinamis)
                  Text(
                    course.title, // MENGGUNAKAN DATA DINAMIS DARI course.title
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: darkTextColor,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // 4. Nama Pengajar (Statik)
                  Row(
                    children: [
                      const Icon(
                        Icons.person,
                        size: 18,
                        color: lightTextColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'John Smith', 
                        style: TextStyle(
                          fontSize: 14,
                          color: lightTextColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // 5. Deskripsi Singkat Course (Dinamis)
                  Text(
                    course.description, // MENGGUNAKAN DATA DINAMIS DARI course.description
                    style: const TextStyle(
                      fontSize: 16,
                      color: darkTextColor,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 6. Judul Bagian Isi Course
                  const Text(
                    'Isi Course:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: darkTextColor, 
                    ),
                  ),
                  const SizedBox(height: 10),

                  // 7. Poin-Poin Isi Course (Dinamis dari List contents)
                  // Loop melalui list 'contents' dari objek kursus
                  ...course.contents.map((point) => _buildCoursePoint(point)).toList(),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
      // 8. Floating Bottom Button (Tombol Start Course)
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
            // Aksi ketika tombol "Start course" ditekan
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