import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CourseVideoPage extends StatefulWidget {
  final String courseTitle;
  final int xp;
  final String videoId;
  final VoidCallback onComplete;

  CourseVideoPage({
    required this.courseTitle,
    required this.xp,
    required this.videoId,
    required this.onComplete,
  });

  @override
  _CourseVideoPageState createState() => _CourseVideoPageState();
}

class _CourseVideoPageState extends State<CourseVideoPage> {
  late YoutubePlayerController _controller;
  bool _isVideoEnded = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.courseTitle),
        backgroundColor: Color.fromARGB(255, 30, 144, 255),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                onEnded: (metadata) {
                  setState(() {
                    _isVideoEnded = true;
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _isVideoEnded
                ? ElevatedButton(
                    onPressed: () {
                      widget.onComplete();
                      Navigator.pop(context);
                    },
                    child: Text('Selesai dan Dapatkan ${widget.xp} XP'),
                  )
                : Text(
                    'Tonton video ini hingga selesai dan dapatkan ${widget.xp} XP'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
