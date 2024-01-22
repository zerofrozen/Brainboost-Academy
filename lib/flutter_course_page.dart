import 'package:brainboost_academy/course_slides_page.dart';
import 'package:brainboost_academy/homepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'coursevideopage.dart';
import 'coursequizpage.dart';
import 'commentpage.dart';

class FlutterCoursePage extends StatefulWidget {
  final User? user;

  FlutterCoursePage({required this.user});

  @override
  _FlutterCoursePageState createState() => _FlutterCoursePageState();
}

class _FlutterCoursePageState extends State<FlutterCoursePage> {
  int _xp = 0;
  Map<String, bool> _completedCourses = {};

  @override
  void initState() {
    super.initState();
    _loadCompletedCourses();
  }

  void _loadCompletedCourses() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.user!.uid)
        .get();
    setState(() {
      _completedCourses = Map<String, bool>.from(
          (doc.data() as Map<String, dynamic>)['completedCourses'] ?? {});
    });
  }

  void _completeCourse(String courseTitle, int xp) {
    setState(() {
      _xp += xp;
      _completedCourses[courseTitle] = true;
    });

    // Simpan perubahan ke Firebase
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.user!.uid)
        .update({
      'xp': FieldValue.increment(xp),
      'completedCourses': _completedCourses,
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Pemodelan Perangkat Lunak'),
          backgroundColor: Color.fromARGB(255, 30, 144, 255),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => HomePage(
                    user: FirebaseAuth.instance.currentUser,
                  ),
                ),
              );
              // Navigate to the homepage here
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                child: Column(
                  children: [
                    SizedBox(
                      width: 350,
                      height: 300,
                      child: Image.asset(
                        'assets/images/course.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      color: Colors.blue,
                      child: TabBar(
                        tabs: [
                          Tab(icon: Icon(Icons.school), text: 'Materi'),
                          Tab(icon: Icon(Icons.comment), text: 'QnA'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Expanded is removed and replaced with Container for providing height
              Container(
                height: 600,
                child: TabBarView(
                  children: [
                    _buildCourseTab(),
                    CommentPage(user: widget.user),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCourseTab() {
    return ListView(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.blue, width: 2.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ExpansionTile(
            title: ListTile(
              leading: Icon(
                Icons.looks_one_rounded,
                color: Colors.blue,
              ),
              title: Text('Pengenalan'),
              trailing: Image.asset('assets/trophy_icons/trophy1.png'),
            ),
            children: _buildIntoductionCourseItems(),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.blue, width: 2.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ExpansionTile(
            title: ListTile(
              leading: Icon(
                Icons.looks_two_rounded,
                color: Colors.blue,
              ),
              title: Text('Konsep Pemodelan Berorientasi Objek'),
              trailing: Image.asset('assets/trophy_icons/trophy2.png'),
            ),
            children: _buildKonsepCourseItems(),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.blue, width: 2.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ExpansionTile(
            title: ListTile(
              leading: Icon(
                Icons.looks_3_rounded,
                color: Colors.blue,
              ),
              title: Text('Konsep Pemrograman Berorientasi Objek'),
              trailing: Image.asset('assets/trophy_icons/trophy3.png'),
            ),
            children: _buildKonsep2CourseItems(),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.blue, width: 2.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ExpansionTile(
            title: ListTile(
              leading: Icon(
                Icons.looks_4_rounded,
                color: Colors.blue,
              ),
              title: Text('Pemodelan dengan UML'),
              trailing: Image.asset('assets/trophy_icons/trophy4.png'),
            ),
            children: _buildPemodelanCourseItems(),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.blue, width: 2.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ExpansionTile(
            title: ListTile(
              leading: Icon(
                Icons.looks_5_rounded,
                color: Colors.blue,
              ),
              title: Text('Metode Software Development Life Cycle (SDLC)'),
              trailing: Image.asset('assets/trophy_icons/trophy5.png'),
            ),
            children: _buildSDLCCourseItems(),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.orange, width: 2.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ExpansionTile(
            title: ListTile(
              leading: Icon(
                Icons.looks_6_rounded,
                color: Colors.orange,
              ),
              title: Text('Analisis Kebutuhan Sistem Berorientasi Objek'),
              trailing: Image.asset('assets/trophy_icons/trophy6.png'),
            ),
            children: _buildAnalisisKCourseItems(),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.orange, width: 2.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ExpansionTile(
            title: ListTile(
              leading: Image.asset(
                'assets/images/7.png',
                height: 20,
                width: 20,
              ),
              title: Text('Memahami Proses Bisnis Organisasi'),
              trailing: Image.asset('assets/trophy_icons/trophy7.png'),
            ),
            children: _buildMemahamiKCourseItems(),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.orange, width: 2.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ExpansionTile(
            title: ListTile(
              leading: Image.asset(
                'assets/images/8.png',
                height: 20,
                width: 20,
              ),
              title: Text('Analisis Aturan Bisnis'),
              trailing: Image.asset('assets/trophy_icons/trophy8.png'),
            ),
            children: _buildAnalisisACourseItems(),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.orange, width: 2.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ExpansionTile(
            title: ListTile(
              leading: Image.asset(
                'assets/images/9.png',
                height: 20,
                width: 20,
              ),
              title: Text('Membangun Diagram Use Case'),
              trailing: Image.asset('assets/trophy_icons/trophy9.png'),
            ),
            children: _buildMembangunDCourseItems(),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildIntoductionCourseItems() {
    return [
      _buildCourseItem('Introduction', 10, [
        'https://i.pinimg.com/750x/fd/4f/df/fd4fdfcf984e0e097e554703745026ca.jpg',
        'https://i.pinimg.com/750x/f9/25/24/f9252403a36089090ab716ae5f2a07bc.jpg',
        'https://i.pinimg.com/750x/fb/81/00/fb8100672745c3874c292f8942e6ab05.jpg',
        'https://i.pinimg.com/750x/f3/a7/71/f3a7714bc298c6757b8eed7b1e5eddda.jpg',
        'https://i.pinimg.com/750x/fa/17/e7/fa17e7cda3c7efea995488dd00b14534.jpg',
        'https://i.pinimg.com/750x/13/6d/2f/136d2f5a46577b844f7d3cc27173e44f.jpg',
        'https://i.pinimg.com/750x/c5/f3/0d/c5f30d5b564c197a840aaba5e08a7acb.jpg',
      ]),
      _buildCourseItem('Topik yang diperlajari', 15, [
        'https://i.pinimg.com/750x/a3/2b/03/a32b03869e905fcff783d70334dc9e72.jpg',
        'https://i.pinimg.com/750x/e9/25/e2/e925e263c0644963afbce4fe2736dfaa.jpg',
        'https://i.pinimg.com/750x/e1/94/d1/e194d1883380748eef2d6a5cc5207779.jpg',
        'https://i.pinimg.com/750x/c9/35/96/c935962e70411e9d19bbd9aa0b9d9fe3.jpg',
      ]),
      // Tambahkan item kursus lainnya di sini
    ];
  }

  List<Widget> _buildKonsepCourseItems() {
    return [
      _buildCourseItem('Apa itu Pemodelan berorientasi objek', 5, [
        'https://i.pinimg.com/750x/d1/1f/7d/d11f7d5126ffd8d4a959558d4c547882.jpg',
        'https://i.pinimg.com/750x/d1/08/b5/d108b53cce96009845fa6ba9efc30e98.jpg',
        'https://i.pinimg.com/750x/f0/35/76/f03576a04a23d70cbf200ab35d4f06d9.jpg',
        'https://i.pinimg.com/750x/63/8c/c8/638cc85980cb4a4f5c97ec58e2452448.jpg',
        'https://i.pinimg.com/750x/b2/06/c0/b206c098fc666564bcce832b81d280bc.jpg',
        'https://i.pinimg.com/750x/b9/5e/30/b95e30acc5db59972bc0ea25bf4bd18d.jpg',
        'https://i.pinimg.com/750x/a7/6c/56/a76c56db58ff538bd2c2eef147499c0b.jpg',
        'https://i.pinimg.com/750x/dc/69/f2/dc69f2055ff9525b23593b680094c78c.jpg',
        'https://i.pinimg.com/750x/4f/ce/89/4fce89ff83061ff4398565cabff9aee6.jpg',
        'https://i.pinimg.com/750x/3f/f8/30/3ff8306785ed8015fc535c262529f1ae.jpg',
        'https://i.pinimg.com/750x/10/77/b7/1077b7c9137ecfa96f0c5cb8e569e208.jpg',
        'https://i.pinimg.com/750x/16/b7/b7/16b7b72cb65922e1af3a7e416b95eed0.jpg',
      ]),
      _buildCourseItem('Paradigma Pemrograman', 10, [
        'https://i.pinimg.com/750x/7d/c1/27/7dc127d6a9ff38eb7cbb9b8a68e77d1a.jpg',
        'https://i.pinimg.com/750x/f1/4c/7c/f14c7cf81c043e46f1c6d4e5f5c3ddde.jpg',
        'https://i.pinimg.com/750x/ce/ae/25/ceae2516335ee7d3e38679a19f675c38.jpg',
        'https://i.pinimg.com/750x/89/ea/6e/89ea6e75e6eb566ed3519b2ef9bf54ac.jpg',
        'https://i.pinimg.com/750x/71/28/d9/7128d9a84489a5f4cda5cb408393591d.jpg',
        'https://i.pinimg.com/750x/d0/f9/6f/d0f96fbd97f0f5ad7735c6663844f970.jpg',
        'https://i.pinimg.com/750x/d8/eb/24/d8eb2436016f23e61b81cbf863c11212.jpg',
        'https://i.pinimg.com/750x/02/80/0c/02800cc576f25e2043b99efef0994ee8.jpg',
        'https://i.pinimg.com/750x/32/a3/61/32a361219130b7a0065e471a1db9532a.jpg',
        'https://i.pinimg.com/750x/34/d9/25/34d925e792f9b6c6460af308448b12fe.jpg',
      ]),
      _buildCourseItemWithVideo(
          'Konsep Pemodelan Berorientasi Objek (OOP)', 50, 'Q5TLI3K8rW8'),
      _buildCourseItem('Rangkuman', 10, [
        'https://i.pinimg.com/750x/59/41/15/594115ba1df81be34fa1b6ac5aad9c78.jpg',
        'https://i.pinimg.com/750x/e4/9d/3e/e49d3ede37ff87f09bb513535fe6051d.jpg',
        'https://i.pinimg.com/750x/d8/ec/e7/d8ece777f0565c9bb55715ac9f8fbec9.jpg',
      ]),
      // Tambahkan item kursus lainnya di sini
      _buildCourseItemWithQuiz('Brain Challenge Quiz', 60, [
        Question(
          questionText:
              'Pemodelan berorientasi objek dalam pemrograman adalah cara untuk...',
          choices: [
            'Mengorganisir kode menjadi objek-objek yang terpisah',
            'Mengorganisir kode menjadi fungsi-fungsi yang terpisah',
            'Mengorganisir kode menjadi bagian-bagian terstruktur',
            'Mengorganisir kode menjadi objek-objek yang saling terkait'
          ],
          correctAnswerIndex: 3,
        ),
        Question(
          questionText:
              'Objek dalam pemodelan berorientasi objek memiliki ciri-ciri dan perilaku tertentu yang dapat diberikan melalui... ',
          choices: [
            'Proses perhitungan',
            'Fungsi-fungsi yang dipanggil',
            'Sifat dan perilaku yang didefinisikan',
            'Kode program yang dieksekusi'
          ],
          correctAnswerIndex: 2,
        ),
        Question(
          questionText:
              'Pemodelan berorientasi objek memungkinkan objek-objek dalam program bekerja sama dan saling berinteraksi untuk...',
          choices: [
            'Mencapai tujuan program',
            'Memisahkan kode program menjadi bagian-bagian terstruktur',
            'Mengorganisir kode program menjadi fungsi-fungsi terpisah',
            'Mengatur urutan eksekusi kode program'
          ],
          correctAnswerIndex: 0,
        ),
        Question(
          questionText:
              'Paradigma pemrograman yang menganggap segala sesuatu sebagai objek dan atribut disebut sebagai...',
          choices: [
            'Pemrograman nonstruktural',
            'Pemrograman terstruktur',
            'Pemrograman berorientasi objek',
            'Pemrograman fungsional'
          ],
          correctAnswerIndex: 2,
        ),
        Question(
          questionText:
              'Paradigma pemrograman yang menggunakan fungsi-fungsi sebagai dasar utama pemrograman disebut sebagai...',
          choices: [
            'Pemrograman nonstruktural',
            'Pemrograman terstruktur',
            'Pemrograman berorientasi objek',
            'Pemrograman fungsional'
          ],
          correctAnswerIndex: 3,
        ),
        Question(
          questionText:
              'Paradigma pemrograman berorientasi objek memecah program menjadi bagian-bagian yang terdiri dari...',
          choices: [
            'Langkah-langkah logis terpisah',
            'Objek-objek yang saling berinteraksi',
            'Fungsi-fungsi yang terdefinisi',
            'Struktur data yang kompleks'
          ],
          correctAnswerIndex: 1,
        ),
        Question(
          questionText:
              'Keuntungan paradigma pemrograman berorientasi objek adalah... ',
          choices: [
            'Memudahkan pembacaan dan pemahaman kode program',
            'Tidak memerlukan pemisahan antara data dan fungs',
            'Mengurangi kompleksitas pengembangan program',
            'Memungkinkan eksekusi baris kode program sesuai urutan yang ditulis'
          ],
          correctAnswerIndex: 0,
        ),
        // Tambahkan pertanyaan lainnya di sini
      ]),
    ];
  }

  List<Widget> _buildKonsep2CourseItems() {
    return [
      _buildCourseItem('Prinsip Pemrograman Berorientasi Objek', 5, [
        'https://i.pinimg.com/750x/1d/cc/39/1dcc391e6f0c85e0559ddf0d11aa86d9.jpg',
        'https://i.pinimg.com/750x/84/2c/9e/842c9e9bb1b66fe2e9f762c738a79208.jpg',
        'https://i.pinimg.com/750x/3c/99/bd/3c99bd0a6272b33bb290b4252e86423c.jpg',
      ]),
      _buildCourseItem('Objek', 10, [
        'https://i.pinimg.com/750x/fe/21/51/fe215187a4fd4557dd572de6ceb47fdc.jpg',
        'https://i.pinimg.com/750x/f5/11/05/f511054ab8b2a14f4a521c83aa294ecf.jpg',
        'https://i.pinimg.com/750x/76/bf/47/76bf470b83795c76c60e3270eee6394a.jpg',
        'https://i.pinimg.com/750x/c2/59/e7/c259e7801cb5397b2e1210385e3a74c7.jpg',
        'https://i.pinimg.com/750x/40/a7/1b/40a71b1af3a2d6541da72be742e5d197.jpg',
        'https://i.pinimg.com/750x/d1/fd/b1/d1fdb1aadcdbe6c66d701c0447a7de5e.jpg'
      ]),
      _buildCourseItem('Class', 10, [
        'https://i.pinimg.com/750x/b0/da/91/b0da9152094eaaecc2c5bdf36a9e81e4.jpg',
        'https://i.pinimg.com/750x/dd/3d/1a/dd3d1a3326fd4d418e716b1e6a573ace.jpg',
        'https://i.pinimg.com/750x/a0/21/85/a02185e8b9a7899c94defc2fdf8779ab.jpg',
        'https://i.pinimg.com/750x/ea/48/d8/ea48d84ad445e30780f930523c2841f6.jpg',
        'https://i.pinimg.com/750x/91/57/3e/91573e05056f74433143af57723de536.jpg',
        'https://i.pinimg.com/750x/1b/52/f3/1b52f3edd1f53bf69b24c2892d91e40a.jpg',
      ]),
      _buildCourseItem('Abstraksi', 10, [
        'https://i.pinimg.com/750x/38/b0/9c/38b09cb2b08469bf5941ec4df7d4a64f.jpg',
        'https://i.pinimg.com/750x/af/0d/5d/af0d5ddb5a2d92867e77fedadbc456d7.jpg',
        'https://i.pinimg.com/750x/ee/56/3c/ee563c8957caab4e350d1d3312c3c39e.jpg',
        'https://i.pinimg.com/750x/03/41/f5/0341f58bcdd680e4ac22d7b410f42159.jpg',
        'https://i.pinimg.com/750x/ad/ef/52/adef52d8e6dca806f70ed45945e28f53.jpg',
        'https://i.pinimg.com/750x/1f/a5/15/1fa51599ec1f5ba289bc2804211d19b8.jpg',
      ]),
      _buildCourseItem('Enkapsulasi', 10, [
        'https://i.pinimg.com/750x/23/68/3a/23683a5c620f16a987ffa6eb297af6cf.jpg',
        'https://i.pinimg.com/750x/eb/fc/38/ebfc381fde893867ca8bebdb50df4e33.jpg',
        'https://i.pinimg.com/750x/38/ed/ae/38edaebf1702417a3f7bd203923f0e24.jpg',
        'https://i.pinimg.com/750x/a6/91/96/a6919648f4069c566151e0ece848de89.jpg',
        'https://i.pinimg.com/750x/ba/91/3c/ba913c45e3db2a7b0d856ebbb1550e57.jpg',
        'https://i.pinimg.com/750x/ec/10/f2/ec10f25df3d481d2290d5b563aa05ee7.jpg',
      ]),
      _buildCourseItem('Inheritance', 10, [
        'https://i.pinimg.com/750x/c7/82/bb/c782bb16cf3096c9370a5a029844e43b.jpg',
        'https://i.pinimg.com/750x/72/f9/8b/72f98b2999b0753c61ee6e89e639fa94.jpg',
        'https://i.pinimg.com/750x/d2/b6/05/d2b605fd7f4c68429d42573468edf200.jpg',
        'https://i.pinimg.com/750x/f6/ec/3b/f6ec3b9bffc207f6aedf20ceacce5aef.jpg',
        'https://i.pinimg.com/750x/60/e4/34/60e434abd71ff156de35b542acfa0a53.jpg',
        'https://i.pinimg.com/750x/2b/b5/28/2bb528b7eef380bd5a460b929b79689f.jpg',
      ]),
      _buildCourseItem('Polimorfisme', 10, [
        'https://i.pinimg.com/750x/00/c4/c2/00c4c203a2ddc3b8b080be1cbaebf3a8.jpg',
        'https://i.pinimg.com/750x/f2/2e/17/f22e17bb6a9b681e7bec14c09fd938cb.jpg',
        'https://i.pinimg.com/750x/3b/14/6d/3b146d8ea95a972461026aa0952dba00.jpg',
        'https://i.pinimg.com/750x/a8/de/0e/a8de0eed842ed1e0323e6e17dcd2fc39.jpg',
        'https://i.pinimg.com/750x/71/be/58/71be58c5b079b4c4b24e3cff4b3be3fd.jpg',
        'https://i.pinimg.com/750x/af/61/8a/af618a89388e4c5ac62c01dd01a83e77.jpg',
      ]),
      _buildCourseItemWithVideo(
          'Konsep Pemrograman Berorientasi Objek (OOP)', 50, 'R6OMNMuGxnU'),
      _buildCourseItem('Rangkuman', 10, [
        'https://i.pinimg.com/750x/6f/c0/e9/6fc0e9e6cba57c2b6c62d00e8bab9204.jpg',
        'https://i.pinimg.com/750x/f0/97/00/f0970010c38acbc7442b3471790de283.jpg',
        'https://i.pinimg.com/750x/5d/0d/2c/5d0d2cb9ae1563e8b5576844e255dc7f.jpg',
        'https://i.pinimg.com/750x/01/7a/4a/017a4a1d9cc9f303a0c6ee63e69ea983.jpg',
      ]),

      // Tambahkan item kursus lainnya di sini
      _buildCourseItemWithQuiz('Brain Challenge Quiz', 60, [
        Question(
          questionText:
              'Apa yang dimaksud dengan objek dalam pemrograman berorientasi objek?',
          choices: [
            'Sebuah kumpulan data yang diakses melalui kode program',
            'Fokus dari perhatian dalam program',
            'Sesuatu yang memiliki identitas, perilaku, dan atribut',
            'Perangkat keras yang digunakan dalam pemrograman'
          ],
          correctAnswerIndex: 2,
        ),
        Question(
          questionText:
              'Dalam pemrograman berorientasi objek, apa yang dimaksud dengan class?',
          choices: [
            'Cara kerja suatu objek',
            'Blueprint atau template untuk membuat objek',
            'Bahasa yang digunakan dalam pemrograman',
            'Objek yang sudah jadi dan bisa digunakan dalam program'
          ],
          correctAnswerIndex: 1,
        ),
        Question(
          questionText:
              'Apa itu abstraksi dalam pemrograman berorientasi objek?',
          choices: [
            'Proses penyembunyian data',
            'Proses melemparkan data yang tidak penting dan fokus pada data yang penting',
            'Cara kerja suatu objek',
            'Proses menurunkan sebuah class dari class yang sudah ada'
          ],
          correctAnswerIndex: 1,
        ),
        Question(
          questionText:
              'Apa yang dimaksud dengan enkapsulasi dalam pemrograman berorientasi objek?',
          choices: [
            'Proses membuat class baru dari class yang sudah ada',
            'Proses menyembunyikan data atau informasi dalam sebuah paket',
            'Proses mengubah bentuk suatu objek',
            'Proses melemparkan data yang tidak penting dan fokus pada data yang penting'
          ],
          correctAnswerIndex: 1,
        ),
        Question(
          questionText:
              'Konsep apa yang memungkinkan sebuah class menggunakan sebagian atau seluruh atribut atau metode yang dimiliki oleh class lain?',
          choices: ['Abstraksi', 'Enkapsulasi', 'Polimorfisme', 'Inheritance'],
          correctAnswerIndex: 3,
        ),
        Question(
          questionText:
              'Dalam konteks pemrograman, apa yang dimaksud dengan polimorfisme?',
          choices: [
            'Sebuah class dapat memiliki banyak bentuk atau perilaku',
            'Sebuah class dapat melemparkan data yang tidak penting',
            'Sebuah class dapat menyembunyikan data atau informasi',
            'Sebuah class dapat menggunakan sebagian atau seluruh atribut atau metode yang dimiliki oleh class lain'
          ],
          correctAnswerIndex: 0,
        ),
        // Tambahkan pertanyaan lainnya di sini
      ]),
    ];
  }

  List<Widget> _buildPemodelanCourseItems() {
    return [
      _buildCourseItem('Pengenalan UML 1', 5, [
        'https://i.pinimg.com/750x/4e/62/ac/4e62ac4632aee12159eff9d7551858ef.jpg',
        'https://i.pinimg.com/750x/7b/dd/22/7bdd220cff2a0922dc85be85e4090094.jpg',
        'https://i.pinimg.com/750x/5b/8e/c3/5b8ec39becb88e5a32d866ccbf282336.jpg',
        'https://i.pinimg.com/750x/05/5f/87/055f87f0623a6ddd5ba78a9c66d0a378.jpg',
        'https://i.pinimg.com/750x/76/2e/61/762e6117b533c3c6c4a75ebbb0ab2986.jpg',
        'https://i.pinimg.com/750x/0b/91/0a/0b910a3aaa28ace5027daf8d0cdb6769.jpg'
      ]),
      _buildCourseItem('Pengenalan UML 2', 10, [
        'https://i.pinimg.com/750x/6f/fd/2c/6ffd2cdb84a3a3017f4a47c1a22ebec9.jpg',
        'https://i.pinimg.com/750x/a9/23/4f/a9234fc78294c068f21d20e3adb217f0.jpg',
        'https://i.pinimg.com/750x/b6/45/6e/b6456e8c8cd9a1b26894935cee7a8bda.jpg',
        'https://i.pinimg.com/750x/f9/5f/f0/f95ff0276c123317a8a94f34db1e3b5a.jpg',
        'https://i.pinimg.com/750x/fb/60/ff/fb60ff517eef566f846904009a9db5d6.jpg',
        'https://i.pinimg.com/750x/58/03/4a/58034a5f949c97e45d99e8ef96efa253.jpg',
        'https://i.pinimg.com/750x/d1/90/8a/d1908a1e56519277a988ceabdbf7b0d4.jpg',
        'https://i.pinimg.com/750x/79/f9/b4/79f9b459f5343c9e04bc89f03e003e00.jpg',
        'https://i.pinimg.com/750x/1e/69/9c/1e699c1c4f19ea98dc900086810c805e.jpg',
      ]),
      _buildCourseItemWithVideo('UML dan Use Case Diagram', 50, 'zE3EK5WtGac'),
      _buildCourseItem('Rangkuman', 10, [
        'https://i.pinimg.com/750x/47/17/20/4717204345a149cd56e7995b0b1c70ef.jpg',
        'https://i.pinimg.com/750x/51/0b/d7/510bd70641be573ead99fe499410045f.jpg',
        'https://i.pinimg.com/750x/72/44/18/72441856c02e6b841b588c51fc44927d.jpg',
        'https://i.pinimg.com/750x/0f/e8/a2/0fe8a247ee7c10ada8050ff0aa149158.jpg',
        'https://i.pinimg.com/750x/af/5a/eb/af5aeb01c2995b8a343f4c153ae6d4ff.jpg',
        'https://i.pinimg.com/750x/77/7a/e3/777ae3eaa4e709ced4e972eede5fd850.jpg',
        'https://i.pinimg.com/750x/ef/3b/74/ef3b744693907878f8cfa6faee8fda19.jpg',
        'https://i.pinimg.com/750x/fc/ee/bd/fceebd0a944a527af2e509b015b472e5.jpg',
        'https://i.pinimg.com/750x/fd/e8/9d/fde89d3d75a3df36097257654697cdcf.jpg',
      ]),
      // Tambahkan item kursus lainnya di sini
      _buildCourseItemWithQuiz('Brain Challenge Quiz', 60, [
        Question(
          questionText:
              'Apa tujuan utama pemodelan dalam pengembangan perangkat lunak?',
          choices: [
            'Memvisualisasikan objek',
            'Menggambarkan struktur statis sistem',
            'Membantu dalam membangun sistem',
            'Semua jawaban di atas'
          ],
          correctAnswerIndex: 3,
        ),
        Question(
          questionText: 'Apa peran UML dalam pengembangan perangkat lunak?',
          choices: [
            'Menentukan spesifikasi perangkat lunak',
            ' Memvisualisasikan sistem',
            ' Membangun artefak perangkat lunak',
            'Semua jawaban di atas'
          ],
          correctAnswerIndex: 3,
        ),
        Question(
          questionText:
              'Diagram UML yang digunakan untuk memodelkan struktur statis sistem adalah...',
          choices: [
            'Use Case Diagram',
            'Activity Diagram',
            'Class Diagram',
            'Sequence Diagram'
          ],
          correctAnswerIndex: 2,
        ),
        Question(
          questionText:
              'Diagram UML yang digunakan untuk memodelkan perilaku objek dari waktu ke waktu adalah...',
          choices: [
            'State Machine Diagram',
            'Component Diagram',
            'Deployment Diagram',
            'Object Diagram'
          ],
          correctAnswerIndex: 0,
        ),
        Question(
          questionText: 'UML adalah singkatan dari...',
          choices: [
            'Unified Modeling Language',
            'Universal Modeling Language',
            'Unique Modeling Language',
            'Unlimited Modeling Language'
          ],
          correctAnswerIndex: 0,
        ),
        Question(
          questionText: 'UML menggunakan notasi grafis dalam bentuk apa?',
          choices: ['Teks', 'Diagram', 'Angka', 'Simbol'],
          correctAnswerIndex: 1,
        ),
        Question(
          questionText:
              'Diagram UML yang digunakan untuk memodelkan urutan pesan antar objek adalah...',
          choices: [
            'Use Case Diagram',
            'Sequence Diagram',
            'Class Diagram',
            'Communication Diagram'
          ],
          correctAnswerIndex: 1,
        ),
        Question(
          questionText:
              'Kelebihan menggunakan UML dalam pemodelan perangkat lunak adalah...',
          choices: [
            'Mendukung pemodelan sistem yang kompleks',
            'Mengadopsi best practices dalam rekayasa perangkat lunak',
            'Menyediakan notasi grafis yang jelas',
            'Semua jawaban di atas'
          ],
          correctAnswerIndex: 3,
        ),
        Question(
          questionText:
              'Diagram UML yang digunakan untuk menggambarkan alur kerja suatu proses adalah...',
          choices: [
            'Use Case Diagram',
            'Activity Diagram',
            'State Machine Diagram',
            'Communication Diagram'
          ],
          correctAnswerIndex: 1,
        ),
        Question(
          questionText:
              'Diagram UML yang digunakan untuk memodelkan hubungan antar paket atau modul adalah...',
          choices: [
            'Use Case Diagram',
            'Package Diagram',
            'Class Diagram',
            'Object Diagram'
          ],
          correctAnswerIndex: 1,
        ),
        // Tambahkan pertanyaan lainnya di sini
      ]),
    ];
  }

  List<Widget> _buildSDLCCourseItems() {
    return [
      _buildCourseItem('Pendahuluan', 10, [
        'https://i.pinimg.com/750x/f9/6e/7c/f96e7cc22ba0e2446556282d19ee7ca3.jpg',
        'https://i.pinimg.com/750x/30/10/b6/3010b6e00c6a8ebf0a0bf19e2deeea5c.jpg',
        'https://i.pinimg.com/750x/1c/b4/c4/1cb4c4f344e397479601b8f7c0c922b5.jpg',
        'https://i.pinimg.com/750x/4f/b0/3e/4fb03e3853651fad3551dec73c653666.jpg',
        'https://i.pinimg.com/750x/10/82/3f/10823fb1a5243f9bb97e27194493638f.jpg',
        'https://i.pinimg.com/750x/43/1a/ed/431aed2b4e5d517e91500cca0a8f5ca7.jpg',
        'https://i.pinimg.com/750x/cb/cc/65/cbcc6595cd563fe9a4497a685a2fea6f.jpg',
      ]),
      _buildCourseItem('Waterfall', 15, [
        'https://i.pinimg.com/750x/4c/dc/09/4cdc09cd60e5df48ed4aa12baec0bd01.jpg',
        'https://i.pinimg.com/750x/b3/26/b1/b326b1f40d6f00110f647df06ab96afd.jpg',
        'https://i.pinimg.com/750x/ab/08/14/ab0814f1c8e2c5689e3119a7b53cc0ed.jpg',
        'https://i.pinimg.com/750x/52/93/c5/5293c53bfef6b7c7c131ecfbbe6e90b3.jpg',
        'https://i.pinimg.com/750x/5e/4f/ed/5e4fed7b8164828af8b3c5c05a78b22b.jpg',
        'https://i.pinimg.com/750x/02/c0/78/02c0786239f6b8ce228f0f80030fcb2c.jpg',
        'https://i.pinimg.com/750x/bb/ae/1a/bbae1a7a4343aeca720c1f4b9660a6db.jpg',
        'https://i.pinimg.com/750x/60/c1/a2/60c1a2415d9ebb20a47b751bef7ccb4c.jpg',
      ]),
      _buildCourseItem('Agile', 15, [
        'https://i.pinimg.com/750x/dd/38/79/dd3879d4f8e2c1ab03ec179c04494d26.jpg',
        'https://i.pinimg.com/750x/8c/54/75/8c5475c317ce98999f2fcd48415cec0c.jpg',
        'https://i.pinimg.com/750x/01/77/63/017763f53021fb8ef74ac8622113eef7.jpg',
        'https://i.pinimg.com/750x/1b/c7/13/1bc713f2e099afee2611329b583459f7.jpg',
        'https://i.pinimg.com/750x/1b/35/6a/1b356a58b53145a857c3acae0adae91f.jpg',
        'https://i.pinimg.com/750x/27/72/4a/27724a156adb6317bd6dc2b9c2386126.jpg',
        'https://i.pinimg.com/750x/97/3a/b2/973ab27bd97392769d8f9de2a9a12f0f.jpg',
      ]),
      _buildCourseItem('Perbandingan Waterfall & Agile', 15, [
        'https://i.pinimg.com/750x/a2/08/6d/a2086d1d7e19ea38e7f19ff99178e1e8.jpg',
        'https://i.pinimg.com/750x/2c/8a/ae/2c8aae1d9b26d785bdace2742f93b644.jpg',
        'https://i.pinimg.com/750x/5d/e0/04/5de004537105c45679e864cf59c1d8b7.jpg',
        'https://i.pinimg.com/750x/ca/4f/7c/ca4f7ccb923250aa138fedeca2b59c45.jpg',
        'https://i.pinimg.com/750x/e8/f6/19/e8f619589e160d5d18f6cc8bcb423c66.jpg',
        'https://i.pinimg.com/750x/08/f3/06/08f3060856526f25ac5e6f59c6378455.jpg',
      ]),
      _buildCourseItemWithVideo('Agile vs Waterfall', 50, '5RocT_OdQcA'),
      _buildCourseItem('Rangkuman', 15, [
        'https://i.pinimg.com/750x/e5/8a/c5/e58ac53899debe698b025863b7733211.jpg',
        'https://i.pinimg.com/750x/5b/4a/ce/5b4acebf090bb1faa7158a0118fce8d3.jpg',
        'https://i.pinimg.com/750x/37/c5/ae/37c5ae9e684bdbe624a70c3c711ceac0.jpg',
        'https://i.pinimg.com/750x/25/c6/69/25c66945fdc71e2e491f70ea46cc6ebb.jpg',
      ]),
      _buildCourseItem('Brain Challenge Case Study', 15, [
        'https://i.pinimg.com/750x/42/ef/0f/42ef0f48e016ca5050e7c33349ed8f23.jpg',
        'https://i.pinimg.com/750x/a3/27/9d/a3279d0fc141de54843a12b03792adcb.jpg',
        'https://i.pinimg.com/750x/58/42/ba/5842ba0013e4a4459fb588bfbe515843.jpg',
      ]),
      _buildCourseItemWithQuiz('Brain Challenge Quiz', 60, [
        Question(
          questionText:
              'Metode pengembangan perangkat lunak apa yang memandu proses melalui serangkaian tahap yang berurutan secara linear?',
          choices: ['Agile', 'Spiral', 'RAD', 'Waterfall'],
          correctAnswerIndex: 3,
        ),
        Question(
          questionText:
              'Pada metode pengembangan apa feedback dari pelanggan diterima dan diterapkan dalam siklus kerja berikutnya?',
          choices: ['Waterfall', 'Agile', 'Spiral', 'RAD'],
          correctAnswerIndex: 1,
        ),
        Question(
          questionText:
              'Manakah tahapan yang tidak termasuk dalam metode waterfall?',
          choices: [
            'Analisis Kebutuhan',
            'Desain',
            'Pemeliharaan',
            'Sesi Review'
          ],
          correctAnswerIndex: 3,
        ),
        Question(
          questionText:
              'Metode apa yang paling efisien digunakan dalam lingkungan yang sering berubah dan tidak dapat didefinisikan dengan jelas?',
          choices: ['Waterfall', 'Agile', 'Spiral', 'RAD'],
          correctAnswerIndex: 1,
        ),
        Question(
          questionText: 'Dalam konteks metode Agile, apa itu "sprint"?',
          choices: [
            'Waktu singkat untuk mengerjakan tugas sebanyak mungkin',
            'Satu siklus kerja lengkap dalam proses pengembangan',
            'Periode waktu untuk beristirahat dan mempersiapkan diri untuk tahap selanjutnya',
            'Istilah untuk mendeskripsikan kecepatan penyelesaian proyek'
          ],
          correctAnswerIndex: 1,
        ),
        Question(
          questionText:
              'Dalam metode pengembangan perangkat lunak waterfall, apa yang terjadi setelah tahap desain?',
          choices: [
            'Analisis Kebutuhan',
            'Implementasi',
            'Pemeliharaan',
            'Sprint'
          ],
          correctAnswerIndex: 1,
        ),
        Question(
          questionText:
              'Dalam metode pengembangan perangkat lunak agile, bagaimana perubahan ditangani?',
          choices: [
            'Perubahan ditolak karena rencana harus diikuti dengan ketat',
            'Perubahan diakomodasi dan diterapkan dalam siklus kerja berikutnya',
            'Perubahan dibahas di akhir proyek dan diterapkan jika ada waktu',
            'Perubahan hanya diterima pada tahap tertentu dalam siklus pengembangan'
          ],
          correctAnswerIndex: 1,
        ),
        Question(
          questionText:
              'Manakah yang merupakan kelemahan dari metode waterfall?',
          choices: [
            'Tidak dapat merespons dengan cepat terhadap perubahan',
            'Memerlukan komunikasi dan kerja tim yang baik',
            'Kurang efektif dalam lingkungan yang sangat dinamis',
            'Semua jawaban di atas benar'
          ],
          correctAnswerIndex: 3,
        ),
      ]),
      // Tambahkan item kursus lainnya di sini
    ];
  }

  List<Widget> _buildAnalisisKCourseItems() {
    return [
      _buildCourseItem('Analisis Kebutuhan Sistem Berorientasi Objek', 10, [
        'https://i.pinimg.com/750x/ae/89/41/ae8941cf966a0df7ffde606095789f41.jpg',
        'https://i.pinimg.com/750x/8a/89/f3/8a89f3b1b25e26628f5b20924f1b62aa.jpg',
        'https://i.pinimg.com/750x/79/2d/9a/792d9a543c63b9b30c3adc2c4fb2a778.jpg',
        'https://i.pinimg.com/750x/a5/35/6a/a5356afb72d8a7d6abe9b37d9852b5b2.jpg',
        'https://i.pinimg.com/750x/f3/94/3a/f3943a5c101e939dbf1e1a26107ced4c.jpg',
        'https://i.pinimg.com/750x/f6/ec/df/f6ecdfbaceb3924fbdf347719168c127.jpg',
        'https://i.pinimg.com/750x/46/8f/fb/468ffbbe9396d661a58a501a90a57446.jpg',
      ]),
      _buildCourseItem('Metode Mendapatkan Kebutuhan Sistem', 15, [
        'https://i.pinimg.com/750x/dd/71/15/dd7115d00e94671d09f4254bc09ca818.jpg',
        'https://i.pinimg.com/750x/f5/84/06/f5840627143a050e38e35c4db335f783.jpg',
        'https://i.pinimg.com/750x/5c/49/9f/5c499f1874905bf1eb497bedaff8fe61.jpg',
        'https://i.pinimg.com/750x/c2/e7/34/c2e73469d7c7fe8889900caa4841c5cd.jpg',
        'https://i.pinimg.com/750x/46/4f/87/464f870fb72f9b94445a27afacfa867f.jpg',
      ]),
      _buildCourseItemWithVideo(
          'Memahami Analisis kebutuhan Sistem', 50, 'lX1RuDnEKEI'),
      _buildCourseItem('Rangkuman', 15, [
        'https://i.pinimg.com/750x/66/22/a1/6622a1c166a8f019b97efb92feb8c267.jpg',
        'https://i.pinimg.com/750x/95/02/fe/9502fe6b0c323363c52f8afa0c9d15bc.jpg',
        'https://i.pinimg.com/750x/2d/ca/cf/2dcacf77a12bf0f95140b12e194b4857.jpg',
      ]),
      _buildCourseItemWithQuiz('Brain Challenge Quiz', 60, [
        Question(
          questionText: 'Apa itu Analisis Kebutuhan Sistem?',
          choices: [
            ' Proses identifikasi masalah dalam organisasi',
            'Proses pengumpulan kebutuhan sistem dalam pengembangan perangkat lunak',
            'Proses pembuatan deskripsi perangkat lunak',
            'Proses pengujian perangkat lunak'
          ],
          correctAnswerIndex: 1,
        ),
        Question(
          questionText:
              'Apa yang dimaksud dengan kebutuhan fungsional dalam perangkat lunak?',
          choices: [
            'Syarat-syarat yang harus dipenuhi sistem',
            'Daftar fungsi yang harus ada dalam perangkat lunak',
            'Faktor kenyamanan dan kepuasan pengguna',
            'Kebutuhan ekstra yang bukan merupakan fungsi utama perangkat lunak'
          ],
          correctAnswerIndex: 1,
        ),
        Question(
          questionText:
              'Manakah di bawah ini yang bukan termasuk metode untuk mendapatkan kebutuhan sistem?',
          choices: ['Wawancara', 'Diskusi', 'Pengamatan Lapangan', 'Penjualan'],
          correctAnswerIndex: 3,
        ),
        Question(
          questionText:
              'Apa yang merupakan salah satu kelemahan dari metode pengamatan lapangan?',
          choices: [
            'Memungkinkan pengembang dapat menemukan kesulitan-kesulitan yang tidak terungkap melalui proses wawancara atau diskusi',
            'Memungkinkan pengembang untuk berinteraksi langsung dengan pengguna',
            'Pengamatan dapat mengganggu pekerjaan',
            'Memungkinkan pengembang mengidentifikasi masalah bisnis yang sering terjadi'
          ],
          correctAnswerIndex: 3,
        ),
        Question(
          questionText:
              'Mengapa umumnya proses analisis kebutuhan sistem dilakukan dengan gabungan beberapa metode?',
          choices: [
            'Untuk menyelesaikan masalah lebih cepat',
            'Untuk mendapatkan lebih banyak data',
            'Untuk mendapatkan beberapa sudut pandang yang bisa dibandingkan dan saling melengkapi',
            'Semua jawaban di atas benar'
          ],
          correctAnswerIndex: 3,
        ),
      ]),
      // Tambahkan item kursus lainnya di sini
    ];
  }

  List<Widget> _buildMemahamiKCourseItems() {
    return [
      _buildCourseItem('Memahami Proses Bisnis Organisasi', 10, [
        'https://i.pinimg.com/750x/89/76/a5/8976a5db5fb679d7e70c294ee8d8a266.jpg',
        'https://i.pinimg.com/750x/65/49/75/65497510dfc06b82591a7fc796d0cd43.jpg',
        'https://i.pinimg.com/750x/a8/67/ee/a867eea7b7e13f9ece6df6be0e5a9854.jpg',
        'https://i.pinimg.com/750x/c0/9b/61/c09b6122458c727d24d6abd65ab4579a.jpg',
      ]),
      _buildCourseItem('Karakteristik Proses Bisnis', 15, [
        'https://i.pinimg.com/750x/cd/26/fe/cd26fea8c93e9182a235e033903e0619.jpg',
        'https://i.pinimg.com/750x/34/a1/42/34a1421e25d986206399c80268186a6b.jpg',
        'https://i.pinimg.com/750x/d0/b7/0d/d0b70d9884f89f69da352075d2dbe121.jpg',
        'https://i.pinimg.com/750x/91/81/17/9181179051356d5f18c94f4af5233972.jpg',
        'https://i.pinimg.com/750x/2f/27/3f/2f273fc22bb47e63d3e98172567c91c4.jpg',
      ]),
      _buildCourseItem('Rangkuman', 15, [
        'https://i.pinimg.com/750x/8e/70/b5/8e70b5c7a390d88254bd5ae86a3d476a.jpg',
        'https://i.pinimg.com/750x/0b/1f/a4/0b1fa45c5b84775882cb3a18052da947.jpg',
        'https://i.pinimg.com/750x/e7/c8/2d/e7c82d6eb42b8f65da49f7e5ff9b6e1b.jpg',
      ]),
      _buildCourseItemWithQuiz('Brain Challenge Quiz', 60, [
        Question(
          questionText:
              'Apa yang dimaksud dengan proses bisnis dalam organisasi?',
          choices: [
            'Rangkaian aktivitas yang dilakukan untuk mencapai tujuan',
            'Rencana kerja yang dilakukan oleh organisasi',
            'Susunan hierarki dalam organisasi',
            'Kegiatan utama dalam sebuah organisasi'
          ],
          correctAnswerIndex: 0,
        ),
        Question(
          questionText:
              'Sebuah event operasi dalam proses bisnis biasanya melibatkan...',
          choices: [
            'Kegiatan pengambilan keputusan strategis',
            'Aktivitas penyediaan produk atau jasa kepada pelanggan',
            'Pengelolaan dan pemeliharaan data',
            'Evaluasi proses bisnis'
          ],
          correctAnswerIndex: 1,
        ),
        Question(
          questionText:
              'Dalam proses analisis bisnis, mengapa penting untuk mengetahui siapa yang terlibat dalam suatu aktivitas?',
          choices: [
            'Untuk mengetahui siapa yang harus bertanggung jawab jika terjadi kesalahan',
            'Untuk memahami peranan dan tanggung jawab dari masing-masing pihak dalam proses tersebut',
            'Untuk mengetahui siapa yang harus diberikan gaji lebih tinggi',
            'Tidak ada alasan khusus'
          ],
          correctAnswerIndex: 1,
        ),
        Question(
          questionText:
              'Manakah dari berikut ini yang BUKAN merupakan pertanyaan penting dalam analisis proses bisnis',
          choices: [
            'Apa aktivitas yang terjadi?',
            'Kapan aktivitas terjadi?',
            'Berapa lama aktivitas berlangsung?',
            'Apa kesalahan yang mungkin terjadi selama aktivitas berlangsung?'
          ],
          correctAnswerIndex: 2,
        ),
        Question(
          questionText:
              'Bagaimana perangkat lunak dapat membantu dalam proses bisnis?',
          choices: [
            'Dengan mendukung dan memperbaiki proses bisnis yang ada',
            'Dengan menggantikan peran manusia dalam proses bisnis',
            'Dengan mempercepat proses pengambilan keputusan',
            'Semua jawaban di atas benar'
          ],
          correctAnswerIndex: 0,
        ),
      ]),
      // Tambahkan item kursus lainnya di sini
    ];
  }

  List<Widget> _buildAnalisisACourseItems() {
    return [
      _buildCourseItem(
          'Mengerti Peranan dan pengaruhnya dalam organisasi', 10, [
        'https://i.pinimg.com/750x/aa/a8/f5/aaa8f5a988170e0448c3e438e305bc05.jpg',
        'https://i.pinimg.com/750x/e6/87/c2/e687c2175121caf4d68c890ad2c7fa23.jpg',
        'https://i.pinimg.com/750x/2f/e5/b9/2fe5b9444781e52a0cb7b4e4ec910d26.jpg',
        'https://i.pinimg.com/750x/fe/e5/17/fee51717871f002db1f28d6506cbe73b.jpg',
        'https://i.pinimg.com/750x/4a/33/a3/4a33a394095de12b25d7b6eebfa8e7dc.jpg',
        'https://i.pinimg.com/750x/1e/82/34/1e82348c6399f0ff36f95e6be7e73b6d.jpg',
        'https://i.pinimg.com/750x/fc/f9/16/fcf91649cb6c657a4be78e09c06ceea1.jpg',
      ]),
      _buildCourseItem('Mengintegrasikan Aturan Bisnis ke dalam sistem', 15, [
        'https://i.pinimg.com/750x/a3/a0/65/a3a065cc7e6a79081add73a86ecf9b08.jpg',
        'https://i.pinimg.com/750x/8e/d7/ef/8ed7ef7119322fa0d84713abc9b17b6f.jpg',
        'https://i.pinimg.com/750x/64/26/ef/6426ef7553b5b1b71ef1b5c168c7ea1f.jpg',
        'https://i.pinimg.com/750x/5a/b5/bd/5ab5bd64dcc63b49b5340e69337e1468.jpg',
        'https://i.pinimg.com/750x/b2/b8/05/b2b80512145d85ca984bb6c9563a4fe5.jpg',
        'https://i.pinimg.com/750x/76/69/5b/76695ba8a6e59eb03ce386fa97a3f06a.jpg',
        'https://i.pinimg.com/750x/d1/5c/3b/d15c3b294eb6cb7f993356c0422ef777.jpg',
        'https://i.pinimg.com/750x/fa/35/cd/fa35cd39daf002978d141590cee33a6b.jpg',
      ]),
      _buildCourseItemWithQuiz('Brain Challenge Quiz', 60, [
        Question(
          questionText:
              'Apa yang dimaksud dengan aturan bisnis dalam konteks organisasi?',
          choices: [
            'Pedoman yang diikuti ketika menjalankan aktivitas bisnis',
            'Hukum yang mengatur semua kegiatan bisnis',
            'Aturan yang dibuat oleh pemerintah untuk mengendalikan bisnis',
            'Prosedur internal yang hanya berlaku untuk karyawan'
          ],
          correctAnswerIndex: 0,
        ),
        Question(
          questionText:
              'Mengapa penting untuk mengidentifikasi aturan bisnis saat melakukan analisis kebutuhan sistem?',
          choices: [
            'Agar sistem dapat mendukung dan menegakkan aturan bisnis organisasi',
            'Untuk memastikan bahwa semua pegawai memahami aturan bisnis',
            'Untuk menentukan seberapa besar investasi yang dibutuhkan untuk membangun sistem',
            'Agar sistem bisa beroperasi tanpa perlu adanya interaksi manusia'
          ],
          correctAnswerIndex: 0,
        ),
        Question(
          questionText: 'Apa peran teknologi dalam penerapan aturan bisnis?',
          choices: [
            'Menggantikan peran manusia dalam menjaga aturan bisnis',
            'Membuat aturan bisnis menjadi lebih rumit',
            'Mengurangi kebutuhan akan aturan bisnis',
            'Mengotomatisasi sejumlah aturan bisnis untuk meminimalkan kesalahan manusia'
          ],
          correctAnswerIndex: 3,
        ),
        Question(
          questionText:
              'Apa manfaat dari integrasi aturan bisnis ke dalam sistem?',
          choices: [
            'Mempercepat proses, mengurangi beban kerja pegawai, dan meningkatkan kepatuhan aturan',
            'Meningkatkan kompleksitas sistem',
            'Membuat sistem menjadi lebih mahal',
            'Memungkinkan aturan bisnis dihapus dari organisasi'
          ],
          correctAnswerIndex: 0,
        ),
        Question(
          questionText: 'Apa yang dimaksud dengan analisis kebutuhan sistem?',
          choices: [
            'Proses mencari tahu apa yang dibutuhkan oleh sistem untuk berjalan dengan lancar',
            'Proses pengujian sistem untuk mencari bug dan error',
            'Proses memperkirakan biaya pembuatan sistem',
            'Proses memperkirakan waktu yang dibutuhkan untuk membangun sistem'
          ],
          correctAnswerIndex: 0,
        ),
      ]),
      // Tambahkan item kursus lainnya di sini
    ];
  }

  List<Widget> _buildMembangunDCourseItems() {
    return [
      _buildCourseItem('Yuk Kita Kenalan sama Diagram Use Case', 10, [
        'https://i.pinimg.com/750x/a5/06/c9/a506c93946e8cfbf2a0f6f76d85f8290.jpg',
        'https://i.pinimg.com/750x/d4/4b/94/d44b9477e145551aaff7325d7a0ed41c.jpg',
        'https://i.pinimg.com/750x/c9/f1/9d/c9f19d69bea4c43d5d3c495e69ce5253.jpg',
        'https://i.pinimg.com/750x/6e/2e/d9/6e2ed90b48f9e040e5b135fc78e510b8.jpg',
        'https://i.pinimg.com/750x/a2/ba/54/a2ba548749d0acfc99c428ff66489eeb.jpg',
        'https://i.pinimg.com/750x/15/c0/7e/15c07e0b294383d5748d90bb912ea152.jpg',
      ]),
      _buildCourseItem(
          'Mari berkenalan dengan Notasi UML dalam diagram Use Case', 15, [
        'https://i.pinimg.com/750x/c8/f2/c5/c8f2c5bd02c4d70ff32a7f2c62c8a897.jpg',
        'https://i.pinimg.com/750x/85/d1/ff/85d1ffa0630b7af575ce2f3cc425a547.jpg',
        'https://i.pinimg.com/750x/85/33/12/853312b968443969ec5a0410dccd8d7c.jpg',
        'https://i.pinimg.com/750x/d2/f0/8d/d2f08d1852dc5868f5adae7988ef154b.jpg',
        'https://i.pinimg.com/750x/32/f6/b9/32f6b99cd690733a0d0c640b6100338a.jpg',
        'https://i.pinimg.com/750x/df/e8/25/dfe82501008c42ca21679f5d7bc7ab61.jpg',
        'https://i.pinimg.com/750x/2b/c4/81/2bc4817aa4032254da2e795919ab59a2.jpg',
        'https://i.pinimg.com/750x/48/27/c8/4827c821006901ec30181629cd28181a.jpg',
        'https://i.pinimg.com/750x/fe/8a/b7/fe8ab7cccefa3359d5cb0847e18626e3.jpg',
      ]),
      _buildCourseItemWithVideo(
          'Teori & Praktik Use Case Diagram', 50, 'cgV0BFmAg_Y'),
      _buildCourseItem('Rangkuman', 15, [
        'https://i.pinimg.com/750x/1d/ea/d1/1dead14260edfe68d325f9a796efe98b.jpg',
        'https://i.pinimg.com/750x/11/1a/c0/111ac06051975162743ef279146a60b7.jpg',
        'https://i.pinimg.com/750x/72/84/55/7284552838ff5546c2e0df71d7e1cfc1.jpg',
        'https://i.pinimg.com/750x/ab/03/8a/ab038a5da5db72226abbe9ee3bbcf9a0.jpg',
      ]),
      _buildCourseItem('Brain Challenge Case Study 2', 15, [
        'https://i.pinimg.com/750x/ff/e9/3d/ffe93dc8c434890f451e04c92a1ab18f.jpg',
        'https://i.pinimg.com/750x/20/1e/ad/201ead90e8a2afa6370bef87e350f688.jpg',
        'https://i.pinimg.com/750x/6d/c0/84/6dc0844b1cdacf95d5a6a086f220f690.jpg',
      ]),
      _buildCourseItemWithQuiz('Brain Challenge Quiz', 60, [
        Question(
          questionText: 'Apa itu Diagram Use Case? ',
          choices: [
            'Sketsa cerita aplikasi kita',
            'Kode program',
            'Alat tes aplikasi',
            'Buku manual aplikasi'
          ],
          correctAnswerIndex: 0,
        ),
        Question(
          questionText: 'Siapa saja bintang utama dalam Diagram Use Case? ',
          choices: [
            'Programmer dan User',
            'Sistem dan Use Case',
            'Aktor dan Use Case',
            'Aktor dan Programmer'
          ],
          correctAnswerIndex: 2,
        ),
        Question(
          questionText:
              'Bagaimana cara menggambarkan Sistem dalam Diagram Use Case?',
          choices: [
            'Menggunakan bentuk telur',
            'Menggunakan simbol stickman',
            'Menggunakan garis dan anak panah',
            'Menggunakan persegi panjang'
          ],
          correctAnswerIndex: 3,
        ),
        Question(
          questionText:
              'Bagaimana cara menggambarkan Use Case dalam Diagram Use Case?',
          choices: [
            'Menggunakan bentuk telur',
            'Menggunakan simbol stickman',
            'Menggunakan garis dan anak panah',
            'Menggunakan persegi panjangi'
          ],
          correctAnswerIndex: 0,
        ),
        Question(
          questionText:
              'Bagaimana cara menggambarkan Aktor dalam Diagram Use Case?',
          choices: [
            'Menggunakan bentuk telur',
            'Menggunakan simbol stickman',
            'Menggunakan garis dan anak panah',
            'Menggunakan persegi panjangi'
          ],
          correctAnswerIndex: 1,
        ),
        Question(
          questionText:
              'Bagaimana cara menggambarkan Relasi dalam Diagram Use Case?',
          choices: [
            'Menggunakan bentuk telur',
            'Menggunakan simbol stickman',
            'Menggunakan garis dan anak panah',
            'Menggunakan persegi panjangi'
          ],
          correctAnswerIndex: 2,
        ),
        Question(
          questionText: 'Apa yang bisa dilihat dari Diagram Use Case?',
          choices: [
            'Interaksi pengguna dengan aplikasi',
            'Kode program aplikasi',
            'Desain antarmuka aplikasi',
            'Biaya pengembangan aplikasi'
          ],
          correctAnswerIndex: 0,
        ),
      ]),
      // Tambahkan item kursus lainnya di sini
    ];
  }

  Widget _buildCourseItem(
      String courseTitle, int xp, List<String> slideImages) {
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: ListTile(
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.orange,
              ),
              child: Icon(
                Icons.article_outlined,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                courseTitle,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 17,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '+$xp XP',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
            if (_completedCourses[courseTitle] == true)
              Icon(Icons.check_circle_outlined, color: Colors.orange),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CourseSlidesPage(
                courseTitle: courseTitle,
                xp: xp,
                onComplete: () {
                  if (_completedCourses[courseTitle] != true) {
                    _completeCourse(courseTitle, xp);
                  }
                },
                slideImages: slideImages,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCourseItemWithVideo(String courseTitle, int xp, String videoId) {
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: ListTile(
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
              child: Icon(
                Icons.slow_motion_video_rounded,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                courseTitle,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 17,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '+$xp XP',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
            if (_completedCourses[courseTitle] == true)
              Icon(Icons.check_circle_outlined, color: Colors.red),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CourseVideoPage(
                courseTitle: courseTitle,
                xp: xp,
                onComplete: () {
                  if (_completedCourses[courseTitle] != true) {
                    _completeCourse(courseTitle, xp);
                  }
                },
                videoId: videoId,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCourseItemWithQuiz(
      String courseTitle, int xp, List<Question> questions) {
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: ListTile(
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green,
              ),
              child: Icon(
                Icons.task_outlined,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                courseTitle,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 17,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '+$xp XP',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
            if (_completedCourses[courseTitle] == true)
              Icon(Icons.check_circle_outlined, color: Colors.green),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CourseQuizPage(
                courseTitle: courseTitle,
                xp: xp,
                onComplete: (earnedXP) {
                  if (_completedCourses[courseTitle] != true) {
                    _completeCourse(courseTitle, earnedXP);
                  }
                },
                questions: questions,
              ),
            ),
          );
        },
      ),
    );
  }
}
