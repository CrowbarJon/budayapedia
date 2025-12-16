// lib/data/tari_keraton.dart (KODE FINAL YANG BERSIH DAN LENGKAP)

// >>> GANTI DEFINISI KELAS DENGAN IMPORT MODEL TUNGGAL INI <<<
import '../pages/module_content_model.dart';
// >>> END IMPORT MODEL <<<

// HAPUS DEFINISI LAMA CLASS MODULECONTENT DARI FILE INI!

// Data Kursus "Gerak Anggun Tari Klasik Keraton Jawa"
final List<ModuleContent> tariKeratonModules = [
  // --- INDEKS 0: PENGANTAR ---
  ModuleContent(
    title: 'COURSE OVERVIEW',
    duration: '03:30',
    contentTitle: 'Pengantar Tari Klasik Keraton Jawa',
    contentText:
        """Tari Klasik Keraton Jawa (seperti Serimpi dan Bedhaya) adalah warisan budaya adiluhung yang diciptakan oleh para Sultan Mataram. Tarian ini melampaui sekadar pertunjukan; ia adalah meditasi bergerak (*Joged Mataram*) yang melambangkan kehalusan budi, ketenangan, dan filosofi spiritual Jawa yang mendalam. Kursus ini akan menjadi panduan untuk memahami setiap aspek kesakralan, dari gerakan hingga busana.

Filosofi dasar tarian ini berakar pada konsep *Tuntunan, Bukan Tontonan*. Artinya, setiap gerakan lembut, lambat, dan terkontrol bertujuan untuk melatih karakter penari agar memiliki 4 kualitas jiwa yang disebut *Catur Watak*: Sawiji (Konsentrasi), Greget (Semangat Terkendali), Sengguh (Percaya Diri tanpa Sombong), dan Ora Mingkuh (Pantang Menyerah). Kualitas ini relevan untuk diterapkan dalam kehidupan sehari-hari.

Kursus ini akan membedah dua tarian utama: Tari Bedhaya (tarian yang sangat sakral dan sering terkait dengan mitos Ratu Kidul) dan Tari Serimpi (tarian yang melambangkan pertarungan batin dan empat elemen kehidupan). Perbedaan komposisi penari (4 vs 9) dan fungsi ritualnya menjadi kunci pemahaman terhadap kedua mahakarya ini.

Pemahaman akan Busana Adat seperti *Dodot Ageng*, *Paes Ageng*, dan peran iringan Gamelan (*Irama Rasa*) juga menjadi fokus. Dengan mempelajari tarian ini, peserta tidak hanya menguasai teknik, tetapi juga menginternalisasi nilai-nilai ketenangan, kesabaran, dan pengendalian diri yang menjadi inti dari budaya Keraton Jawa.""",
  ),

  // --- MODUL 1: FILOSOFI DAN PERAN (Indeks 1, 2) ---
  ModuleContent(
    title: 'Makna Filosofis Tarian',
    duration: '09:00',
    contentTitle: 'Kehalusan Budi: Gerak Estetik dan Simbolis',
    contentText:
        """Tari Klasik Keraton Jawa adalah representasi fisik dari filosofi *Joged Mataram* yang diciptakan oleh Sultan Hamengkubuwono I. Tarian ini dirancang sebagai sarana pendidikan karakter dan meditasi bergerak. Penari harus mencapai kondisi *Sawiji* (konsentrasi penuh) di atas panggung, melambangkan fokus total pada tujuan hidup tanpa terdistraksi oleh hal-hal sepele.

Setiap gerakan, baik gerakan tangan (*mudra*), posisi kaki (*sabet*), maupun ayunan selendang, diatur sedemikian rupa untuk mencerminkan nilai-nilai luhur. Gerakan yang sangat lambat dan halus melambangkan *sabar* (kesabaran) dan *nrima* (menerima keadaan). Kontrol penuh atas setiap inchi tubuh adalah simbol pengendalian diri (*Greget* yang terkendali) dan kedewasaan spiritual.

Filosofi ini mencakup *Catur Watak* yang wajib dimiliki penari: **Sawiji** (Fokus), **Greget** (Semangat yang kuat namun tersembunyi, seperti api dalam sekam), **Sengguh** (Percaya diri dan berwibawa, tapi tanpa kesombongan), dan **Ora Mingkuh** (Pantang Menyerah atau mundur dari kesulitan). Tarian ini mengajarkan bahwa kekuatan sejati berasal dari ketenangan batin.

Tarian klasik juga sering melambangkan pertarungan batin atau konflik besar yang direduksi menjadi gerakan estetis. Pertarungan antara sifat baik dan buruk dalam diri manusia digambarkan melalui formasi dan gerak penari, yang pada akhirnya harus mencapai titik keseimbangan dan harmoni, sesuai dengan konsep kosmos Jawa.""",
  ),
  ModuleContent(
    title: 'Perbedaan Bedhaya & Serimpi',
    duration: '08:15',
    contentTitle: 'Tari Sakral (Bedhaya) vs. Tarian Peringatan (Serimpi)',
    contentText:
        """Meskipun Tari Bedhaya dan Serimpi sama-sama tergolong Tari Klasik Keraton dan ditarikan oleh penari wanita, keduanya memiliki perbedaan fundamental dalam jumlah penari, fungsi, dan tingkat kesakralan. Bedhaya adalah tarian yang sangat sakral, sementara Serimpi lebih sering dipentaskan untuk peringatan atau upacara besar di keraton.

Tari **Bedhaya** selalu ditarikan oleh **9 orang** penari. Bedhaya Ketawang (dari Keraton Surakarta) adalah yang paling sakral, dipercaya sebagai tarian persembahan dan ungkapan cinta Kanjeng Ratu Kidul kepada Raja Mataram, dan diyakini Ratu Kidul hadir secara gaib saat pementasan. Formasi 9 penari ini melambangkan anatomi tubuh manusia (*Rakit Lajur*), di mana penari Batak mewakili Akal/Pikiran dan Endhel mewakili Hati/Keinginan.

Sementara itu, Tari **Serimpi** ditarikan oleh **4 orang** penari yang harus memiliki kemiripan wajah dan postur tubuh. Jumlah empat penari melambangkan *Kiblat Papat* (Empat Arah Mata Angin) dan *Empat Elemen Alam* (Api/Geni, Air/Tirta, Angin/Maruta, Bumi/Bantala). Tarian ini menggambarkan pertempuran yang seimbang antara sifat-sifat manusia atau elemen yang berlawanan.

Kesakralan Bedhaya ditunjukkan oleh durasinya yang sangat panjang (bisa 1,5 hingga 2 jam) dan gerakannya yang super lambat, menuntut stamina dan fokus spiritual yang luar biasa. Serimpi juga sakral, namun sering menggunakan properti senjata seperti Keris Kecil (*Cundrik*) atau Pistol (Serimpi Pistol) yang menunjukkan bahwa wanita Jawa adalah sosok Srikandi yang lembut namun tangguh dan siap membela kehormatan.""",
  ),

  // --- MODUL 2: TEKNIK DASAR GERAKAN (Indeks 3, 4) ---
  ModuleContent(
    title: 'Posisi Dasar & Gerak Tangan',
    duration: '11:45',
    contentTitle: 'Sikap Dasar (*Sabet*) dan Gerakan Tangan (*Ukel*)',
    contentText:
        """Tari Klasik Jawa didasarkan pada serangkaian sikap tubuh dan gerakan dasar yang memerlukan ketenangan ekstrem dan pengendalian otot yang sempurna. Kunci utama dalam semua gerakan adalah *Lemes* (lentur) dan *Anteng* (tenang), yaitu kemampuan untuk bergerak perlahan dengan kekuatan tersembunyi, seolah-olah penari mengambang di udara.

Istilah kunci untuk gerak kaki dan posisi dasar adalah **Sabet**. Sabet meliputi berbagai sikap berdiri, perpindahan berat tubuh, dan langkah kaki yang sangat teratur. Sabet memastikan bahwa postur penari selalu tegak, gagah, dan berwibawa, mencerminkan sifat *Sengguh* yang merupakan salah satu *Catur Watak*.

Gerakan tangan dan pergelangan tangan disebut **Ukel**. Ukel adalah gerakan memutar pergelangan tangan yang dilakukan dengan sangat lembut, lambat, dan luwes. Setiap jari diatur sedemikian rupa agar menghasilkan *mudra* (sikap tangan) yang estetis dan memiliki makna simbolis. Kelembutan Ukel melambangkan kehalusan budi dan kesabaran seorang wanita keraton.

Penari klasik selalu fokus pada *Seleh* (jatuhnya gerakan). Setiap gerakan harus diakhiri secara presisi dan tepat bersamaan dengan bunyi Gong, menunjukkan ketepatan waktu dan pengendalian diri. Keseluruhan teknik dasar ini melatih penari untuk mencapai keselarasan antara pikiran, rasa, dan tubuh, menjadikannya tarian meditasi yang unik.""",
  ),
  ModuleContent(
    title: 'Pola Lantai dan Iringan',
    duration: '07:20',
    contentTitle: 'Formasi (*Gawang*) dan Peran Gamelan',
    contentText:
        """Pola lantai dalam Tari Klasik Keraton Jawa disebut **Gawang** atau Formasi. Pola ini sangat geometris, teratur, dan dilakukan dengan tempo yang sangat lambat. Pola Gawang mencerminkan ketertiban kosmos, keseimbangan alam, dan hierarki sosial. Penari harus bergerak dalam sinkronisasi yang hampir sempurna, melambangkan kesatuan spiritual dan kolektivitas.

Iringan musik untuk tarian klasik ini adalah Gamelan. Musik Gamelan yang digunakan harus bernuansa lembut (*Laras Pelog*) dan menenangkan, menciptakan atmosfer magis dan spiritual. Gamelan tidak dimainkan dengan metronome yang ketat; temponya diatur berdasarkan "rasa" dan komando yang diberikan oleh pemain **Kendang**.

**Kendang** berfungsi sebagai pemimpin irama atau komando. Pengendang akan memberikan kode kepada penari kapan gerakan harus melambat, kapan harus dipercepat (biasanya sangat jarang), atau kapan harus berhenti total. Ini menunjukkan pentingnya komunikasi non-verbal dan harmoni antara penari dan pengiring.

**Gong** memiliki peran sebagai penanda akhir kalimat lagu (*Sele*). Ketika Gong dibunyikan, penari harus mengakhiri gerakannya pada titik *Seleh* (berhenti dengan postur yang sempurna). Keseluruhan Gamelan dan pola lantai ini bekerja bersama untuk memastikan bahwa tarian tidak hanya enak dilihat, tetapi juga tepat secara ritual dan filosofis, menjaga kesakralan pertunjukan.""",
  ),

  // --- QUIZ MODUL 1 & 2 (Indeks 5) ---
  ModuleContent(
    title: 'Quiz Modul 1 & 2',
    duration: '00:00',
    contentTitle: 'Uji Pemahaman: Filosofi dan Teknik Dasar Tari',
    contentText:
        'Uji pengetahuan Anda tentang makna Bedhaya, Serimpi, dan istilah gerakan dasar seperti Sabet dan Ukel.',
    isQuiz: true,
  ),

  // --- MODUL 3: BUSANA DAN ATRIBUT (Indeks 6, 7, 8) ---
  ModuleContent(
    title: 'Busana Bedhaya',
    duration: '10:00',
    contentTitle: 'Busana Dodot, Gelung, dan Selendang',
    contentText:
        """Busana Tari Klasik, khususnya Bedhaya, dikenal sebagai *Dodot Ageng*. **Dodot** adalah kain batik panjang yang sakral (dapat mencapai 4 meter) yang dikenakan tanpa dijahit menjadi rok. Kain ini dililitkan pada tubuh penari dengan teknik rumit (*ubet*) sehingga membentuk volume yang indah namun tetap memberikan ruang gerak.

Penari Bedhaya harus mengenakan busana yang identik untuk melambangkan kesatuan spiritual dan persamaan derajat di hadapan Dewata. Warna busana Bedhaya seringkali minimalis, dominan warna cokelat (*soga*) atau merah tua, mencerminkan kemurnian dan kekudusan ritual. Penari Bedhaya dianggap sebagai representasi bidadari atau Dewi yang turun ke bumi.

**Gelung** (sanggul) yang dikenakan juga harus sederhana, dilengkapi dengan hiasan bunga. Terdapat juga *Paes Ageng* (rias wajah pengantin) yang diterapkan pada penari. Dahi diberi pidih hitam dan alis dibentuk menyerupai tanduk rusa (*alis menjangan*). Ini bertujuan mengubah penari menjadi sosok yang tidak "membumi" (bukan wanita biasa).

Secara keseluruhan, Busana Dodot Ageng dan riasan Paes Ageng dirancang untuk membangun atmosfer magis. Busana yang tidak dijahit dan riasan yang rumit menegaskan bahwa tarian ini adalah ritual yang memerlukan persiapan fisik dan spiritual yang mendalam, bukan sekadar busana untuk pertunjukan biasa.""",
  ),
  ModuleContent(
    title: 'Aksesoris dan Makna',
    duration: '09:30',
    contentTitle: 'Simbolisme Perhiasan Emas dan Kembang',
    contentText:
        """Aksesoris yang digunakan oleh penari Bedhaya dan Serimpi juga memiliki makna simbolis yang mendalam, melengkapi filosofi gerakan dan busana. Perhiasan yang digunakan, seperti *anting-anting*, *gelang*, dan *kalung susun*, terbuat dari emas atau replika emas.

Perhiasan emas ini melambangkan kekayaan spiritual dan keagungan (*Keagungan Raja*). Perhiasan bukan untuk memamerkan kekayaan materi, tetapi untuk menegaskan status penari sebagai representasi sosok yang sempurna dan mulia yang berhubungan dengan alam Dewata.

**Kembang** (bunga) yang diletakkan di sanggul atau disematkan pada busana juga sangat penting. Setiap jenis bunga memiliki makna tertentu, tetapi secara umum melambangkan kesucian, keindahan alam semesta, dan kemurnian jiwa penari. Bunga yang harum juga dipercaya membantu penari mencapai kondisi meditasi atau *Sawiji*.

Busana dan aksesoris ini memiliki etika yang ketat. Penari harus memastikan bahwa mereka dalam kondisi suci (bersih dari hadas) saat mengenakannya. Tradisi ini menunjukkan bahwa dalam budaya Keraton Jawa, seni, spiritualitas, dan etika adalah tiga hal yang tidak dapat dipisahkan.""",
  ),
  ModuleContent(
    title: 'Tinjauan Kesenian',
    duration: '05:40',
    contentTitle: 'Pelestarian Tari Klasik Keraton di Era Modern',
    contentText:
        """Pelestarian Tari Klasik Keraton Jawa adalah tantangan besar di era modern, di mana kecepatan dan kepraktisan seringkali menjadi prioritas. Keraton Yogyakarta dan Surakarta memegang peran vital sebagai pusat pelestarian, dengan merekrut dan melatih *Abdi Dalem* (penghulu keraton) penari untuk menjaga kemurnian tradisi Bedhaya dan Serimpi.

Tantangan utama adalah mempertahankan durasi dan kesakralan tarian. Tari Bedhaya, yang bisa memakan waktu hampir dua jam, sulit dipentaskan di luar lingkungan keraton karena menuntut konsentrasi penonton dan penari yang luar biasa. Adaptasi yang dilakukan di luar keraton seringkali mengurangi durasi tarian, yang berisiko mengurangi kedalaman filosofisnya.

Meskipun demikian, tarian ini terus bertahan karena adanya kesadaran akan nilai pendidikan karakter yang ditawarkannya. Pelatihan menjadi penari Keraton adalah proses panjang yang melatih kesabaran, pengendalian diri, dan penghormatan terhadap tradisi, menjadikannya sekolah budi pekerti yang efektif.

Di era modern, Tari Klasik Keraton berfungsi sebagai jangkar budaya. Ia mengingatkan generasi muda tentang akar filosofis Jawa yang menghargai kehalusan, ketenangan, dan pengendalian diri, menawarkan kontras yang berharga terhadap kehidupan serba cepat di luar tembok keraton.""",
  ),

  // --- MODUL 4: STUDI KASUS DAN PENUTUP (Indeks 9, 10, 11) ---
  ModuleContent(
    title: 'Studi Kasus: Tari Serimpi',
    duration: '07:10',
    contentTitle: 'Analisis Gerakan Tari Serimpi (*Papat*)',
    contentText:
        """Tari Serimpi secara unik ditarikan oleh empat penari, yang sering disebut *Serimpi Papat* (Serimpi Empat). Komposisi empat penari ini adalah inti filosofisnya, melambangkan *Kiblat Papat* (Empat Penjuru Mata Angin) atau empat elemen kehidupan: Api (Geni), Air (Tirta), Angin (Maruta), dan Bumi (Bantala). Sinkronisasi yang sempurna di antara keempat penari adalah fokus utama.

Gerakan Serimpi adalah yang paling halus dan lambat di antara tari klasik lainnya. Gerakan ini harus dilakukan dalam kesatuan sempurna, seolah-olah penari adalah satu entitas yang membelah diri. Gerakan ini melambangkan pertarungan batin antara kebaikan dan keburukan dalam diri manusia, yang akhirnya harus mencapai titik ekuilibrium (keseimbangan).

Meskipun lembut, Tari Serimpi sering menggunakan properti senjata, seperti keris kecil (*Cundrik*) atau pistol. Penggunaan senjata ini memberikan kontras yang dramatis; penari wanita yang anggun dan halus ternyata siap bertempur. Ini adalah simbol *Srikandi*, yaitu wanita Jawa yang memiliki ketangguhan, keberanian, dan kesiapan mental untuk menghadapi tantangan.

Formasi pola lantai (*Gawang*) Serimpi sangat terstruktur dan lambat, mencerminkan ketertiban kosmik. Analisis gerakan Serimpi mengajarkan bahwa keindahan sejati terletak pada pengendalian diri total, di mana kekuatan (senjata) disembunyikan di balik keanggunan (gerakan), mencerminkan kepribadian Jawa yang santun namun tegas.""",
  ),
  ModuleContent(
    title: 'Etika Penari dan Penonton',
    duration: '06:20',
    contentTitle: 'Etika Kultural dalam Menghargai Tarian Sakral',
    contentText:
        """Tari Klasik Keraton bukan hanya sekadar seni pertunjukan, melainkan ritual yang memiliki etika kultural ketat yang harus dipatuhi oleh penari maupun penonton. Penari wajib berada dalam kondisi suci (bersih dari hadas) saat menari, dan seluruh proses persiapan busana hingga pementasan diiringi ritual khusus untuk menjaga kesakralannya.

Bagi penonton, etika yang paling penting adalah **menjaga ketenangan dan fokus**. Penonton diminta untuk tidak berbicara, tidak berisik, dan tidak menganggap tarian ini sebagai pertunjukan hiburan biasa. Suasana meditasi dan spiritualitas harus dijaga agar komunikasi vertikal (antara penari/ritual dan Dewata) tidak terganggu.

Selain itu, ada larangan tidak tertulis terkait dengan memotret atau merekam. Meskipun di era modern hal ini sulit dihindari, penonton harus menghormati momen sakral, terutama saat Bedhaya Ketawang, di mana Ratu Kidul dipercaya hadir. Rasa hormat ini adalah bagian dari filosofi *Sengguh* (penghormatan terhadap keagungan).

Penerapan etika ini mengajarkan bahwa seni luhur Keraton Jawa adalah sebuah pengalaman bersama yang menuntut partisipasi batin, bukan hanya mata. Menghargai etika ini berarti menghargai ribuan tahun sejarah, mitologi, dan filosofi spiritual yang terkandung dalam setiap Gerak Anggun Tari Klasik Keraton.""",
  ),

  ModuleContent(
    title: 'Final Assessment',
    duration: '00:00',
    contentTitle: 'Ujian Akhir Kursus Tari Klasik',
    contentText:
        'Selamat! Anda telah menguasai filosofi dan teknik dasar Tari Klasik Keraton Jawa. Saatnya membuktikan pemahaman Anda dalam Ujian Akhir.',
    isQuiz: true,
  ),
];