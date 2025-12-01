import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:budayapedia/pages/welcome.dart';

void main() async {
  // 1. Wajib ada: Memastikan binding sudah diinisialisasi sebelum memanggil native code.
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // 2. Inisialisasi Firebase menggunakan opsi yang dihasilkan oleh FlutterFire CLI
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    // Menggunakan debugPrint untuk logging yang lebih aman
    debugPrint("Error initializing Firebase: $e");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BudayaPedia App',
      theme: ThemeData(fontFamily: 'DMSans'),
      home: const WelcomePage(),
    );
  }
}

// Catatan: Kelas MyHomePage, _MyHomePageState, dan semua kode counter
// telah dihapus karena tidak lagi diperlukan dan digantikan oleh WelcomePage.