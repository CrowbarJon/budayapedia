// lib/data/papeda.dart

// Wajib: Import Model Content dari file tunggal
import '../pages/module_content_model.dart';

// Data Kursus "Memasak Papeda dan Kuah Kuning Ikan Tongkol"
final List<ModuleContent> papedaModules = [
  // --- INDEKS 0: PENGANTAR ---
  ModuleContent(
    title: 'COURSE OVERVIEW',
    duration: '03:00',
    contentTitle: 'Pengantar Kuliner Sagu dan Ikan Timur',
    contentText:
        'Papeda adalah makanan pokok dari sagu yang memiliki nilai sosial dan budaya tinggi di Papua dan Maluku. Kuah kuning adalah pendamping wajib yang kaya rempah. Kursus ini mencakup filosofi, teknik, dan resep otentik.',
  ),

  // --- MODUL 1: PAPEDA: BAHAN DAN TEKNIK (Indeks 1, 2) ---
  ModuleContent(
    title: 'Filosofi Sagu',
    duration: '07:45',
    contentTitle: 'Sagu: Pohon Kehidupan dan Proses Pembuatan Tepung',
    contentText:
        'Di Timur Indonesia, pohon sagu (*Metroxylon sagu*) dianggap sebagai pohon kehidupan. Modul ini menjelaskan bagaimana tepung sagu diekstrak dari empulur batang sagu dan proses penyiapan tepung terbaik untuk Papeda.',
  ),
  ModuleContent(
    title: 'Teknik Membuat Papeda',
    duration: '10:30',
    contentTitle: 'Mengolah Papeda: Teknik Tuang Air Mendidih',
    contentText:
        'Kunci Papeda yang sempurna adalah teknik menuang air mendidih ke atas tepung sagu. Pelajari cara mengaduk cepat hingga Papeda matang, kenyal, dan lengket menggunakan alat tradisional (*Gata-gata*) atau sendok kayu.',
  ),

  // --- MODUL 2: KUAH KUNING IKAN (Indeks 3, 4) ---
  ModuleContent(
    title: 'Bumbu Kuah Kuning',
    duration: '08:50',
    contentTitle: 'Rempah Kunci: Kunyit, Belimbing Wuluh, dan Daun Jeruk',
    contentText:
        'Kuah kuning mendapatkan warna dan rasanya dari kunyit segar, yang juga berfungsi sebagai antiseptik alami. Rasa asam pedas didapatkan dari belimbing wuluh (*Averrhoa bilimbi*) dan cabai, diimbangi aroma daun kemangi dan jeruk purut.',
  ),
  ModuleContent(
    title: 'Memasak Ikan Tongkol',
    duration: '09:10',
    contentTitle: 'Teknik Memasak Ikan Tongkol Segar',
    contentText:
        'Ikan (seperti Tongkol atau Kakap) harus dimasak cepat dalam kuah mendidih agar teksturnya tidak hancur dan rasa lautnya menyatu dengan rempah. Penting untuk membersihkan ikan dengan benar (gunakan jeruk nipis) sebelum dimasak.',
  ),

  // --- QUIZ MODUL 1 & 2 (Indeks 5) ---
  ModuleContent(
    title: 'Quiz Modul 1 & 2',
    duration: '00:00',
    contentTitle: 'Uji Pemahaman: Sagu dan Rempah',
    contentText:
        'Uji pengetahuan Anda mengenai sumber daya sagu, teknik mengaduk Papeda, dan rempah-rempah yang wajib ada di Kuah Kuning.',
    isQuiz: true,
  ),

  // --- MODUL 3: PENYAJIAN DAN ADAB MAKAN (Indeks 6, 7) ---
  ModuleContent(
    title: 'Adab Makan Papeda',
    duration: '06:40',
    contentTitle: 'Makan Bersama dan Sendok Sagu (*Hehenu*)',
    contentText:
        'Papeda adalah makanan komunal. Pelajari cara menyantapnya tanpa sendok garpu. Gunakan sumpit (*Hehenu*) atau garpu kayu untuk mengambil Papeda dalam porsi besar, diputar hingga melilit.',
  ),
  ModuleContent(
    title: 'Variasi Pendamping',
    duration: '05:35',
    contentTitle: 'Pendamping Lain: Sayur Ganemo dan Sambal Dabu-Dabu',
    contentText:
        'Selain Kuah Kuning, Papeda sering disajikan dengan sayur dari daun melinjo (*Ganemo*) dan sambal Dabu-Dabu khas Manado/Maluku yang segar dan berbahan dasar cabai rawit, tomat, dan perasan jeruk limau.',
  ),

  // --- FINAL ASSESSMENT (Indeks 8) ---
  ModuleContent(
    title: 'Final Assessment',
    duration: '00:00',
    contentTitle: 'Ujian Akhir Kursus Kuliner Timur',
    contentText:
        'Selamat! Anda telah menguasai seni memasak Papeda dan Kuah Kuning. Saatnya menguji keterampilan Anda.',
    isQuiz: true,
  ),
];
