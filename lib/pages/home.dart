// lib/pages/home.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// Import Halaman Utama Lain:
import 'mycourse.dart';
import 'courseview.dart';
import 'setting_panel.dart';
import 'notifikasi.dart';
import 'profile.dart';
import 'course_model.dart';
// PASTIKAN IMPORT INI SESUAI DENGAN LOKASI FILE ANDA
import '../add_course/add_course.dart'; 

// Definisikan warna yang digunakan dalam desain Anda
const Color primaryColor = Color(0xFF2C3E50);
const Color darkTextColor = Color(0xFF1E2A3B);
const Color lightTextColor = Color(0xFF5A6B80);
const Color navyBlue = Color(0xFF181D31);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  void _showSideSettingsPanel() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return const SettingsPanel();
      },
    );
  }

  void _navigateToNotifications() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NotificationPage()),
    );
  }

  // --- FUNGSI BARU: PINDAH KE TAB COURSES ---
  void _navigateToCoursesTab() {
    setState(() {
      _currentIndex = 1; // 1 adalah index untuk Courses/MyCoursePage
    });
  }

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeContentWidget(
        onNotificationsPressed: _navigateToNotifications,
        onSettingsPressed: _showSideSettingsPanel,
        onViewAllPressed: _navigateToCoursesTab, 
      ),
      MyCoursePage(),
      // [PERUBAHAN DI SINI] Mengganti Text placeholder dengan Halaman AddCoursePage
      const AddCoursePage(), 
      const ProfilePage(),
    ];
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Menggunakan IndexedStack agar state halaman tidak hilang saat pindah tab (opsional, tapi disarankan)
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryColor,
        unselectedItemColor: lightTextColor,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Courses'),
          // Ikon "New" sekarang akan membuka AddCoursePage
          BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'New'), 
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    );
  }
}

// =======================================================
// B. WIDGET KONTEN BERANDA (Konten Scrollable Index 0)
// =======================================================

class HomeContentWidget extends StatefulWidget {
  final VoidCallback onNotificationsPressed;
  final VoidCallback onSettingsPressed;
  final VoidCallback onViewAllPressed; 

  const HomeContentWidget({
    super.key,
    required this.onNotificationsPressed,
    required this.onSettingsPressed,
    required this.onViewAllPressed,
  });

  @override
  State<HomeContentWidget> createState() => _HomeContentWidgetState();
}

class _HomeContentWidgetState extends State<HomeContentWidget> {
  int _completedCoursesCount = 0;

  @override
  void initState() {
    super.initState();
    _loadCompletedCoursesCount();
  }

  Future<void> _loadCompletedCoursesCount() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      int completedCount = 0;

      for (var course in allCourses) {
        String progressKey = 'progress_${course.title}';
        String? savedData = prefs.getString(progressKey);

        if (savedData != null) {
          List<dynamic> decoded = jsonDecode(savedData);
          List<bool> moduleCompleted = decoded.map((e) => e as bool).toList();

          if (moduleCompleted.isNotEmpty &&
              moduleCompleted.every((completed) => completed)) {
            completedCount++;
          }
        }
      }

      if (mounted) {
        setState(() {
          _completedCoursesCount = completedCount;
        });
      }
    } catch (e) {
      debugPrint('Error loading completed courses: $e');
    }
  }

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

  Widget _buildCategoryCard(String title, String imagePath) {
    return Container(
      height: 120,
      width: 150,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.3),
            BlendMode.darken,
          ),
        ),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildPopularCourseCard(BuildContext context, Course courseData) {
    String instructorName = _getInstructorName(courseData.title);

    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.asset(
              courseData.imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 200,
                color: Colors.grey,
                child: const Center(child: Text("Image Not Found")),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  courseData.title,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: darkTextColor,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  courseData.description,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: lightTextColor,
                      ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: Size.zero,
                      ),
                      child: Text(
                        instructorName, 
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      courseData.duration,
                      style: const TextStyle(color: lightTextColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Logic untuk menentukan Popular Course
    final Course popularCourse = allCourses.firstWhere(
      (course) => course.title.contains("Rendang") || course.title.contains("Minang"), 
      orElse: () => allCourses[0], 
    );

    final user = FirebaseAuth.instance.currentUser;

    final String username;
    if (user?.displayName != null && user!.displayName!.isNotEmpty) {
      username = user.displayName!;
    } else if (user?.email != null) {
      String emailPrefix = user!.email!.split('@').first;
      username = emailPrefix.isNotEmpty
          ? emailPrefix[0].toUpperCase() +
              emailPrefix.substring(1).toLowerCase()
          : 'Pengguna';
    } else {
      username = "Pengguna";
    }

    final List<Course> uniqueCategoryCourses = allCourses
        .where((course) => course.title != popularCourse.title)
        .toList();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // --- 1. Header Profil ---
          Container(
            padding: const EdgeInsets.only(
              top: 50,
              left: 20,
              right: 20,
              bottom: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: navyBlue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.person, color: navyBlue),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Halo, $username!',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              'Student',
                              style: TextStyle(color: lightTextColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: Color(0xFF27AE60),
                          size: 16,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '$_completedCoursesCount Course${_completedCoursesCount != 1 ? 's' : ''} Diselesaikan',
                          style: const TextStyle(
                            color: lightTextColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.notifications_none,
                        color: lightTextColor,
                      ),
                      onPressed: widget.onNotificationsPressed,
                    ),
                    const SizedBox(width: 5),
                    IconButton(
                      icon: const Icon(
                        Icons.settings_outlined,
                        color: lightTextColor,
                      ),
                      onPressed: widget.onSettingsPressed,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // --- 2. Popular Now Header ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Popular Sekarang',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.flash_on, size: 16),
                  label: const Text('For You', style: TextStyle(fontSize: 14)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFCC33),
                    foregroundColor: darkTextColor,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    minimumSize: Size.zero,
                  ),
                ),
              ],
            ),
          ),

          // --- 3. Popular Course Card ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CourseDetailsView(course: popularCourse),
                  ),
                );
              },
              child: _buildPopularCourseCard(context, popularCourse),
            ),
          ),

          // --- 4. Course Categories Header ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Kategori Course',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                TextButton(
                  onPressed: widget.onViewAllPressed, // AKSI VIEW ALL DIHUBUNGKAN
                  child: const Text(
                    'View all',
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // --- 5. Course Categories (Horizontal Scroll) ---
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              itemCount: uniqueCategoryCourses.length,
              itemBuilder: (context, index) {
                final course = uniqueCategoryCourses[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CourseDetailsView(course: course),
                      ),
                    );
                  },
                  child: _buildCategoryCard(course.category, course.imageUrl),
                );
              },
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}