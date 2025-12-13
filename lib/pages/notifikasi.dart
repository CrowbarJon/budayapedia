import 'package:flutter/material.dart';

// Konstanta Warna 
const Color primaryColor = Color(0xFF2C3E50); 
const Color darkTextColor = Color(0xFF1E2A3B); 
const Color lightTextColor = Color(0xFF5A6B80);

// Widget Notifikasi 
class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  // Data notifikasi kini bersifat STATE untuk memungkinkan pembaruan UI
  List<Map<String, dynamic>> notifications = [
    {
      'title': 'Peringatan Kursus Baru!',
      'body': 'Chef William Wibowo telah mengunggah modul baru "Rendang: Filosofi Rasa".',
      'time': '3 menit lalu',
      'isRead': false,
      'icon': Icons.school,
      'color': Colors.blue,
    },
    {
      'title': 'Pembayaran Dikonfirmasi',
      'body': 'Pembayaran Anda untuk "Flutter Masterclass" sudah selesai.',
      'time': '1 jam lalu',
      'isRead': false,
      'icon': Icons.payments,
      'color': Colors.green,
    },
    {
      'title': 'Promo: Diskon 50%',
      'body': 'Dapatkan diskon 50% untuk semua kursus di kategori "Jawa" minggu ini!',
      'time': 'Kemarin',
      'isRead': true,
      'icon': Icons.local_offer,
      'color': Colors.orange,
    },
    {
      'title': 'Update Tersedia',
      'body': 'Aplikasi telah diperbarui dengan peningkatan kinerja.',
      'time': '2 hari lalu',
      'isRead': true,
      'icon': Icons.update,
      'color': Colors.grey,
    },
  ];
  
  // Fungsi untuk menghapus semua notifikasi
  void _clearAllNotifications() {
    setState(() {
      notifications.clear(); // Mengosongkan daftar notifikasi
    });
    // Tampilkan pesan konfirmasi 
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Semua notifikasi dibersihkan!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Memisahkan notifikasi berdasarkan status baca
    final List<Map<String, dynamic>> unreadNotifications = 
        notifications.where((n) => !n['isRead']).toList();
    final List<Map<String, dynamic>> readNotifications = 
        notifications.where((n) => n['isRead']).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifikasi', style: TextStyle(fontWeight: FontWeight.bold, color: darkTextColor)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: darkTextColor),
        actions: [
          TextButton(
            // Tombol Clear All hanya aktif jika ada notifikasi
            onPressed: notifications.isEmpty ? null : _clearAllNotifications,
            child: Text(
              'Bersihkan Semua', 
              style: TextStyle(
                // Mengubah warna teks jika tombol dinonaktifkan
                color: notifications.isEmpty ? lightTextColor.withOpacity(0.5) : primaryColor
              )
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Notifikasi Belum Dibaca
            if (unreadNotifications.isNotEmpty)
              _buildNotificationSection(
                context, 
                title: 'Notifikasi Baru (${unreadNotifications.length})',
                notifications: unreadNotifications,
                isUnread: true,
              ),

            // Notifikasi Lama
            if (readNotifications.isNotEmpty)
              _buildNotificationSection(
                context, 
                title: 'Terdahulu',
                notifications: readNotifications,
                isUnread: false,
              ),

            // Tampilkan pesan "No notifications yet" jika daftar kosong
            if (notifications.isEmpty)
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Center(
                  child: Column(
                    children: [
                      Icon(Icons.notifications_off, size: 60, color: Colors.grey[300]),
                      const SizedBox(height: 16),
                      Text('Tidak ada notifikasi saat ini.', style: TextStyle(color: lightTextColor, fontSize: 16)),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Widget pembangun bagian notifikasi (baru/lama)
  Widget _buildNotificationSection(
    BuildContext context, {
    required String title,
    required List<Map<String, dynamic>> notifications,
    required bool isUnread,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: darkTextColor)),
        ),
        ...notifications.map((notification) {
          return _buildNotificationItem(
            title: notification['title'],
            body: notification['body'],
            time: notification['time'],
            icon: notification['icon'],
            color: notification['color'],
            isUnread: isUnread,
          );
        }),
        const Divider(height: 1),
      ],
    );
  }
  
  // Widget pembangun tiap item notifikasi
  Widget _buildNotificationItem({
    required String title,
    required String body,
    required String time,
    required IconData icon,
    required Color color,
    required bool isUnread,
  }) {
    return Container(
      color: isUnread ? primaryColor.withOpacity(0.05) : Colors.white, 
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color, size: 24),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: isUnread ? FontWeight.bold : FontWeight.w500,
            color: darkTextColor,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(body, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: darkTextColor)),
            const SizedBox(height: 4),
            Text(
              time,
              style: TextStyle(
                fontSize: 12,
                color: isUnread ? primaryColor : lightTextColor,
                fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
        trailing: isUnread 
          ? const Icon(Icons.circle, size: 10, color: Colors.red) // Indikator belum dibaca
          : null,
        onTap: () {
          // [TODO] Tambahkan aksi saat notifikasi di-klik
        },
      ),
    );
  }
}