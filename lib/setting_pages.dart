import 'package:flutter/material.dart';
import 'package:budayapedia/main.dart'; // [PENTING] Import ini agar tombol tersambung ke main.dart

// Definisikan warna yang digunakan
const Color primaryColor = Color(0xFF2C3E50);
const Color lightTextColor = Color(0xFF5A6B80);
const Color accentColor = Color(0xFFFFCC33);

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // State Notifikasi
  bool _isStreakNotificationEnabled = true;
  String _currentLanguage = 'Bahasa Indonesia';

  // Nilai Cache Simulasi
  String _cacheSize = '56.8 MB';

  // Fungsi untuk membersihkan Cache
  void _clearCache() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Bersihkan Cache"),
        content: Text(
          "Yakin ingin menghapus cache sebesar $_cacheSize? Ini akan membebaskan ruang penyimpanan.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _cacheSize = '0.0 MB';
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Cache berhasil dibersihkan!")),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
            child: const Text("Ya, Bersihkan"),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk mengubah Bahasa
  void _changeLanguage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Pilih Bahasa Aplikasi"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Bahasa Indonesia'),
                trailing: _currentLanguage == 'Bahasa Indonesia'
                    ? const Icon(Icons.check_circle, color: primaryColor)
                    : null,
                onTap: () {
                  setState(() {
                    _currentLanguage = 'Bahasa Indonesia';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('English'),
                trailing: _currentLanguage == 'English'
                    ? const Icon(Icons.check_circle, color: primaryColor)
                    : null,
                onTap: () {
                  setState(() {
                    _currentLanguage = 'English';
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    ).then((_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Bahasa diubah menjadi $_currentLanguage")),
        );
      }
    });
  }

  // Widget Toggle Option
  Widget _buildToggleOption(
    String title,
    String subtitle,
    IconData icon,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return ListTile(
      leading: Icon(icon, color: primaryColor),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 12, color: lightTextColor),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeThumbColor: accentColor,
      ),
      onTap: () => onChanged(!value),
    );
  }

  // Widget Action Option
  Widget _buildActionOption(
    String title,
    String trailingText,
    IconData icon,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: primaryColor),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(trailingText, style: const TextStyle(color: lightTextColor)),
          const Icon(Icons.chevron_right, color: lightTextColor, size: 18),
        ],
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Cek apakah Dark Mode sedang aktif berdasarkan themeNotifier dari main.dart
    bool isDarkMode = themeNotifier.value == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pengaturan Aplikasi',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // --- 1. KELOMPOK PERSONALISASI UI ---
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 20, 16, 10),
              child: Text(
                'Tampilan & Aksesibilitas',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: lightTextColor,
                ),
              ),
            ),

            // [BAGIAN YANG SUDAH DIPERBAIKI]
            _buildToggleOption(
              'Mode Gelap',
              'Mengubah latar belakang menjadi gelap (beta)',
              Icons.dark_mode_outlined,
              isDarkMode, // Menggunakan nilai dari main.dart
              (newValue) {
                // 1. Mengubah tema aplikasi secara global
                themeNotifier.value = newValue ? ThemeMode.dark : ThemeMode.light;
                
                // 2. [WAJIB] Refresh UI SettingsPage agar tombol switch bergeser
                setState(() {}); 
              },
            ),

            _buildActionOption(
              'Bahasa Aplikasi',
              _currentLanguage,
              Icons.language,
              _changeLanguage,
            ),
            const Divider(height: 1, indent: 16, endIndent: 16),

            // --- 2. KELOMPOK NOTIFIKASI ---
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 20, 16, 10),
              child: Text(
                'Notifikasi',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: lightTextColor,
                ),
              ),
            ),

            _buildToggleOption(
              'Pengingat Streak',
              'Pengingat harian agar streak tidak terputus',
              Icons.notifications_active_outlined,
              _isStreakNotificationEnabled,
              (newValue) {
                setState(() {
                  _isStreakNotificationEnabled = newValue;
                });
              },
            ),

            _buildToggleOption(
              'Kuis & Tantangan Baru',
              'Dapatkan info saat materi atau kuis baru dirilis',
              Icons.notifications_none,
              true,
              (newValue) {},
            ),

            // --- 3. KELOMPOK DATA & CACHE ---
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 20, 16, 10),
              child: Text(
                'Pengelolaan Data',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: lightTextColor,
                ),
              ),
            ),

            _buildActionOption(
              'Bersihkan Cache',
              _cacheSize,
              Icons.cleaning_services,
              _clearCache,
            ),

            _buildActionOption(
              'Unduh Data Saya',
              '0.5 GB',
              Icons.cloud_download_outlined,
              () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Memulai proses unduhan data')),
                );
              },
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}