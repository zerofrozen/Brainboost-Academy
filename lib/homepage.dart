import 'package:brainboost_academy/login_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'flutter_course_page.dart';

class HomePage extends StatefulWidget {
  final User? user;

  HomePage({required this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? imageUrl;
  String? username;
  int _xp = 0;
  int _level = 1;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.user!.uid)
        .get();

    Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;

    setState(() {
      imageUrl = data['imageUrl'];
      username = data['username'];
      _xp = data['xp'] ?? 0; // Use a default value if 'xp' field is absent
      _level = (_xp ~/ 100) + 1; // Update level based on XP
    });
  }

  String getTrophyIcon(int level) {
    // return the trophy icon based on the level.
    // for now, this is a placeholder. Replace this with your logic to map level to trophy icon.
    return 'assets/trophy_icons/trophy$level.png';
  }

  @override
  void dispose() {
    // Close connections and perform cleanup tasks here
    // For example, if you have any streams or listeners, cancel them
    // or release any resources that need to be disposed of.

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Brainboost Academy'),
        backgroundColor: Color.fromARGB(255, 30, 144, 255),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();

              dispose();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(45, 20, 16, 0),
              child: Row(
                children: [
                  imageUrl == null
                      ? CircularProgressIndicator()
                      : ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: imageUrl!,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            width: 61,
                            height: 61,
                            fit: BoxFit.cover,
                          ),
                        ),
                  SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selamat datang,',
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Nunito',
                            color: Colors.black),
                      ),
                      Text(
                        '$username',
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Nunito',
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 1,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 133, 6),
              child: Text(
                'Mata Pelajaran',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  height: 1.3625,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              width: 300.0,
              height: 219.0,
              child: Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                color: Colors.blue,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://i.pinimg.com/564x/ba/d6/51/bad651dfd78f7b1c4d67cc516c204aa4.jpg'),
                            radius: 20.0,
                          ),
                          SizedBox(width: 16.0),
                          Text(
                            'PPL KELAS 11 RPL',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Nunito',
                                color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Pemodelan Perangkat Lunak',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Dibuat oleh: Muhammad Ridho Rifansah',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Nunito',
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/material-symbols-play-lesson-5e8.png',
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(width: 5.0),
                          Text(
                            '10',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Nunito',
                            ),
                          ),
                          SizedBox(width: 16.0),
                          Image.asset(
                            'assets/images/mdi-google-classroom-hLL.png',
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(width: 5.0),
                          Text(
                            'XI-RPL',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Nunito',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(width: 8.0),
                          OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        FlutterCoursePage(user: widget.user)),
                              ).then((value) {
                                // Ambil kembali data user setelah kembali dari halaman kursus
                                getUserData();
                              });
                            },
                            style: ButtonStyle(
                              side: MaterialStateProperty.all(
                                BorderSide(color: Colors.white),
                              ),
                            ),
                            child: Text(
                              'Mulai Belajar',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Nunito',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 133, 6),
              child: Text(
                'Aktivitas kamu',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  height: 1.3625,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              width: 300.0,
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Adjust the radius as needed
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                Colors.blue, // Specify the outline color here
                            width: 2.0, // Specify the outline thickness
                          ),
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust the radius to match the shape
                        ),
                        height: 100.0,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'TOTAL XP',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10), // Spacing between the texts
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/lightbulb.png',
                                    width: 24,
                                    height: 24,
                                  ),
                                  SizedBox(
                                      width:
                                          8), // Spacing between image and text
                                  Text(
                                    '$_xp',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0), // Spasi antara dua card
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Adjust the radius as needed
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                Colors.blue, // Specify the outline color here
                            width: 2.0, // Specify the outline thickness
                          ),
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust the radius to match the shape
                        ),
                        height: 100.0,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'LEVEL',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10), // Spacing between the texts
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    getTrophyIcon(_level),
                                    width: 24,
                                    height: 24,
                                  ),
                                  SizedBox(
                                      width:
                                          8), // Spacing between image and text
                                  Text(
                                    'Level $_level',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Nunito',
                                        color: Colors.blue),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 153, 6),
              child: Text(
                'Leaderboard',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  height: 1.3625,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 5),
            SizedBox(
              height: 300,
              width: 300,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .orderBy('xp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }

                  final users = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final userData =
                          users[index].data() as Map<String, dynamic>;
                      final userImageUrl = userData['imageUrl'];
                      final username = userData['username'];
                      final xp = userData['xp'];

                      Color tileColor = Colors.transparent;

                      if (index == 0) {
                        tileColor = Colors.yellowAccent;
                      } else if (index == 1) {
                        tileColor = Colors.redAccent;
                      } else if (index == 2) {
                        tileColor = Colors.lightGreen;
                      }

                      return Material(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(
                            color: Colors.blue,
                            width: 1.0,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            color: tileColor,
                            child: ListTile(
                              leading: Stack(
                                children: [
                                  if (userImageUrl != null)
                                    CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(userImageUrl),
                                    )
                                  else
                                    CircularProgressIndicator(),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Text(
                                        '${index + 1}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    username,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Nunito',
                                    ),
                                  ),
                                  Text(
                                    '$xp XP',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Nunito',
                                      color: Colors.orangeAccent,
                                    ),
                                  ),
                                  Image.asset(
                                    getTrophyIcon(_level),
                                    width: 24,
                                    height: 24,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
