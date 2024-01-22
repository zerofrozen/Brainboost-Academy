import 'package:flutter/material.dart';
import 'login_page.dart';
import 'register_page.dart';
import 'Pelengkap/infoteam.dart';
import 'Pelengkap/guideapp.dart';

class Choose extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChooseState();
}

class _ChooseState extends State<Choose> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70, right: 20, left: 20),
              child: Container(
                width: double.infinity,
                height: 350,
                child: Stack(
                  children: [
                    Positioned(
                      top: 16,
                      left: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Selamat Datang',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Brainboost Academy:',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Where Learning Can Be Fun!',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors
                                  .white, // Set the text color to Colors.white
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Image.asset(
                          'assets/images/onboarding-screen-image-1.png',
                          width: double
                              .infinity, // Set the width to the desired value
                          height: 270, // Set the height to the desired value
                          fit: BoxFit.contain, // Adjust the fit as desired
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //sign in
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: const Text('Masuk'),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.lightBlue,
                primary: Colors.white,
                elevation: 2,
                //ukuran button
                fixedSize: const Size(250, 60),
                textStyle:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            //sign up
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: const Text('Daftar Akun'),
              style: OutlinedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 255, 146, 17),
                primary: Colors.white,
                elevation: 2,
                fixedSize: const Size(250, 60),
                textStyle:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Guide()),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.compass_calibration_outlined, size: 20),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text('Panduan Penggunaan'),
                    ],
                  ),
                  style: OutlinedButton.styleFrom(
                    primary: Colors.white,
                    side: BorderSide(
                        width: 2,
                        color: Colors.white), // Add the border strokes
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8)), // Add rounded corners
                    fixedSize: const Size(163, 60),
                    textStyle: const TextStyle(
                        fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => info()),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.info_outline_rounded, size: 20),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text('Infromasi Pengembang'),
                    ],
                  ),
                  style: OutlinedButton.styleFrom(
                    primary: Colors.white,
                    side: BorderSide(
                        width: 2,
                        color: Colors.white), // Add the border strokes
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    fixedSize: const Size(163, 60),
                    textStyle: const TextStyle(
                        fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 10,
            ),
            SizedBox(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(34),
                      topRight: Radius.circular(34),
                    ),
                    color: Colors.white),
                width: double.infinity,
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        'Dipersembahkan Untuk',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: FractionallySizedBox(
                            widthFactor: 0.7,
                            child: Image.asset(
                              'assets/images/logoum.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: FractionallySizedBox(
                            widthFactor: 0.7,
                            child: Image.asset(
                              'assets/images/logokm.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
