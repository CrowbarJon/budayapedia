import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'package:budayapedia/pages/home.dart';
import 'package:budayapedia/pages/login.dart';

// --- 1. VARIABEL GLOBAL UNTUK MENGATUR TEMA ---
// Variabel ini "didengarkan" oleh aplikasi. Jika nilainya berubah, tampilan berubah.
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint("Error initializing Firebase: $e");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // --- 2. PEMBUNGKUS AGAR TEMA BISA BERUBAH (ValueListenableBuilder) ---
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier, // Mendengarkan variabel global di atas
      builder: (context, currentMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'BudayaPedia App',

          // --- 3. SETTING TEMA TERANG (LIGHT MODE) ---
          theme: ThemeData(
            fontFamily: 'DMSans',
            brightness: Brightness.light,
            primaryColor: const Color(0xFF2C3E50),
            scaffoldBackgroundColor: Colors.white, // Background putih
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              foregroundColor: Color(0xFF1E2A3B), // Warna teks/ikon AppBar
            ),
            // Kamu bisa tambah setting warna komponen lain di sini
          ),

          // --- 4. SETTING TEMA GELAP (DARK MODE) ---
          darkTheme: ThemeData(
            fontFamily: 'DMSans',
            brightness: Brightness.dark,
            primaryColor: const Color(0xFF1E2A3B),
            scaffoldBackgroundColor: const Color(0xFF121212), // Background hitam
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF121212),
              foregroundColor: Colors.white, // Warna teks/ikon AppBar jadi putih
            ),
            // Warna kartu/card di mode gelap
            cardColor: const Color(0xFF1E1E1E), 
          ),

          // --- 5. SAKLAR OTOMATIS (Mengikuti nilai themeNotifier) ---
          themeMode: currentMode, 

          // --- LOGIKA NAVIGASI FIREBASE (TETAP SAMA SEPERTI KODEMU) ---
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }

              if (snapshot.hasData && snapshot.data != null) {
                return const HomePage();
              }

              return const LoginPage();
            },
          ),
        );
      },
    );
  }
}