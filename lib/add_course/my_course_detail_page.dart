import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../add_course/isi_course.dart'; 
import '../pages/learningPages.dart'; 
import '../pages/course_model.dart'; 
import 'course_player_page.dart'; 

const Color primaryColor = Color(0xFF2C3E50);
const Color greenColor = Color(0xFF27AE60);

class MyCourseDetailPage extends StatelessWidget {
  final Map<String, dynamic> courseData;
  final String courseId; // ID Dokumen Firebase

  const MyCourseDetailPage({
    Key? key, 
    required this.courseData,
    required this.courseId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Cek status pakai string 'approved' sesuai database
    bool isAccepted = (courseData['status'] == 'approved');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Detail Course Saya", style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: () {
              _showDeleteDialog(context);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. GAMBAR COVER ---
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.grey[200],
              child: courseData['imageUrl'] != null && courseData['imageUrl'].toString().isNotEmpty
                  ? Image.network(
                      courseData['imageUrl'], 
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(child: Icon(Icons.broken_image, size: 50, color: Colors.grey));
                      },
                    )
                  : const Center(child: Icon(Icons.image, size: 80, color: Colors.grey)),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- 2. STATUS BADGE ---
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isAccepted ? greenColor.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: isAccepted ? greenColor : Colors.orange),
                    ),
                    child: Text(
                      isAccepted ? "✅ Diterima (Approved)" : "⏳ Menunggu Review",
                      style: TextStyle(
                        color: isAccepted ? greenColor : Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 12
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // --- 3. JUDUL & DESKRIPSI ---
                  Text(
                    courseData['title'] ?? "Tanpa Judul",
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    courseData['description'] ?? "Tidak ada deskripsi.",
                    style: TextStyle(fontSize: 14, color: Colors.grey[600], height: 1.5),
                  ),
                  const SizedBox(height: 30),

                  // --- 4. TOMBOL AKSI ---
                  if (isAccepted)
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // ===============================================
                            // [LOGIKA FIX] UNBOXING MODUL -> AMBIL ITEMS
                            // ===============================================
                            
                            // 1. Ambil Data Mentah (Bisa Map atau List)
                            var rawSource = courseData['modules'] ?? courseData['contents'];
                            List<dynamic> modulesList = [];

                            // 2. Normalisasi ke List
                            if (rawSource == null) {
                              print("DEBUG: Data kosong");
                            } else if (rawSource is List) {
                              modulesList = rawSource;
                            } else if (rawSource is Map) {
                              var sortedKeys = rawSource.keys.toList()
                                ..sort((a, b) => int.parse(a.toString()).compareTo(int.parse(b.toString())));
                              for (var key in sortedKeys) {
                                modulesList.add(rawSource[key]);
                              }
                            }

                            // 3. FLATTENING: Bongkar Modul untuk Ambil Item (Flip Card)
                            List<dynamic> allItems = [];
                            
                            for (var module in modulesList) {
                              if (module is Map) {
                                // Cek apakah ini Modul (punya 'items')?
                                if (module['items'] != null && module['items'] is List) {
                                  // Ambil semua item di dalamnya
                                  allItems.addAll(module['items']);
                                } 
                                // Atau apakah ini Item langsung?
                                else if (module['type'] != null) {
                                  allItems.add(module);
                                }
                              }
                            }

                            print("DEBUG: Total Item Siap Putar: ${allItems.length}");

                            // 4. Buat Object Course
                            Course courseObj = Course(
                              title: courseData['title'] ?? '',
                              description: courseData['description'] ?? '',
                              imageUrl: courseData['imageUrl'] ?? '',
                              status: courseData['status'] ?? 'approved',
                              contents: allItems, // Kirim item yang sudah dibongkar
                              videoCount: '${allItems.length} Item', 
                              duration: '0m',
                              category: courseData['category'] ?? 'Umum',
                            );

                            // 5. Navigasi
                            if (allItems.isNotEmpty) {
                              Navigator.push(
                                context, 
                                MaterialPageRoute(
                                  builder: (_) => CoursePlayerPage(course: courseObj)
                                )
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Konten kosong. Coba edit dan tambah materi."),
                                  backgroundColor: Colors.orange,
                                )
                              );
                            }
                          },
                          icon: const Icon(Icons.play_circle_outline, color: Colors.white),
                          label: const Text("Lihat Materi (Preview)"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),

                  // Tombol EDIT (Ke IsiCoursePage)
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (_) => IsiCoursePage(courseData: courseData) 
                          )
                        );
                      },
                      icon: const Icon(Icons.edit, color: primaryColor),
                      label: const Text("Edit Konten"),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: primaryColor),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Hapus Course?"),
        content: const Text("Apakah Anda yakin? Data yang dihapus tidak bisa dikembalikan."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Batal")),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx); 
              try {
                await FirebaseFirestore.instance.collection('courses').doc(courseId).delete();
                if (context.mounted) {
                  Navigator.pop(context); 
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Course berhasil dihapus"), backgroundColor: Colors.red),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Gagal menghapus: $e")),
                  );
                }
              }
            }, 
            child: const Text("Hapus", style: TextStyle(color: Colors.red))
          ),
        ],
      ),
    );
  }
}