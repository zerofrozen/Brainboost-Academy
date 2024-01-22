import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:brainboost_academy/selectloginregister.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  final _pageCount = 3;
  final _pageTitles = [
    'Apa itu Brainboost Academy?',
    'Fitur Gamifikasi',
    'Selamat Belajar !!'
  ];
  final _pagesubTitles = [
    'Brainboost Academy adalah aplikasi media pembelajaran berbasis Gamifikasi dan Problem Based Learning',
    'Pada aplikasi ini terdapat fitur gamifikasi yaitu pembelajaran dibantu dengan elemen-elemen game untuk meningkatkan motivasi belajar siswa',
    'Akses aplikasi ini dimanapun dan kapanpun. belajar menjadi menyenangkan bukan!'
  ];
  final _pageImages = ['onboarding1.png', 'onboarding2.png', 'onboarding3.png'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pageCount,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/images/' + _pageImages[index],
                          height: 250,
                        ),
                      ),
                      SizedBox(height: 16),
                      Center(
                        child: Text(
                          _pageTitles[index],
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 146, 17),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Center(
                        child: Text(
                          _pagesubTitles[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SmoothPageIndicator(
              controller: _controller,
              count: _pageCount,
              effect: WormEffect(
                dotColor: Color.fromARGB(164, 158, 158, 158),
                activeDotColor: Colors.blue,
                dotHeight: 12,
                dotWidth: 12,
              ),
            ),
            SizedBox(height: 23),
            ElevatedButton(
              onPressed: () {
                if (_controller.page == _pageCount - 1) {
                  _skipOnboarding();
                } else {
                  _controller.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                }
              },
              child: Text('Selanjutnya'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _skipOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnboarding', true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Choose()),
    );
  }
}
