import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CourseSlidesPage extends StatefulWidget {
  final String courseTitle;
  final int xp;
  final List<String> slideImages;
  final VoidCallback onComplete;

  CourseSlidesPage({
    required this.courseTitle,
    required this.xp,
    required this.slideImages,
    required this.onComplete,
  });

  @override
  _CourseSlidesPageState createState() => _CourseSlidesPageState();
}

class _CourseSlidesPageState extends State<CourseSlidesPage> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.courseTitle),
        backgroundColor: Color.fromARGB(255, 30, 144, 255),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                Text(
                  '${_currentPage + 1} / ${widget.slideImages.length}',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Nunito',
                  ),
                ),
                SizedBox(width: 10), // Jarak antara teks dan box
                Expanded(
                  child: Container(
                    height:
                        20, // Ubah nilai tinggi container sesuai keinginan Anda
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 255, 146, 17),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: LinearProgressIndicator(
                        value: (_currentPage + 1) / widget.slideImages.length,
                        backgroundColor: Colors.white,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color.fromARGB(255, 255, 146, 17),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.slideImages.length,
              onPageChanged: (page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (context, index) {
                return Image.network(
                  widget.slideImages[index],
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _currentPage == widget.slideImages.length - 1
                ? ElevatedButton(
                    onPressed: () {
                      widget.onComplete();
                      Navigator.pop(context);
                    },
                    child: Text('Selesai dan Dapatkan ${widget.xp} XP'),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SmoothPageIndicator(
                        controller: _pageController,
                        count: widget.slideImages.length,
                        effect: WormEffect(
                          dotColor: Color.fromARGB(255, 212, 212, 212),
                          activeDotColor: Colors.blue,
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
