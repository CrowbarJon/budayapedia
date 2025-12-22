// info_hub_page.dart

import 'package:flutter/material.dart';

// Definisikan warna yang digunakan
const Color primaryColor = Color(0xFF2C3E50);
// Warna teks hardcode dihapus agar bisa dinamis mengikuti tema

class InfoHubPage extends StatelessWidget {
  const InfoHubPage({super.key});

  // Data Konten Statis
  static const Map<String, String> _contentData = {
    'Bantuan & FAQ':
        "FAQ:\n"
        "1. Bagaimana cara mengubah sandi? Anda dapat mengubah sandi melalui menu Akun > Keamanan Akun.\n"
        "2. Bagaimana cara melihat kemajuan belajar? Kunjungi Riwayat Pembelajaran dari halaman profil.\n"
        "3. Dukungan: Hubungi kami di support@budayapedia.id.",

    'Kebijakan Privasi':
        "Kebijakan Privasi BudayaPedia (Versi 2.1)\n\n"
        "Kami menghargai privasi Anda. Data pengguna (nama, email, riwayat belajar) dikumpulkan untuk tujuan personalisasi pengalaman belajar Anda. Kami tidak akan menjual atau menyewakan informasi pribadi Anda kepada pihak ketiga. Semua data sensitif dienkripsi dan dijamin keamanannya.",

    'Tentang Kami':
        "BudayaPedia didirikan dengan visi melestarikan dan menyebarkan warisan budaya Indonesia kepada generasi muda melalui platform digital yang interaktif dan menyenangkan. Kami berkomitmen untuk menyediakan konten yang akurat dan mudah diakses. Terima kasih telah menjadi Pelestari Budaya!",
  };

  // Widget untuk menampilkan setiap bagian konten (FAQ, Privasi, Tentang)
  // [PERUBAHAN]: Menambahkan parameter 'context' untuk mendeteksi Tema
  Widget _buildContentSection(BuildContext context, String title, String content) {
    // Cek apakah Dark Mode aktif
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    // Warna Judul: Biru tua di Light Mode, Putih di Dark Mode (agar terbaca)
    Color titleColor = isDarkMode ? Colors.white : primaryColor;
    
    // Warna Isi: Hitam di Light Mode, Abu terang di Dark Mode
    Color contentColor = Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Judul Section
          Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: titleColor, // Warna dinamis
            ),
          ),
          const SizedBox(height: 10),
          // Isi Konten
          Text(
            content,
            style: TextStyle(
              fontSize: 16,
              color: contentColor, // Warna dinamis
              height: 1.5,
            ),
          ),

          if (title == 'Tentang Kami')
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                'BudayaPedia Versi 1.5.2',
                style: TextStyle(
                  fontSize: 12,
                  // Warna teks versi (agak transparan)
                  color: contentColor.withOpacity(0.6),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Warna sub-text header
    Color subHeaderColor = Theme.of(context).textTheme.bodySmall?.color ?? Colors.grey;

    return Scaffold(
      // backgroundColor: Colors.white, // [DIHAPUS] Agar ikut tema main.dart
      appBar: AppBar(
        title: const Text(
          'Pusat Informasi BudayaPedia',
          style: TextStyle(
            fontWeight: FontWeight.bold, 
            // color: darkTextColor // [DIHAPUS] Biarkan otomatis
          ),
        ),
        // backgroundColor: Colors.white, // [DIHAPUS] Agar ikut tema
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Akses semua informasi yang Anda butuhkan tentang BudayaPedia di sini.',
              style: TextStyle(fontSize: 14, color: subHeaderColor),
            ),
            const SizedBox(height: 30),

            // --- 1. BANTUAN & FAQ ---
            _buildContentSection(
              context, // Pass context
              'Bantuan & FAQ',
              _contentData['Bantuan & FAQ']!,
            ),

            // --- 2. KEBIJAKAN PRIVASI ---
            _buildContentSection(
              context, // Pass context
              'Kebijakan Privasi',
              _contentData['Kebijakan Privasi']!,
            ),

            // --- 3. TENTANG KAMI ---
            _buildContentSection(
              context, // Pass context
              'Tentang Kami',
              _contentData['Tentang Kami']!,
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}