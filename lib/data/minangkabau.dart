// lib/data/minangkabau.dart (KODE FINAL YANG BENAR)

// >>> GANTI DEFINISI KELAS DENGAN IMPORT MODEL TUNGGAL INI <<<
import '../pages/module_content_model.dart'; 
// >>> END IMPORT MODEL <<<

// HAPUS DEFINISI LAMA CLASS MODULECONTENT DI SINI!
// class ModuleContent { ... } <--- HARUS DIHAPUS TOTAL DARI FILE INI!


// Data Kursus "Filosofi Adat dan Rumah Gadang Minangkabau"
// Tipe data ModuleContent sekarang diambil dari module_content_model.dart
final List<ModuleContent> minangkabauModules = [
    // --- INDEKS 0: PENGANTAR ---
    ModuleContent(
        title: 'COURSE OVERVIEW',
        duration: '03:00',
        contentTitle: 'Pengantar Kursus Minangkabau',
        contentText: 
            'Kursus ini akan membawa Anda memahami struktur sosial matrilineal Minangkabau, peran unik wanita (Bundo Kanduang), kepemimpinan adat (Niniak Mamak), hingga filosofi arsitektur Rumah Gadang.',
    ),

    // --- MODUL 1: STRUKTUR SOSIAL MATRILINEAL (Indeks 1, 2) ---
    ModuleContent(
        title: 'Pengantar Matrilineal',
        duration: '08:00',
        contentTitle: 'Sistem Garis Keturunan Ibu (Matrilineal)',
        contentText: 
            'Minangkabau adalah salah satu suku terbesar di dunia yang secara konsisten menganut sistem matrilineal. Artinya, garis keturunan, kepemilikan harta pusaka (terutama Rumah Gadang), dan gelar adat diwariskan melalui pihak ibu. Ini menjadikan perempuan sebagai pemegang kunci keberlangsungan kaum (kelompok keluarga).',
    ),
    ModuleContent(
        title: 'Peran Suku dan Kampung',
        duration: '07:30',
        contentTitle: 'Ikatan Suku (Klan) dan Wilayah Adat (Nagari)',
        contentText: 
            'Setiap orang Minang wajib menjadi anggota dari salah satu Suku atau klan. Suku menentukan identitas, hak, dan kewajiban adat seseorang. Kesatuan dari beberapa suku membentuk Nagari, yaitu kesatuan masyarakat hukum adat yang memiliki wilayah dan pemerintahan sendiri.',
    ),
    
    // --- MODUL 2: PERAN PENTING (Indeks 3, 4) ---
    ModuleContent(
        title: 'Adat Basandi Syarak',
        duration: '10:15',
        contentTitle: 'Filosofi Hidup: ABS-SBK',
        contentText: 
            'Filosofi dasar yang mengikat masyarakat Minang adalah "Adat Basandi Syarak, Syarak Basandi Kitabullah". Prinsip ini memastikan bahwa hukum adat tidak boleh bertentangan dengan ajaran Islam, menciptakan harmonisasi yang unik.',
    ),
    ModuleContent(
        title: 'Siapa Itu Bundo Kanduang?',
        duration: '09:40',
        contentTitle: 'Peran Sentral Wanita dalam Keluarga Adat',
        contentText: 
            'Bundo Kanduang adalah simbol ibu, pemimpin spiritual rumah tangga, dan pemilik sah atas Rumah Gadang dan harta pusaka. Perannya sangat penting dalam menjaga keberlangsungan sistem matrilineal dan kaum.',
    ),
    
    // --- QUIZ (Indeks 5) ---
    ModuleContent(
        title: 'Quiz Modul 1 & 2',
        duration: '00:00',
        contentTitle: 'Uji Pemahaman: Struktur Sosial dan Peran Adat',
        contentText: 'Ayo uji pemahaman Anda mengenai sistem matrilineal, Suku, Bundo Kanduang, dan Niniak Mamak.',
        isQuiz: true,
    ),

    // --- MODUL 3: RUMAH GADANG (Indeks 6, 7, 8) ---
    ModuleContent(
        title: 'Niniak Mamak: Fungsi Adat',
        duration: '08:25',
        contentTitle: 'Pemimpin Adat dan Pengambil Keputusan',
        contentText: 
            'Niniak Mamak adalah paman dari pihak ibu (saudara laki-laki Bundo Kanduang). Mereka adalah pemimpin resmi kaum, bertanggung jawab atas urusan adat, menyelesaikan sengketa, dan mewakili kaum dalam musyawarah nagari. ',
    ),
    ModuleContent(
        title: 'Atap Gonjong dan Maknanya',
        duration: '11:00',
        contentTitle: 'Filosofi Atap Bertanduk Kerbau',
        contentText: 
            'Atap gonjong (melengkung tajam ke atas seperti tanduk kerbau) adalah ciri khas arsitektur Rumah Gadang. Bentuknya melambangkan kemenangan kerbau dalam legenda yang menjadi asal nama Minangkabau, serta filosofi "Manjauah ka Langik, Mairik ka Bumi" (Melihat ke Langit, Menginjak ke Bumi) yang melambangkan ketinggian cita-cita dan ketaatan pada Tuhan. ',
    ),
    ModuleContent(
        title: 'Ukiran dan Simbolisme',
        duration: '12:30',
        contentTitle: 'Pesan Moral dalam Seni Ukir Dinding',
        contentText: 
            'Hampir seluruh dinding luar Rumah Gadang dihiasi ukiran bermotif flora dan fauna (seperti Itiak Pulang Patang, Roda-roda, dan Pucuak Rabuang) dengan warna merah, hitam, dan kuning emas.  Setiap motif ukiran memiliki makna dan pesan moral yang mendalam bagi penghuninya.',
    ),
    
    // --- MODUL 4: UPACARA ADAT (Indeks 9, 10) ---
    ModuleContent(
        title: 'Struktur Ruangan dan Fungsinya',
        duration: '09:15',
        contentTitle: 'Ruang Komunal dan Peran Anggota Keluarga',
        contentText: 
            'Rumah Gadang bukan hanya tempat tinggal, tetapi juga pusat komunal. Ruangan dibagi menjadi Bilik (kamar tidur untuk wanita yang sudah menikah), Laras (ruang tengah), dan Anjuang (tempat musyawarah atau upacara adat).',
    ),
    ModuleContent(
        title: 'Tahapan Pra-Pernikahan',
        duration: '07:55',
        contentTitle: 'Maresek dan Manjapuik Marapulai',
        contentText: 
            'Pernikahan Minangkabau dimulai dengan proses *Maresek* (pencarian dan penjajakan jodoh oleh pihak wanita). Kemudian, salah satu tahapan paling unik adalah *Manjapuik Marapulai*, di mana rombongan keluarga wanita secara resmi menjemput calon pengantin pria untuk dibawa ke rumah keluarga wanita, menegaskan peran sentral wanita.',
    ),

    // --- FINAL ASSESSMENT (Indeks 11) ---
    ModuleContent(
        title: 'Adat Baralek (Pesta)',
        duration: '08:50',
        contentTitle: 'Jamuan Besar dan Ritual Adat',
        contentText: 
            'Pesta pernikahan, atau *Baralek*, adalah acara besar yang melibatkan seluruh nagari dan diisi dengan jamuan makan serta pertunjukan kesenian tradisional. Ini adalah wujud musyawarah dan kegotongroyongan antar-kaum.',
    ),
    ModuleContent(
        title: 'Final Assessment',
        duration: '00:00',
        contentTitle: 'Ujian Akhir Kursus',
        contentText: 'Selamat! Anda telah menyelesaikan seluruh materi. Sekarang saatnya membuktikan penguasaan Anda atas Filosofi Adat dan Rumah Gadang Minangkabau.',
        isQuiz: true,
    ),
];