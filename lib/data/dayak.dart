// lib/data/dayak.dart

// Wajib: Import Model Content dari file tunggal
import '../pages/module_content_model.dart'; 

// Data Kursus "Manik-Manik dan Busana Adat Suku Dayak"
final List<ModuleContent> dayakModules = [
    // --- INDEKS 0: PENGANTAR ---
    ModuleContent(
        title: 'COURSE OVERVIEW',
        duration: '03:00',
        contentTitle: 'Pengantar Budaya Material Suku Dayak',
        contentText: 
            'Kursus ini berfokus pada eksplorasi budaya material Suku Dayak di Kalimantan, terutama teknik pembuatan manik-manik, ukiran kayu, dan filosofi di balik Busana Adat seperti King Baba dan King Bibinge.',
    ),

    // --- MODUL 1: FILOSOFI MANIK-MANIK (Indeks 1, 2) ---
    ModuleContent(
        title: 'Makna Manik-Manik',
        duration: '09:00',
        contentTitle: 'Manik-Manik: Kekayaan, Status, dan Spiritualitas',
        contentText: 
            'Manik-manik (*Lue*) bukan sekadar hiasan. Kualitas, warna, dan pola manik-manik menunjukkan status sosial, kekayaan, dan asal-usul klan seseorang. Beberapa manik-manik kuno dianggap memiliki kekuatan magis dan diwariskan secara turun-temurun.',
    ),
    ModuleContent(
        title: 'Teknik Merangkai Dasar',
        duration: '07:30',
        contentTitle: 'Teknik Merangkai dan Pola Geometris',
        contentText: 
            'Pelajari teknik dasar merangkai manik-manik, sering menggunakan pola geometris yang mewakili alam (misalnya, taring harimau, bunga, atau naga (*Aso*)). Pembuatannya membutuhkan ketelitian dan kesabaran tinggi.',
    ),

    // --- MODUL 2: BUSANA TRADISIONAL (Indeks 3, 4) ---
    ModuleContent(
        title: 'Busana King Baba',
        duration: '10:45',
        contentTitle: 'Pakaian Adat Pria: King Baba dan Perisai',
        contentText: 
            'Pakaian adat pria (*King Baba*) terbuat dari kulit kayu, dengan hiasan manik-manik dan taring. Dilengkapi dengan perisai (*Talawang*) dan senjata (*Mandau*), busana ini melambangkan keberanian, kepahlawan, dan perlindungan suku.',
    ),
    ModuleContent(
        title: 'Busana King Bibinge',
        duration: '08:20',
        contentTitle: 'Pakaian Adat Wanita: King Bibinge',
        contentText: 
            'Pakaian wanita (*King Bibinge*) memiliki hiasan manik-manik yang lebih kaya dan kompleks, termasuk topi (*Tangkuluk*) dan kalung (*Uleng*) yang berat. Busana ini melambangkan keindahan, kesuburan, dan martabat wanita Dayak.',
    ),

    // --- QUIZ MODUL 1 & 2 (Indeks 5) ---
    ModuleContent(
        title: 'Quiz Modul 1 & 2',
        duration: '00:00',
        contentTitle: 'Uji Pemahaman: Manik-Manik & Busana',
        contentText: 'Uji pengetahuan Anda tentang status manik-manik, pola *Aso*, dan perbedaan busana King Baba/King Bibinge.',
        isQuiz: true,
    ),

    // --- MODUL 3: UKIRAN DAN SIMBOLISME (Indeks 6, 7) ---
    ModuleContent(
        title: 'Ukiran Kayu (*Pamat*)',
        duration: '11:00',
        contentTitle: 'Filosofi Ukiran Kayu (Pamat) Dayak',
        contentText: 
            'Ukiran kayu Suku Dayak, terutama pada rumah adat (*Lamin*) dan perisai, memiliki simbolisme yang kuat, berfungsi sebagai penolak bala dan penanda sejarah. Pola naga dan burung enggang adalah motif yang paling sering dijumpai.',
    ),
    ModuleContent(
        title: 'Simbol Burung Enggang',
        duration: '07:15',
        contentTitle: 'Burung Enggang: Simbol Keagungan',
        contentText: 
            'Burung Enggang (*Rangkong*) adalah burung suci, simbol pemimpin dan keagungan. Bulu dan paruhnya sering digunakan sebagai hiasan kepala, melambangkan kedekatan dengan alam dan dunia atas.',
    ),

    // --- MODUL 4: STUDI KASUS DAN PENUTUP (Indeks 8, 9, 10) ---
    ModuleContent(
        title: 'Studi Kasus: Tari Hudoq',
        duration: '09:40',
        contentTitle: 'Tari Hudoq: Tarian Ritual Kesuburan',
        contentText: 
            'Pelajari Tari Hudoq, tarian ritual yang menggunakan topeng yang menakutkan, bertujuan untuk memohon kesuburan dari roh-roh leluhur, terutama setelah musim tanam.',
    ),
    ModuleContent(
        title: 'Musik Adat dan Alatnya',
        duration: '06:50',
        contentTitle: 'Sampe dan Gong: Iringan Utama',
        contentText: 
            'Instrumen utama Dayak adalah *Sampe* (alat musik petik seperti gitar) dan berbagai jenis gong. Musiknya sering digunakan untuk upacara ritual dan mengiringi tari-tarian adat.',
    ),
    
    ModuleContent(
        title: 'Final Assessment',
        duration: '00:00',
        contentTitle: 'Ujian Akhir Kursus Budaya Dayak',
        contentText: 'Selamat! Anda telah menguasai budaya material dan spiritual Suku Dayak. Saatnya membuktikan pemahaman Anda dalam Ujian Akhir.',
        isQuiz: true,
    ),
];