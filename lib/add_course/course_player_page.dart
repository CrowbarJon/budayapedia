import 'package:flutter/material.dart';
import 'dart:math'; // Untuk animasi flip
import '../pages/course_model.dart'; // Import model course

class CoursePlayerPage extends StatelessWidget {
  final Course course;

  const CoursePlayerPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course.title, style: const TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: course.contents.length,
        itemBuilder: (context, index) {
          final item = course.contents[index];

          // 1. Jika datanya FLIP CARD
          if (item is Map && item['type'] == 'flip') {
            return FlipCardWidget(
              frontText: item['front'] ?? '',
              backText: item['back'] ?? '',
              // Default warna cream kalau null
              frontColor: _getColor(item['frontColor']), 
              backColor: _getColor(item['backColor']),
            );
          } 
          
          // 2. Jika datanya TEKS BIASA (Map)
          else if (item is Map && item['type'] == 'text') {
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Text(
                item['content'] ?? '',
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
            );
          }
          
          // 3. Fallback jika datanya String (Legacy/Format lama)
          else if (item is String) {
             return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(item.toString()),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  // Helper konversi string warna ke Color object
  Color _getColor(String? colorName) {
    switch (colorName) {
      case 'white': return Colors.white;
      case 'cream': return const Color(0xFFFFF8E1); // Amber 50
      case 'blue': return const Color(0xFFE3F2FD); // Blue 50
      case 'purple': return const Color(0xFFF3E5F5); // Purple 50
      case 'green': return const Color(0xFFE8F5E9); // Green 50
      default: return const Color(0xFFFFF8E1); // Default Cream
    }
  }
}

// --- WIDGET FLIP CARD INTERAKTIF ---
class FlipCardWidget extends StatefulWidget {
  final String frontText;
  final String backText;
  final Color frontColor;
  final Color backColor;

  const FlipCardWidget({
    super.key, 
    required this.frontText, 
    required this.backText,
    required this.frontColor,
    required this.backColor,
  });

  @override
  State<FlipCardWidget> createState() => _FlipCardWidgetState();
}

class _FlipCardWidgetState extends State<FlipCardWidget> {
  bool isFlipped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isFlipped = !isFlipped;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.only(bottom: 20),
        height: 200, // Tinggi kartu
        width: double.infinity,
        decoration: BoxDecoration(
          color: isFlipped ? widget.backColor : widget.frontColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Konten Kartu
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isFlipped ? Icons.description_outlined : Icons.touch_app,
                    size: 30,
                    color: Colors.black54,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    isFlipped ? widget.backText : widget.frontText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    isFlipped ? "(Tap untuk balik ke depan)" : "(Tap untuk melihat penjelasan)",
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}