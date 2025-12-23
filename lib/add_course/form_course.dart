// lib/add_course/form_course.dart

import 'package:flutter/material.dart';
import 'dart:io'; // Untuk File handling
import 'package:image_picker/image_picker.dart'; // Untuk ambil gambar
import '../pages/course_model.dart'; // Pastikan path ini sesuai dengan model course kamu
import 'isi_course.dart'; // Import halaman editor materi

class FormCoursePage extends StatefulWidget {
  // Parameter opsional untuk menerima data Draft
  final CourseData? draftData;

  const FormCoursePage({Key? key, this.draftData}) : super(key: key);

  @override
  State<FormCoursePage> createState() => _FormCoursePageState();
}

class _FormCoursePageState extends State<FormCoursePage> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  // Controllers
  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late TextEditingController _descController;
  
  // State Variables
  String _selectedCategory = 'Kuliner';
  File? _thumbnailFile;

  // List Kategori
  final List<String> _categories = ['Kuliner', 'Tari', 'Adat', 'Sejarah', 'Musik', 'Other'];

  @override
  void initState() {
    super.initState();
    
    // Inisialisasi Controller
    _titleController = TextEditingController();
    _authorController = TextEditingController();
    _descController = TextEditingController();

    // CEK DRAFT: Jika ada data draft, isi form otomatis
    if (widget.draftData != null) {
      _titleController.text = widget.draftData!.title;
      _authorController.text = widget.draftData!.author;
      _descController.text = widget.draftData!.description;
      
      // Cek apakah kategori yang disimpan ada di list, jika tidak pakai default
      if (widget.draftData!.category != null && _categories.contains(widget.draftData!.category)) {
        _selectedCategory = widget.draftData!.category!;
      }

      // Restore gambar thumbnail jika ada
      if (widget.draftData!.thumbnail != null && widget.draftData!.thumbnail is File) {
        _thumbnailFile = widget.draftData!.thumbnail;
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _descController.dispose();
    super.dispose();
  }

  // Fungsi Ambil Gambar dari Galeri
  Future<void> _pickThumbnail() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _thumbnailFile = File(image.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal mengambil gambar: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.draftData != null ? 'Lanjutkan Draft' : 'Buat Course Baru',
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Upload Thumbnail Area
              GestureDetector(
                onTap: _pickThumbnail,
                child: Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: _thumbnailFile == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_a_photo, size: 40, color: Colors.grey[400]),
                            const SizedBox(height: 8),
                            Text("Tap untuk upload thumbnail", style: TextStyle(color: Colors.grey[500])),
                          ],
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(11),
                          child: Image.file(_thumbnailFile!, fit: BoxFit.cover),
                        ),
                ),
              ),
              const SizedBox(height: 24),

              // 2. Input Judul
              _buildLabel("Judul Course"),
              TextFormField(
                controller: _titleController,
                decoration: _inputDecoration("Contoh: Rendang Padang"),
                validator: (val) => val == null || val.isEmpty ? 'Judul wajib diisi' : null,
              ),
              const SizedBox(height: 16),

              // 3. Input Penulis
              _buildLabel("Penulis"),
              TextFormField(
                controller: _authorController,
                decoration: _inputDecoration("Nama Pemateri"),
                validator: (val) => val == null || val.isEmpty ? 'Penulis wajib diisi' : null,
              ),
              const SizedBox(height: 16),

              // 4. Input Kategori
              _buildLabel("Kategori"),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedCategory,
                    isExpanded: true,
                    items: _categories.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                    onChanged: (val) => setState(() => _selectedCategory = val!),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 5. Input Deskripsi
              _buildLabel("Deskripsi"),
              TextFormField(
                controller: _descController,
                maxLines: 4,
                decoration: _inputDecoration("Jelaskan ringkasan tentang course ini..."),
                validator: (val) => val == null || val.isEmpty ? 'Deskripsi wajib diisi' : null,
              ),
              
              const SizedBox(height: 30),

              // 6. Tombol Lanjut ke Editor Materi
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2C3E50), // Warna Primary
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Validasi Thumbnail (Opsional, boleh dihapus jika thumbnail tidak wajib)
                      // if (_thumbnailFile == null) {
                      //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Harap upload thumbnail")));
                      //   return;
                      // }

                      // Pindah ke Halaman Editor (isi_course.dart)
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IsiCoursePage(
                            courseData: {
                              'title': _titleController.text,
                              'author': _authorController.text,
                              'category': _selectedCategory,
                              'description': _descController.text,
                              'imageFile': _thumbnailFile, // Kirim File Objek
                              // 'draftId': widget.draftData?.id // Jika nanti butuh update ID draft yg sudah ada
                            },
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Lanjut Isi Materi", 
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      filled: true,
      fillColor: Colors.grey[50],
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text, 
        style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black87)
      ),
    );
  }
}