import 'package:brainboost_academy/selectloginregister.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'onboardingscreen.dart';
import 'splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? seenOnboarding = prefs.getBool('seenOnboarding');
  if (seenOnboarding == null) {
    await prefs.setBool('seenOnboarding', false);
    seenOnboarding = false;
  }

  runApp(MaterialApp(
      home: SplashScreen(seenOnboarding: Future.value(seenOnboarding))));
}

class MyApp extends StatelessWidget {
  final bool seenOnboarding;

  MyApp({required this.seenOnboarding});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: seenOnboarding ? Choose() : OnboardingScreen(),
    );
  }
}
