import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart'; 
// Import file navigasi
import 'login.dart'; 
import '/securityPage.dart';
import '/learning_history_page.dart'; 
import '/setting_pages.dart'; 
import '/infoHub.dart'; 

// Definisikan warna yang digunakan dalam desain Anda (Konsistensi)
const Color primaryColor = Color(0xFF2C3E50); // Biru Tua (Aksen utama)
const Color darkTextColor = Color(0xFF1E2A3B);
const Color lightTextColor = Color(0xFF5A6B80);
const Color accentColor = Color(0xFFFFA000); // Oranye (Aksen tombol/edit)
const Color borderColor = Color(0xFFE0E0E0); // Warna Border

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? user = FirebaseAuth.instance.currentUser;
  late String currentUsername;
  final ImagePicker _picker = ImagePicker(); 

  @override
  void initState() {
    super.initState();
    currentUsername = getUsername(user);
  }

  // --- UTILITY FUNGSI ---
  String getUsername(User? user) {
      if (user?.displayName != null && user!.displayName!.isNotEmpty) {
          return user.displayName!;
      } else if (user?.email != null) {
          String emailPrefix = user!.email!.split('@').first;
          return emailPrefix.isNotEmpty 
              ? emailPrefix[0].toUpperCase() + emailPrefix.substring(1).toLowerCase() 
              : 'Pengguna';
      } else {
          return "Pengguna Budayapedia"; 
      }
  }

  Future<void> _handleSignOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (Route<dynamic> route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Gagal Logout: $e")));
      }
    }
  }

  void _pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) _uploadImage(image);
    if (mounted) Navigator.pop(context); 
  }
  void _pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) _uploadImage(image);
    if (mounted) Navigator.pop(context); 
  }
  void _uploadImage(XFile image) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Mengunggah foto: ${image.name}...",)));
  }
  
  void _showPhotoOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: const EdgeInsets.all(16.0), child: Text('Foto Profil', style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold, color: darkTextColor))),
            ListTile(leading: const Icon(Icons.camera_alt, color: darkTextColor), title: const Text('Kamera', style: TextStyle(color: darkTextColor)), onTap: _pickImageFromCamera),
            ListTile(leading: const Icon(Icons.photo_library, color: darkTextColor), title: const Text('Galeri', style: TextStyle(color: darkTextColor)), onTap: _pickImageFromGallery),
            const SizedBox(height: 10),
          ],
        );
      },
    );
  }

  void _editUsername() {
    final TextEditingController nameController = TextEditingController(text: currentUsername);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Ubah Nama Pengguna"),
          content: TextField(controller: nameController, decoration: const InputDecoration(hintText: "Masukkan nama baru")),
          actions: <Widget>[
            TextButton(child: const Text("Batal", style: TextStyle(color: lightTextColor)), onPressed: () => Navigator.pop(context)),
            ElevatedButton(
              onPressed: () {
                final newName = nameController.text.trim();
                if (newName.isNotEmpty) {
                  _updateUsername(newName);
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: primaryColor, foregroundColor: Colors.white),
              child: const Text("Simpan"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateUsername(String newName) async {
    try {
      if (user != null) {
        await user!.updateDisplayName(newName);
        setState(() { currentUsername = newName; });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Nama berhasil diperbarui!")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Gagal memperbarui nama: $e")));
    }
  }
  // --- END UTILITY FUNGSI ---
  
  
  // WIDGET KARTU MENU INTERAKTIF YANG LEBIH CLEAN
  Widget _buildInteractiveCard({
    required BuildContext context, 
    required IconData icon, 
    required String title, 
    required VoidCallback onTap, 
    bool isLogout = false
  }) {
    // Warna untuk Ikon & Teks
    final Color iconColor = isLogout ? Colors.red.shade700 : primaryColor;
    final Color textColor = isLogout ? Colors.red.shade700 : darkTextColor;

    return InkWell( // Menggunakan InkWell untuk efek riak yang lebih baik (UI/UX)
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 0), // Padding horizontal 0 karena ada divider
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: borderColor, width: 1.0)),
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 24),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                title, 
                style: TextStyle(
                  fontSize: 16, 
                  fontWeight: FontWeight.w500,
                  color: textColor
                )
              ),
            ),
            isLogout 
                ? const SizedBox.shrink() 
                : Icon(Icons.chevron_right, color: lightTextColor.withOpacity(0.8)),
          ],
        ),
      ),
    );
  }


  // WIDGET HEADER PROFIL (Pemusatan Informasi Akun)
  Widget _buildProfileHeader(String email, String photoUrl) {
    return Container(
      padding: const EdgeInsets.only(top: 30, bottom: 40),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: borderColor, width: 1.5)),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 40, 
                backgroundColor: primaryColor.withOpacity(0.1), 
                backgroundImage: photoUrl.isNotEmpty ? NetworkImage(photoUrl) as ImageProvider : null, 
                child: photoUrl.isEmpty ? const Icon(Icons.person, size: 40, color: primaryColor) : null
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: _showPhotoOptions, 
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: accentColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(Icons.edit, size: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              Text(currentUsername, style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold, color: darkTextColor)),
              GestureDetector(
                onTap: _editUsername, 
                child: const Padding(
                  padding: EdgeInsets.only(left: 8.0), 
                  child: Icon(Icons.mode_edit_outline, size: 18, color: lightTextColor)
                )
              ),
            ]
          ),
          const SizedBox(height: 5),
          Text(email, style: const TextStyle(fontSize: 14, color: lightTextColor)),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    final String email = user?.email ?? 'Tidak Tersedia';
    final String photoUrl = user?.photoURL ?? '';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Akun Saya', style: TextStyle(fontWeight: FontWeight.bold, color: darkTextColor)),
        backgroundColor: Colors.white,
        elevation: 0, // Hilangkan shadow AppBar untuk tampilan yang lebih bersih
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0), 
        child: Column(
          children: <Widget>[
            // --- 1. Header Profil ---
            _buildProfileHeader(email, photoUrl),
            
            // --- 2. KELOMPOK MENU: AKTIVITAS & RIWAYAT ---
            const SizedBox(height: 20),
            const Align(alignment: Alignment.centerLeft, child: Text('Aktivitas & Riwayat', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: lightTextColor))),
            const SizedBox(height: 5),
            
            // RIWAYAT PEMBELAJARAN
            _buildInteractiveCard(
              context: context, 
              icon: Icons.history, 
              title: 'Riwayat Pembelajaran', 
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LearningHistoryPage())),
            ),
            
            // --- 3. KELOMPOK MENU: PENGATURAN & KEAMANAN ---
            const SizedBox(height: 20),
            const Align(alignment: Alignment.centerLeft, child: Text('Pengaturan Akun', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: lightTextColor))),
            const SizedBox(height: 5),

            // KEAMANAN AKUN
            _buildInteractiveCard(
              context: context, 
              icon: Icons.lock_outline, 
              title: 'Keamanan Akun', 
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SecurityPage())),
            ),
            
            // PENGATURAN APLIKASI
            _buildInteractiveCard(
              context: context, 
              icon: Icons.settings_outlined, 
              title: 'Pengaturan Aplikasi', 
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()))
            ),
            
            // --- 4. PUSAT INFORMASI & DUKUNGAN (Tombol Tunggal) ---
            const SizedBox(height: 20),
            const Align(alignment: Alignment.centerLeft, child: Text('Dukungan & Informasi', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: lightTextColor))),
            const SizedBox(height: 5),

            // PUSAT INFORMASI BUDAYAPEDIA
            _buildInteractiveCard(
              context: context, 
              icon: Icons.info_outline, 
              title: 'Pusat Informasi BudayaPedia', 
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const InfoHubPage())),
            ),


            // --- 5. KELOMPOK MENU: LOGOUT ---
            const SizedBox(height: 30),
            _buildInteractiveCard(
              context: context, 
              icon: Icons.logout, 
              title: 'Logout', 
              onTap: _handleSignOut, 
              isLogout: true
            ),
             const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}