// lib/data/papeda.dart

// Wajib: Import Model Content dari file tunggal (Sesuaikan path jika berbeda)
import '../pages/module_content_model.dart';

// Data Kursus "Memasak Papeda dan Kuah Kuning Ikan Tongkol"
final List<ModuleContent> papedaModules = [
    // --- INDEKS 0: PENGANTAR ---
    ModuleContent(
        title: 'COURSE OVERVIEW',
        // duration: dihapus
        contentTitle: 'Pengantar Kuliner Sagu dan Ikan Timur',
        contentText: [
            "Papeda bukan sekadar makanan pokok; ia adalah simbol kearifan lokal, pangan berkelanjutan, dan ikatan komunal bagi masyarakat di Papua dan Maluku.",
            "Terbuat dari sagu, Papeda memiliki tekstur unik seperti lem, tawar, dan disajikan panas dengan pendamping wajib, Ikan Kuah Kuning yang kaya rasa. Kursus ini mencakup filosofi, teknik otentik, hingga etika makan komunal.",
            "Di Timur Indonesia, pohon sagu (*Metroxylon sagu*) dikenal sebagai 'Ibu yang Menyusui Anak-anaknya' karena tumbuh liar di hutan rawa tanpa perlu dipupuk, namun memberikan karbohidrat melimpah.",
            "Satu batang pohon sagu dewasa saja dapat menghasilkan hingga 300 kg tepung basah, cukup untuk menghidupi satu keluarga selama berbulan-bulan.",
            "Kursus ini akan memandu Anda melalui seluruh rantai proses, mulai dari panen lestari (mengikuti aturan adat *sasi* dalam menebang sagu), proses ekstraksi tepung (*nokok sagu*) yang dilakukan secara gotong royong, hingga teknik mengolah Papeda yang sempurna di dapur.",
            "Fokus utama lainnya adalah Kuah Kuning, jodoh Papeda. Kita akan mempelajari rempah-rempah kunci seperti kunyit, belimbing wuluh, dan kemangi.",
            "Rempah-rempah ini tidak hanya memberikan rasa asam-pedas yang berfungsi sebagai pelicin Papeda, tetapi juga memiliki khasiat medis sebagai antiseptik dan penawar amis alami.",
        ],
    ),

    // --- MODUL 1: PAPEDA: BAHAN DAN TEKNIK (Indeks 1, 2) ---
    ModuleContent(
        title: 'Filosofi Sagu',
        // duration: dihapus
        contentTitle: 'Sagu: Pohon Kehidupan dan Proses Pembuatan Tepung',
        contentText: [
            "Bagi Suku di pesisir Papua, pohon sagu (*Metroxylon sagu*) dianggap sakral sebagai 'Ibu Kehidupan' atau *Lumbung Hidup*.",
            "Sagu tumbuh subur di hutan rawa dan tidak memerlukan campur tangan manusia yang berlebihan. Nilai ekologisnya sangat tinggi karena ia adalah sumber karbohidrat berlimpah yang tumbuh secara berkelanjutan.",
            "Masyarakat Papua memiliki kearifan lokal dalam panen lestari melalui aturan adat yang disebut *sasi*.",
            "Sasi mengatur bahwa hanya pohon sagu yang sudah cukup umur (sekitar 10-12 tahun) dan hampir berbunga yang boleh ditebang. Pohon muda dilarang ditebang.",
            "Setelah panen, pelepah daun dan sisa batang dikembalikan ke tanah sebagai pupuk alami. Praktik ini memastikan bahwa sumber pangan ini terus tersedia untuk generasi berikutnya.",
            "Proses mendapatkan tepung sagu dari batang disebut **Nokok Sagu** (ekstraksi). Proses ini dimulai dengan menebang pohon, mengupas kulitnya, dan menghancurkan bagian dalam batang (*empulur*) yang berserat dengan alat pukul kayu (*nani*). Proses ini membutuhkan kerja fisik yang berat dan sering dilakukan secara gotong royong.",
            "Serbuk empulur yang sudah dihancurkan kemudian dicampur dengan air, diremas-remas (*di-gata*), dan disaring. Pati sagu yang larut dalam air akan diendapkan dalam wadah (*tumang*).",
            "Setelah didiamkan, pati sagu mengendap di dasar menjadi pasta putih padat—inilah tepung sagu murni yang siap diolah menjadi Papeda.",
        ],
    ),
    ModuleContent(
        title: 'Teknik Membuat Papeda',
        // duration: dihapus
        contentTitle: 'Mengolah Papeda: Teknik Tuang Air Mendidih',
        contentText: [
            "Memasak Papeda yang sempurna adalah seni yang mengandalkan suhu dan konsistensi, bukan durasi rebusan.",
            "Papeda dimasak melalui proses **Gelatinisasi**, yaitu perubahan pati menjadi gel bening yang kenyal. Tepung sagu mentah harus dilarutkan terlebih dahulu dengan sedikit air dingin untuk mencegah penggumpalan di awal.",
            "Kunci suksesnya adalah **Teknik Tuang Air Mendidih**. Air harus benar-benar mendidih (beruap banyak) dan dituang secara perlahan namun konsisten ke dalam larutan tepung sagu sambil diaduk cepat.",
            "Jika air kurang panas, pati sagu tidak akan mengalami gelatinisasi, dan Papeda akan gagal (mentah, cair, dan berwarna putih keruh).",
            "Alat tradisional yang digunakan untuk mengaduk adalah sepasang sendok kayu atau bambu yang disebut *Gata-gata* atau *Hehenu*.",
            "Pengadukan harus dilakukan secara cepat dan konsisten hingga seluruh cairan sagu berubah menjadi gel transparan dan lengket, menghasilkan tekstur yang kenyal dan liat seperti lem.",
            "Papeda yang sudah matang sempurna berwarna bening, liat, kenyal, dan lengket.",
            "Ia memiliki rasa yang tawar, yang dalam filosofi disebut sebagai **'Kanvas Kosong'** atau dasar kehidupan yang netral.",
            "Karena rasanya yang netral dan teksturnya yang liat, Papeda wajib disajikan dengan lauk pauk yang berkuah, pedas, dan asam untuk memberikan rasa dan fungsi pelicin saat ditelan.",
        ],
    ),

    // --- MODUL 2: KUAH KUNING IKAN (Indeks 3, 4) ---
    ModuleContent(
        title: 'Bumbu Kuah Kuning',
        // duration: dihapus
        contentTitle: 'Rempah Kunci: Kunyit, Belimbing Wuluh, dan Daun Jeruk',
        contentText: [
            "Kuah Kuning adalah 'pasangan jiwa' Papeda, dirancang untuk memberikan rasa yang kuat dan kompleks untuk mengimbangi rasa tawar Papeda.",
            "Warna kuning cerah pada kuah didapatkan dari penggunaan **Kunyit Segar** yang berlimpah, yang tidak hanya berfungsi sebagai pewarna alami, tetapi juga memberikan manfaat medis sebagai antibiotik dan antiseptik alami.",
            "Rasa yang mendominasi Kuah Kuning adalah asam dan pedas, yang sangat penting sebagai pelicin tenggorokan saat menyantap Papeda.",
            "Rasa asam didapatkan dari **Belimbing Wuluh** (*Averrhoa bilimbi*) atau terkadang digantikan dengan perasan **Jeruk Nipis**. Asam berfungsi untuk memecah rasa 'berat' atau *eneg* dari karbohidrat sagu dan menyeimbangkan tekstur liat Papeda.",
            "Aroma kuah diperkaya dengan penggunaan **Daun Jeruk Purut**, **Sereh**, dan **Daun Kemangi** segar.",
            "Penggunaan rempah aromatik ini bertujuan untuk menghilangkan bau amis ikan laut. Masakan tradisional Papua cenderung minim menggunakan bumbu penyedap buatan (MSG), tetapi sangat kaya dengan rempah segar dari alam.",
            "Semua rempah ini dihaluskan dan ditumis sebentar sebelum dimasak bersama ikan. Bumbu yang kaya ini menunjukkan adaptasi kuliner masyarakat Timur Indonesia terhadap kekayaan hasil laut dan rempah hutan yang berlimpah, menciptakan hidangan yang lezat sekaligus menyehatkan.",
        ],
    ),
    ModuleContent(
        title: 'Memasak Ikan Tongkol',
        // duration: dihapus
        contentTitle: 'Teknik Memasak Ikan Tongkol Segar',
        contentText: [
            "Ikan Kuah Kuning secara tradisional menggunakan ikan laut berdaging padat yang segar, seperti **Ikan Tongkol**, **Cakalang**, atau **Mubara** (Kakap Merah).",
            "Kualitas ikan adalah kunci utama keberhasilan hidangan ini, karena ikan menyediakan protein tinggi, vitamin, dan Omega 3, menjadikannya penyeimbang nutrisi yang sempurna untuk karbohidrat sagu.",
            "Sebelum dimasak, ikan harus dibersihkan dengan benar dan dilumuri dengan **Jeruk Nipis** dan sedikit garam.",
            "Proses melumuri jeruk nipis ini sangat penting untuk menghilangkan bau amis (*amis*) dan membuat tekstur daging ikan menjadi lebih padat dan tidak mudah hancur saat dimasak dalam kuah yang mendidih.",
            "Teknik memasak ikan dalam Kuah Kuning harus dilakukan dengan cepat. Bumbu yang sudah matang dimasak bersama air hingga mendidih, lalu ikan dimasukkan.",
            "Ikan tidak boleh dimasak terlalu lama; cukup direbus hingga matang agar teksturnya tetap utuh dan rasa lautnya menyatu sempurna dengan rempah.",
            "Kehadiran ikan dalam Kuah Kuning juga memiliki makna ritual; Kuah Kuning tidak hanya berfungsi sebagai pelengkap rasa, tetapi juga sebagai media untuk menghormati hasil laut yang menjadi sumber penghidupan utama masyarakat pesisir.",
        ],
    ),

    // --- QUIZ MODUL 1 & 2 (Indeks 5) ---
    ModuleContent(
        title: 'Quiz Modul 1 & 2',
        // duration: dihapus
        contentTitle: 'Uji Pemahaman: Sagu dan Rempah',
        contentText: [
            'Uji pengetahuan Anda mengenai sumber daya sagu, teknik mengaduk Papeda, dan rempah-rempah yang wajib ada di Kuah Kuning.',
        ],
        isQuiz: true,
    ),

    // --- MODUL 3: PENYAJIAN DAN ADAB MAKAN (Indeks 6, 7) ---
    ModuleContent(
        title: 'Adab Makan Papeda',
        // duration: dihapus
        contentTitle: 'Makan Bersama dan Sendok Sagu (*Hehenu*)',
        contentText: [
            "Papeda adalah makanan komunal. Filosofi inti dari penyajian Papeda adalah **kebersamaan dan persaudaraan**.",
            "Papeda tidak disajikan di piring individu dari awal, melainkan diletakkan di wadah besar komunal yang disebut *Helai Mboy* (wadah kayu lonjong dari Sentani) atau *Sempe* (wadah tanah liat), dikelilingi oleh Kuah Kuning dan lauk lainnya.",
            "Adab makan ini menunjukkan nilai sosial, yaitu 'Kita makan dari sumber yang sama, kita adalah saudara.'",
            "Tradisi makan bersama ini bahkan sering dijadikan sarana **perdamaian** (*Makan Patita*). Jika ada konflik antar-kaum, tetua adat akan menyuruh mereka duduk satu meja dan makan Papeda dari wadah yang sama, melarutkan permusuhan dalam kebersamaan.",
            "Mengambil Papeda dari wadah komunal membutuhkan alat khusus, sepasang bambu seperti sumpit/garpu besar yang disebut **Gata-gata** atau **Hehenu**.",
            "Gata-gata ditusukkan ke Papeda, lalu diputar cepat dengan gerakan melingkar (*gulung*) untuk memutus benang sagu yang liat dan mengambil porsi besar. Porsi Papeda diletakkan di piring masing-masing, lalu disiram Kuah Kuning.",
            "Cara menyantap Papeda yang benar adalah **ditelan langsung atau diseruput** (*slurp*) tanpa dikunyah.",
            "Mengunyah Papeda dianggap *pamali* (tabu) karena teksturnya akan lengket di gigi. Oleh karena itu, Kuah Kuning berfungsi vital sebagai pelicin agar Papeda mudah ditelan, memastikan konsumsi sagu yang efektif.",
        ],
    ),
    ModuleContent(
        title: 'Variasi Pendamping',
        // duration: dihapus
        contentTitle: 'Pendamping Lain: Sayur Ganemo dan Sambal Dabu-Dabu',
        contentText: [
            "Selain Ikan Kuah Kuning, Papeda juga disajikan dengan berbagai hidangan pendamping yang melengkapi rasa dan nutrisi.",
            "Salah satu sayuran pendamping paling otentik adalah **Sayur Ganemo**. Ganemo adalah sayur yang dibuat dari daun melinjo muda yang dimasak sederhana, seringkali hanya ditumis atau direbus dengan sedikit bumbu, menjaga rasa sayuran tetap segar.",
            "Pendamping yang tak kalah penting adalah sambal. Sambal yang sering disajikan adalah **Sambal Dabu-Dabu** yang segar, khas Maluku dan Sulawesi Utara yang juga populer di Papua.",
            "Sambal Dabu-Dabu dibuat tanpa dimasak; cabai rawit, tomat, bawang merah, dan kemangi diiris kasar, lalu disiram minyak panas dan diperas jeruk limau. Rasanya yang segar dan pedas memberikan *punch* yang dibutuhkan Papeda.",
            "Di berbagai daerah Papua, Papeda juga bisa disajikan dengan lauk protein lain seperti ikan bakar rica-rica, udang, atau kepiting.",
            "Namun, filosofi dasarnya tetap sama: Papeda (karbohidrat netral) harus diimbangi dengan lauk yang kaya rasa, asam, pedas, dan beraroma kuat.",
            "Variasi pendamping ini menunjukkan kekayaan bahan makanan di pesisir Timur Indonesia. Kombinasi Papeda yang rendah gula (*low glycemic index*) dengan protein ikan tinggi omega-3 dan rempah segar menjadikan Papeda sebagai makanan tradisional yang sangat sehat dan beradaptasi baik dengan hasil alam sekitar.",
        ],
    ),

    // --- FINAL ASSESSMENT (Indeks 8) ---
    ModuleContent(
        title: 'Final Assessment',
        // duration: dihapus
        contentTitle: 'Ujian Akhir Kursus Kuliner Timur',
        contentText: [
            'Selamat! Anda telah menguasai seni memasak Papeda dan Kuah Kuning. Saatnya menguji keterampilan Anda.',
        ],
        isQuiz: true,
    ),
];