import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LearningHistoryPage extends StatefulWidget {
  const LearningHistoryPage({super.key});

  @override
  _LearningHistoryPageState createState() => _LearningHistoryPageState();
}

class _LearningHistoryPageState extends State<LearningHistoryPage> {
  // Variabel untuk menampung data
  List<String> _completedCourses = [];
  int _totalHours = 0;
  int _quizPassedCount = 0;

  @override
  void initState() {
    super.initState();
    _loadHistoryData();
  }

  // Fungsi membaca data dari memori HP
  Future<void> _loadHistoryData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // Ambil list judul course yang sudah selesai
      _completedCourses = prefs.getStringList('completed_courses') ?? [];
      
      // Ambil total jam (jika belum ada, default 0)
      _totalHours = prefs.getInt('total_study_hours') ?? 0;
      
      // Hitung quiz (bisa kita buat simulasi: 1 course = rata2 2 quiz lulus)
      _quizPassedCount = _completedCourses.length * 2; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Riwayat Pembelajaran',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Statistik Anda',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // GRID STATISTIK
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.4,
              children: [
                _buildStatCard(
                  icon: Icons.timer,
                  value: '${_totalHours}h',
                  label: 'Jam Belajar',
                  color: const Color(0xFFF5F3FF),
                ),
                _buildStatCard(
                  icon: Icons.school,
                  value: '${_completedCourses.length}', // REAL-TIME DATA
                  label: 'Kursus Selesai',
                  color: const Color(0xFFFFF7ED),
                ),
                _buildStatCard(
                  icon: Icons.emoji_events,
                  value: '${_completedCourses.length}', // Simulasi 1 course = 1 lencana
                  label: 'Lencana Diperoleh',
                  color: const Color(0xFFF0FDF4),
                ),
                _buildStatCard(
                  icon: Icons.quiz,
                  value: '$_quizPassedCount',
                  label: 'Kuis Lulus',
                  color: const Color(0xFFEFF6FF),
                ),
              ],
            ),
            
            const SizedBox(height: 30),
            const Text(
              'Aktivitas Terbaru',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // LIST AKTIVITAS (Berdasarkan data _completedCourses)
            _completedCourses.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Column(
                        children: [
                          Icon(Icons.history_toggle_off, size: 48, color: Colors.grey[300]),
                          const SizedBox(height: 10),
                          const Text("Belum ada kursus yang diselesaikan"),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _completedCourses.length,
                    itemBuilder: (context, index) {
                      // Kita balik urutannya biar yang baru selesai ada di atas
                      final courseName = _completedCourses.reversed.toList()[index];
                      return _buildActivityItem(
                        title: 'Menyelesaikan Course $courseName',
                        time: 'Baru saja', // Karena kita tidak simpan tanggal, hardcode dulu
                        icon: Icons.check_circle_outline,
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({required IconData icon, required String value, required String label, required Color color}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24, color: Colors.black87),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem({required String title, required String time, required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Icon(icon, size: 20, color: const Color(0xFF2C3E50)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}