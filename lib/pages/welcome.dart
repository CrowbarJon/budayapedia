import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Tambahkan import ini
import 'package:google_sign_in/google_sign_in.dart'; // Tambahkan import ini
import 'package:budayapedia/pages/login.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  // --- FUNGSI LOGOUT ---
  Future<void> _signOut(BuildContext context) async {
    try {
      // Logout dari Google Sign-In
      await GoogleSignIn().signOut();

      // Logout dari Firebase Authentication
      await FirebaseAuth.instance.signOut();

      // Navigasi ke LoginPage dan hapus semua rute sebelumnya
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (Route<dynamic> route) => false,
      );

      print('Pengguna berhasil Logout!');
    } catch (e) {
      print('Error saat logout: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // --- BARU: AppBar dengan Tombol Logout ---
      appBar: AppBar(
        title: const Text(
          'BudayaPedia',
          style: TextStyle(color: Color(0xFF1E2A3B)),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Color(0xFF2C3E50)),
            onPressed: () => _signOut(context),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            children: <Widget>[
              // --- Bagian Atas: Logo dan Judul ---
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Gambar Logo
                    Image.asset('assets/budayapedia.png', height: 150),
                    const SizedBox(height: 16),
                    // Judul Aplikasi
                    const Text(
                      'BudayaPedia',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E2A3B),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Sub-teks
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Membantu edukasi individu untuk generasi pemimpin masa depan.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF5A6B80),
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // --- Bagian Tengah: Tombol "Mulai Pembelajaran" ---
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        // Aksi saat tombol ditekan (seharusnya navigasi ke dashboard utama)
                        // Untuk saat ini, kita biarkan navigasi ke LoginPage sesuai kode lama
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                        print('Mulai Pembelajaran ditekan!');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2C3E50),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 60,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5,
                      ),
                      child: const Text(
                        'Mulai Pembelajaran',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // --- Bagian Bawah: Teks Persetujuan ---
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 20.0,
                      ),
                      child: Text(
                        'By continuing, you agree to share contact information with people in your class. Google Classroom uses Google Workspace services, including Drive and Calendar. Learn more about information sharing and Classroom',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF8A9BAA),
                          height: 1.6,
                        ),
                      ),
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
}
