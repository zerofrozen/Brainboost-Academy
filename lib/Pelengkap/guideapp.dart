import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Guide extends StatefulWidget {
  @override
  _GuideState createState() => _GuideState();
}

class _GuideState extends State<Guide> {
  final String videoId = "yGw0E8Cqqp4";
  double _currentIndex = 0;
  late PageController _pageController;
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);

    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        autoPlay:
            false, // Atur ke true jika ingin video diputar secara otomatis
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Petunjuk Penggunaan'),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index.toDouble();
                });
              },
              children: [
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/guide.png"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    aspectRatio: 16 / 9,
                    width: double.infinity,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5.0),
          Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: SmoothPageIndicator(
              count: 2,
              controller: _pageController,
              effect: WormEffect(
                activeDotColor: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
