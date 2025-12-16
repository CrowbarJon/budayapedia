// lib/models/module_content_model.dart

class ModuleContent {
  final String title;
  // duration sudah dihapus
  final String contentTitle;
  // UBAH TIPE INI menjadi List<String>
  final List<String> contentText; 
  final bool isQuiz;

  ModuleContent({
    required this.title,
    // duration sudah dihapus
    required this.contentTitle,
    required this.contentText, // Tipe List<String>
    this.isQuiz = false,
  });
}