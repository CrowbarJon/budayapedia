import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:budayapedia/pages/welcome.dart';
// PENTING: Sesuaikan path import ini dengan lokasi file InfoHubPage kamu
import '../infoHUB.dart';

const Color primaryColor = Color(0xFF2C3E50);
const Color darkTextColor = Color(0xFF1E2A3B);
const Color lightTextColor = Color(0xFF5A6B80);

class SettingsPanel extends StatefulWidget {
  const SettingsPanel({super.key});

  @override
  State<SettingsPanel> createState() => _SettingsPanelState();
}

class _SettingsPanelState extends State<SettingsPanel> {
  // State lokal untuk menyimpan status toggle
  bool _pushNotificationsEnabled = true;
  bool _newCourseAlertsEnabled = false;
  bool _useWifiEnabled = true;

  // Widget pembantu untuk item pengaturan yang memiliki Toggle Switch
  Widget _buildSettingsToggle({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      dense: true,
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: darkTextColor,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 12, color: lightTextColor),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeThumbColor: primaryColor,
        inactiveTrackColor: Colors.grey[300],
      ),
    );
  }

  // Widget pembantu untuk item pengaturan standar (non-toggle)
  Widget _buildSettingsTile(
    BuildContext context,
    IconData icon,
    String title,
    Color color,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: const TextStyle(color: darkTextColor)),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75, // 75% tinggi layar
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle untuk menutup panel (garis kecil di atas)
          Center(
            child: Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 15),

          Text(
            'Pengaturan Cepat',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontWeight: FontWeight.bold,
              color: darkTextColor,
            ),
          ),
          const Divider(height: 30),

          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                // === OPSI NOTIFIKASI (TOGGLE) ===
                _buildSettingsToggle(
                  title: 'Push Notifications',
                  subtitle: 'Aktifkan notifikasi aplikasi',
                  value: _pushNotificationsEnabled,
                  onChanged: (newValue) {
                    setState(() {
                      _pushNotificationsEnabled = newValue;
                    });
                  },
                ),
                _buildSettingsToggle(
                  title: 'Alert Kursus Baru',
                  subtitle: 'Pemberitahuan kursus yang baru diunggah',
                  value: _newCourseAlertsEnabled,
                  onChanged: (newValue) {
                    setState(() {
                      _newCourseAlertsEnabled = newValue;
                    });
                  },
                ),
                const Divider(indent: 16, endIndent: 16, height: 1),

                // === OPSI DATA & STORAGE (TOGGLE) ===
                _buildSettingsToggle(
                  title: 'Gunakan WiFi Saja',
                  subtitle: 'Mengurangi penggunaan data seluler',
                  value: _useWifiEnabled,
                  onChanged: (newValue) {
                    setState(() {
                      _useWifiEnabled = newValue;
                    });
                  },
                ),
                const Divider(indent: 16, endIndent: 16, height: 1),

                // === OPSI PUSAT INFORMASI (DIGABUNG) ===
                // Ini menggantikan menu Kebijakan Privasi & Pusat Bantuan yang lama
                _buildSettingsTile(
                  context,
                  Icons.info_outline, // Ikon 'i' (Informasi)
                  'Pusat Informasi & Bantuan', // Judul baru yang digabung
                  primaryColor,
                  () {
                    // 1. Tutup panel setting (bottom sheet)
                    Navigator.pop(context);

                    // 2. Buka halaman InfoHubPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const InfoHubPage(),
                      ),
                    );
                  },
                ),

                // === LOGOUT ===
                _buildSettingsTile(
                  context,
                  Icons.logout,
                  'Logout',
                  Colors.red,
                  () async {
                    Navigator.pop(context); // Tutup panel

                    try {
                      await FirebaseAuth.instance.signOut();

                      // Navigasi ke halaman Welcome dan hapus history route
                      if (context.mounted) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WelcomePage(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      }
                    } catch (e) {
                      print("Error saat sign out: $e");
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}