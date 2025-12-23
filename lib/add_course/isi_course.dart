// lib/add_course/isi_course.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math' as math; 

// --- WARNA TEMA (SESUAI REFERENSI) ---
const Color primaryColor = Color(0xFF2C3E50); // Warna Teks Utama (Gelap)
const Color sidebarBg = Color(0xFFF8F9FA);    // Background Sidebar (Putih Abu)
const Color activeItemBg = Color(0xFFE2E6EA); // Background Item saat dipilih
const Color greenColor = Color(0xFF27AE60);   // Hijau (Bullet Point)
const Color cardBg = Color(0xFFF5F7FA);       // Background Halaman Utama
const Color quizColor = Color(0xFFE74C3C);
const Color flipColor = Color(0xFF3498DB);

// --- PILIHAN WARNA KARTU ---
final Map<String, Color> cardColors = {
  'cream': const Color(0xFFF9F4E6),
  'mint': const Color(0xFFE8F5E9),
  'blue': const Color(0xFFE3F2FD),
  'purple': const Color(0xFFF3E5F5),
  'white': Colors.white, 
};

class IsiCoursePage extends StatefulWidget {
  final Map<String, dynamic> courseData;

  const IsiCoursePage({Key? key, required this.courseData}) : super(key: key);

  @override
  State<IsiCoursePage> createState() => _IsiCoursePageState();
}

class _IsiCoursePageState extends State<IsiCoursePage> {
  List<Map<String, dynamic>> modules = [
    {
      'title': 'Modul 1: Pendahuluan',
      'items': <Map<String, dynamic>>[], 
    },
  ];

  int _activeModuleIndex = 0;
  final TextEditingController _moduleTitleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadActiveModuleTitle();
  }

  void _loadActiveModuleTitle() {
    _moduleTitleController.text = modules[_activeModuleIndex]['title'] ?? '';
  }

  // --- LOGIC PINDAH POSISI ---
  void _moveItemUp(int index) {
    if (index > 0) {
      setState(() {
        final items = modules[_activeModuleIndex]['items'];
        final item = items.removeAt(index);
        items.insert(index - 1, item);
      });
    }
  }

  void _moveItemDown(int index) {
    final items = modules[_activeModuleIndex]['items'];
    if (index < items.length - 1) {
      setState(() {
        final item = items.removeAt(index);
        items.insert(index + 1, item);
      });
    }
  }

  // --- LOGIC CRUD ITEM ---
  void _addTextBlock() {
    setState(() {
      modules[_activeModuleIndex]['items'].add({
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'type': 'text',
        'content': '',
      });
    });
  }

  void _addFlipCardBlock() {
    setState(() {
      modules[_activeModuleIndex]['items'].add({
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'type': 'flip',
        'frontColor': 'cream',
        'backColor': 'white',
        'front': '',      
        'back': '',       
      });
    });
  }

  void _addQuizBlock() {
    setState(() {
      modules[_activeModuleIndex]['items'].add({
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'type': 'quiz',
        'question': '',
        'options': ['', '', '', ''],
        'correct': 0,
      });
    });
  }

  void _deleteItem(int itemIndex) {
    setState(() {
      modules[_activeModuleIndex]['items'].removeAt(itemIndex);
    });
  }

  // --- LOGIC CRUD MODULE ---
  void _addNewModule() {
    setState(() {
      modules.add({
        'title': 'Modul ${modules.length + 1}',
        'items': <Map<String, dynamic>>[],
      });
      _activeModuleIndex = modules.length - 1;
      _loadActiveModuleTitle();
    });
  }

  void _deleteModule(int index) {
    if (modules.length <= 1) {
      _showError("Minimal 1 modul harus ada");
      return;
    }
    setState(() {
      modules.removeAt(index);
      if (_activeModuleIndex >= modules.length) {
        _activeModuleIndex = modules.length - 1;
      }
      _loadActiveModuleTitle();
    });
  }

  // --- PUBLISH LOGIC ---
  Future<void> _publishCourse() async {
    modules[_activeModuleIndex]['title'] = _moduleTitleController.text;

    for (int i = 0; i < modules.length; i++) {
      List items = modules[i]['items'];
      if (items.length < 3) {
        _showError('Gagal: Modul ${i + 1} harus memiliki minimal 3 konten!');
        return;
      }
      for (var item in items) {
        if (item['type'] == 'text' && (item['content'] == null || item['content'].isEmpty)) {
           _showError("Ada Text Block kosong di Modul ${i+1}"); return;
        }
        if (item['type'] == 'flip' && (item['front'].isEmpty || item['back'].isEmpty)) {
           _showError("FlipCard di Modul ${i+1} belum lengkap"); return;
        }
        if (item['type'] == 'quiz' && (item['question'].isEmpty || item['options'].contains(''))) {
           _showError("Quiz di Modul ${i+1} belum lengkap"); return;
        }
      }
    }

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        _showError('Anda harus login!');
        return;
      }

      final completeData = {
        ...widget.courseData,
        'authorId': user.uid,
        'createdAt': FieldValue.serverTimestamp(),
        'status': 'pending',
        'modules': modules,
        'totalModules': modules.length,
      };

      await FirebaseFirestore.instance.collection('courses').add(completeData);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Course berhasil diupload!')),
        );
        Navigator.popUntil(context, (route) => route.isFirst);
      }
    } catch (e) {
      _showError('Gagal upload: $e');
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), backgroundColor: Colors.red));
  }

  // --- UI BUILDERS ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cardBg,
      appBar: AppBar(
        title: Text(
          "Edit: ${widget.courseData['title']}",
          style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: primaryColor),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: ElevatedButton(
              onPressed: _publishCourse,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text("PUBLISH", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
      drawer: _buildDrawerSidebar(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("JUDUL MODUL ${_activeModuleIndex + 1}", style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
                TextField(
                  controller: _moduleTitleController,
                  onChanged: (val) => modules[_activeModuleIndex]['title'] = val,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryColor),
                  decoration: const InputDecoration(
                    isDense: true, border: InputBorder.none, hintText: "Contoh: Pengenalan Dasar",
                  ),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: modules[_activeModuleIndex]['items'].length + 1,
              itemBuilder: (context, index) {
                if (index == modules[_activeModuleIndex]['items'].length) {
                  return const SizedBox(height: 80);
                }
                final item = modules[_activeModuleIndex]['items'][index];
                return _buildItemEditor(index, item);
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Tambah:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
            const SizedBox(width: 10),
            _buildAddButton(Icons.text_fields, "Teks", primaryColor, _addTextBlock),
            const SizedBox(width: 8),
            _buildAddButton(Icons.flip, "FlipCard", flipColor, _addFlipCardBlock),
            const SizedBox(width: 8),
            _buildAddButton(Icons.quiz, "Quiz", quizColor, _addQuizBlock),
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton(IconData icon, String label, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 4),
            Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }

  // --- BUILD ITEM EDITOR ---
  Widget _buildItemEditor(int index, Map<String, dynamic> item) {
    String type = item['type'];
    int totalItems = modules[_activeModuleIndex]['items'].length;

    if (item['id'] == null) {
      item['id'] = DateTime.now().millisecondsSinceEpoch.toString() + index.toString();
    }

    return Container(
      key: ValueKey(item['id']), 
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 5)],
      ),
      child: Column(
        children: [
          // --- HEADER ITEM ---
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: _getHeaderColor(type).withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              children: [
                Icon(_getIcon(type), size: 18, color: _getHeaderColor(type)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Item ${index + 1}: ${_getTypeLabel(type)}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: _getHeaderColor(type)),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                
                // SATU ICON MENU (Naik, Turun, Hapus)
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert, size: 20, color: Colors.grey),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  onSelected: (value) {
                    if (value == 'up') _moveItemUp(index);
                    if (value == 'down') _moveItemDown(index);
                    if (value == 'delete') _deleteItem(index);
                  },
                  itemBuilder: (context) => [
                    if (index > 0)
                      const PopupMenuItem(
                        value: 'up', 
                        child: Row(children: [Icon(Icons.arrow_upward_rounded, size: 20, color: Colors.black87), SizedBox(width: 10), Text("Geser Naik")])
                      ),
                    if (index < totalItems - 1)
                      const PopupMenuItem(
                        value: 'down', 
                        child: Row(children: [Icon(Icons.arrow_downward_rounded, size: 20, color: Colors.black87), SizedBox(width: 10), Text("Geser Turun")])
                      ),
                    const PopupMenuItem(
                      value: 'delete', 
                      child: Row(children: [Icon(Icons.delete_outline, size: 20, color: Colors.red), SizedBox(width: 10), Text("Hapus Item", style: TextStyle(color: Colors.red))])
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(16),
            child: _buildInputForm(type, item, index),
          ),
        ],
      ),
    );
  }

  Color _getHeaderColor(String type) => type == 'quiz' ? quizColor : (type == 'flip' ? flipColor : primaryColor);
  IconData _getIcon(String type) => type == 'quiz' ? Icons.quiz : (type == 'flip' ? Icons.flip : Icons.text_fields);
  String _getTypeLabel(String type) => type == 'quiz' ? "Kuis" : (type == 'flip' ? "Flip Card" : "Teks");

  Widget _buildInputForm(String type, Map<String, dynamic> item, int index) {
    if (type == 'text') {
      return TextFormField(
        initialValue: item['content'],
        maxLines: 4,
        onChanged: (val) => item['content'] = val, 
        decoration: const InputDecoration(hintText: "Isi materi...", border: OutlineInputBorder()),
      );
    } else if (type == 'flip') {
      String frontColorKey = item['frontColor'] ?? 'cream';
      String backColorKey = item['backColor'] ?? 'white';
      
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FlipCardPreview(
            frontText: item['front'] ?? '',
            backText: item['back'] ?? '',
            frontColorKey: frontColorKey,
            backColorKey: backColorKey,
          ),
          const SizedBox(height: 16),

          const Text("Warna Depan:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 8),
          _buildColorPickerRow(frontColorKey, (newColor) {
            setState(() => item['frontColor'] = newColor);
          }),
          const SizedBox(height: 12),

          const Text("Warna Belakang:", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 8),
          _buildColorPickerRow(backColorKey, (newColor) {
            setState(() => item['backColor'] = newColor);
          }),
          const SizedBox(height: 16),

          TextFormField(
            initialValue: item['front'],
            onChanged: (val) {
               setState(() {
                 item['front'] = val;
               });
            },
            decoration: const InputDecoration(
              labelText: "Judul Depan (Singkat)",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.title),
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            initialValue: item['back'],
            onChanged: (val) {
              setState(() {
                item['back'] = val;
              });
            },
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: "Isi Belakang (Penjelasan Lengkap)", 
              border: OutlineInputBorder(), 
              prefixIcon: Icon(Icons.description)
            ),
          ),
        ],
      );
    } else if (type == 'quiz') {
      List options = item['options'];
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            initialValue: item['question'],
            onChanged: (val) => item['question'] = val,
            decoration: const InputDecoration(labelText: "Pertanyaan", border: OutlineInputBorder()),
          ),
          const SizedBox(height: 10),
          ...List.generate(4, (i) => Row(
            children: [
              Radio<int>(
                value: i, groupValue: item['correct'], activeColor: quizColor,
                onChanged: (val) => setState(() => item['correct'] = val),
              ),
              Expanded(
                child: TextFormField(
                  initialValue: options[i],
                  onChanged: (val) => options[i] = val,
                  decoration: InputDecoration(hintText: "Opsi ${String.fromCharCode(65 + i)}", isDense: true, border: const OutlineInputBorder()),
                ),
              ),
            ],
          )),
        ],
      );
    }
    return const SizedBox();
  }

  Widget _buildColorPickerRow(String selectedKey, Function(String) onSelect) {
    return Row(
      children: cardColors.keys.map((key) {
        bool isSelected = selectedKey == key;
        return GestureDetector(
          onTap: () => onSelect(key),
          child: Container(
            margin: const EdgeInsets.only(right: 12),
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: cardColors[key],
              shape: BoxShape.circle,
              border: isSelected ? Border.all(color: primaryColor, width: 2) : Border.all(color: Colors.grey.shade300),
              boxShadow: [if(isSelected) BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4)],
            ),
            child: isSelected ? const Icon(Icons.check, size: 16, color: primaryColor) : null,
          ),
        );
      }).toList(),
    );
  }

  // --- SIDEBAR DRAWER (TANPA PROGRESS & CHECKLIST) ---
  Widget _buildDrawerSidebar() {
    return Drawer(
      width: 280,
      child: Container(
        color: sidebarBg,
        child: Column(
          children: [
            // HEADER BARU (Clean)
            Container(
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
              width: double.infinity,
              color: sidebarBg,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("COURSE CONTENT", style: TextStyle(color: Colors.grey, fontSize: 11, letterSpacing: 1.2)),
                  const SizedBox(height: 8),
                  Text(widget.courseData['title'] ?? 'Course', style: const TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 18)),
                ],
              ),
            ),
            
            // LIST MODUL DENGAN STYLE TITIK HIJAU
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: modules.length,
                itemBuilder: (context, index) {
                  bool isActive = index == _activeModuleIndex;
                  
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: isActive ? activeItemBg : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      // Leading: Bullet Point Hijau (Kecil)
                      leading: const Icon(Icons.circle, size: 8, color: greenColor),
                      // Title
                      title: Text(
                        modules[index]['title'] ?? "Modul ${index + 1}", 
                        style: TextStyle(
                          color: isActive ? primaryColor : Colors.black87, 
                          fontWeight: isActive ? FontWeight.bold : FontWeight.normal, 
                          fontSize: 14
                        )
                      ),
                      // Trailing: Hapus (Abu-abu, bukan checklist)
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline, size: 18, color: Colors.grey), 
                        onPressed: () => _deleteModule(index)
                      ),
                      onTap: () {
                        // Simpan Judul Modul Sebelumnya
                        modules[_activeModuleIndex]['title'] = _moduleTitleController.text;
                        setState(() {
                          _activeModuleIndex = index;
                          _loadActiveModuleTitle();
                        });
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
              ),
            ),
            
            // FOOTER BUTTON
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton.icon(
                onPressed: _addNewModule,
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text("Tambah Modul Baru"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor, 
                  minimumSize: const Size(double.infinity, 50),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- WIDGET ISOLATED FLIP PREVIEW ---
class FlipCardPreview extends StatefulWidget {
  final String frontText;
  final String backText;
  final String frontColorKey;
  final String backColorKey;

  const FlipCardPreview({
    Key? key,
    required this.frontText,
    required this.backText,
    required this.frontColorKey,
    required this.backColorKey,
  }) : super(key: key);

  @override
  State<FlipCardPreview> createState() => _FlipCardPreviewState();
}

class _FlipCardPreviewState extends State<FlipCardPreview> {
  bool isFlipped = false;

  @override
  Widget build(BuildContext context) {
    Color frontBg = cardColors[widget.frontColorKey] ?? cardColors['cream']!;
    Color backBg = cardColors[widget.backColorKey] ?? Colors.white;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Preview (Tap untuk balik):", style: TextStyle(fontSize: 10, color: Colors.grey)),
            Row(
              children: [
                Container(width: 12, height: 12, decoration: BoxDecoration(color: frontBg, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade300))),
                const SizedBox(width: 4),
                const Icon(Icons.arrow_forward, size: 10, color: Colors.grey),
                const SizedBox(width: 4),
                Container(width: 12, height: 12, decoration: BoxDecoration(color: backBg, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade300))),
              ],
            )
          ],
        ),
        const SizedBox(height: 4),
        GestureDetector(
          onTap: () {
            setState(() {
              isFlipped = !isFlipped;
            });
          },
          child: TweenAnimationBuilder(
            duration: const Duration(milliseconds: 400),
            tween: Tween<double>(begin: 0, end: isFlipped ? math.pi : 0),
            builder: (context, double value, child) {
              bool showBack = value > math.pi / 2;
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()..setEntry(3, 2, 0.001)..rotateY(value),
                child: Container(
                  height: 150, 
                  width: double.infinity,
                  decoration: BoxDecoration(
                    // Warna sesuai sisi yang tampil
                    color: showBack ? backBg : frontBg,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)],
                  ),
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  child: showBack
                    ? Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()..rotateY(math.pi),
                        // Layout Belakang: Teks Panjang
                        child: Text(widget.backText.isEmpty ? "Penjelasan Belakang" : widget.backText, textAlign: TextAlign.center, maxLines: 6, overflow: TextOverflow.ellipsis),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Layout Depan: Icon + Judul
                          const Icon(Icons.touch_app, size: 30, color: primaryColor),
                          const SizedBox(height: 8),
                          Text(widget.frontText.isEmpty ? "Judul Depan" : widget.frontText, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16), textAlign: TextAlign.center),
                          const SizedBox(height: 4),
                          const Text("Tap untuk flip", style: TextStyle(fontSize: 10, color: Colors.grey)),
                        ],
                      ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}