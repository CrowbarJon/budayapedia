// lib/add_course/status_course.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// Pastikan import file halaman lain sesuai dengan struktur folder Anda
import 'form_course.dart';
import 'draft_course.dart';

// --- DEFINISI WARNA ---
const Color darkTextColor = Color(0xFF333333);
const Color lightTextColor = Color(0xFF999999);
const Color cardBackgroundColor = Color(0xFFF9F5FF); // Background Ungu Muda

class CourseStatusPage extends StatefulWidget {
  const CourseStatusPage({Key? key}) : super(key: key);

  @override
  State<CourseStatusPage> createState() => _CourseStatusPageState();
}

class _CourseStatusPageState extends State<CourseStatusPage> {
  // Ambil User ID yang sedang login
  final String? userId = FirebaseAuth.instance.currentUser?.uid;

  // Helper untuk format tanggal
  String _formatDate(Timestamp? timestamp) {
    if (timestamp == null) return '-';
    DateTime date = timestamp.toDate();
    // Format sederhana: DD/MM/YYYY
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Course Saya'),
        backgroundColor: Colors.white,
        foregroundColor: darkTextColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.drafts_outlined),
            tooltip: 'Draft',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DraftCoursePage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            tooltip: 'Tambah Course',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FormCoursePage()),
              );
            },
          ),
        ],
      ),
      body: userId == null
          ? const Center(child: Text("Silakan login terlebih dahulu"))
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('courses')
                  .where('authorId', isEqualTo: userId)
                  // .orderBy('createdAt', descending: true) // Aktifkan jika sudah buat index di Firebase
                  .snapshots(),
              builder: (context, snapshot) {
                // 1. Loading State
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                // 2. Error State
                if (snapshot.hasError) {
                  return Center(child: Text("Terjadi kesalahan: ${snapshot.error}"));
                }

                // 3. Empty State
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.folder_open, size: 60, color: Colors.grey[300]),
                        const SizedBox(height: 16),
                        const Text("Belum ada course yang diupload",
                            style: TextStyle(color: lightTextColor)),
                      ],
                    ),
                  );
                }

                final docs = snapshot.data!.docs;

                // 4. List Data
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final data = docs[index].data() as Map<String, dynamic>;
                    String statusString = data['status'] ?? 'pending';

                    // --- LOGIC TAMPILAN STATUS ---
                    Color statusColor;
                    Color badgeBgColor;
                    IconData statusIcon;
                    String statusLabel;

                    if (statusString == 'approved') {
                      statusColor = Colors.green;
                      badgeBgColor = Colors.green.withOpacity(0.1);
                      statusIcon = Icons.check_circle_outline;
                      statusLabel = 'Diterima';
                    } else if (statusString == 'rejected') {
                      statusColor = Colors.red;
                      badgeBgColor = Colors.red.withOpacity(0.1);
                      statusIcon = Icons.cancel_outlined;
                      statusLabel = 'Ditolak';
                    } else {
                      // Default: Pending
                      statusColor = Colors.orange;
                      badgeBgColor = const Color(0xFFFFF4E5); // Oranye muda
                      statusIcon = Icons.access_time_filled;
                      statusLabel = 'Pending';
                    }

                    // --- CARD UI ---
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: cardBackgroundColor, // Warna background Ungu Muda
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // A. GAMBAR THUMBNAIL (Kiri)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: data['imageUrl'] != null && data['imageUrl'].toString().isNotEmpty
                                ? Image.network(
                                    data['imageUrl'],
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) =>
                                        Container(
                                          width: 80, 
                                          height: 80, 
                                          color: Colors.grey[300], 
                                          child: const Icon(Icons.broken_image, color: Colors.grey)
                                        ),
                                  )
                                : Container(
                                    width: 80,
                                    height: 80,
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.image, color: Colors.grey),
                                  ),
                          ),
                          const SizedBox(width: 12),

                          // B. KONTEN TEKS (Kanan)
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // 1. Judul Course
                                Text(
                                  data['title'] ?? 'Tanpa Judul',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: darkTextColor,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 6),

                                // 2. Deskripsi (Multi-line)
                                Text(
                                  data['description'] ?? 'Tidak ada deskripsi tersedia.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                    height: 1.3, // Jarak antar baris
                                  ),
                                  maxLines: 3, // Mengizinkan 3 baris ke bawah
                                  overflow: TextOverflow.ellipsis,
                                ),

                                const SizedBox(height: 12),

                                // 3. Footer: Tanggal & Status Badge
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Tanggal Upload
                                    Row(
                                      children: [
                                        const Icon(Icons.calendar_today_outlined, size: 12, color: lightTextColor),
                                        const SizedBox(width: 4),
                                        Text(
                                          _formatDate(data['createdAt']),
                                          style: const TextStyle(fontSize: 10, color: lightTextColor),
                                        ),
                                      ],
                                    ),

                                    // Badge Status
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: badgeBgColor,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: statusColor.withOpacity(0.3)),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(statusIcon, size: 10, color: statusColor),
                                          const SizedBox(width: 4),
                                          Text(
                                            statusLabel,
                                            style: TextStyle(
                                              color: statusColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          );
        }
        }