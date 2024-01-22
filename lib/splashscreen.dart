import 'package:flutter/material.dart';
import 'dart:async';
import 'main.dart';

class SplashScreen extends StatefulWidget {
  final Future<bool> seenOnboarding;

  SplashScreen({required this.seenOnboarding});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Wrap the navigation in a Future.delayed to delay it
    Future.delayed(Duration(seconds: 3)).then((_) {
      widget.seenOnboarding.then((seen) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => MyApp(seenOnboarding: seen)));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        'assets/images/splash.png', // replace 'assets/images/splash.png' with the path to your image
        fit:
            BoxFit.cover, // This line makes the image fill the entire container
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }
}
