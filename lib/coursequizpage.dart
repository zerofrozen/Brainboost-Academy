import 'package:flutter/material.dart';
import 'flutter_course_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Question {
  final String questionText;
  final List<String> choices;
  final int correctAnswerIndex;

  Question({
    required this.questionText,
    required this.choices,
    required this.correctAnswerIndex,
  });
}

class CourseQuizPage extends StatefulWidget {
  final String courseTitle;
  final int xp;
  final Function(int) onComplete;
  final List<Question> questions;

  CourseQuizPage({
    required this.courseTitle,
    required this.xp,
    required this.onComplete,
    required this.questions,
  });

  @override
  _CourseQuizPageState createState() => _CourseQuizPageState();
}

class _CourseQuizPageState extends State<CourseQuizPage> {
  int _currentQuestionIndex = 0;
  int _numCorrectAnswers = 0;
  int? _selectedChoiceIndex;
  int _earnedXP = 0;
  int get xpPerQuestion => widget.xp ~/ widget.questions.length;

  Future<void> _showXPDialog(int earnedXP) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('XP Diperoleh'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Anda berhasil Menjawab $_numCorrectAnswers Pertanyaan dengan benar.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Oke'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FlutterCoursePage(
                      user: FirebaseAuth.instance.currentUser,
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[_currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.courseTitle),
        backgroundColor: Color.fromARGB(255, 30, 144, 255),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              question.questionText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          for (int i = 0; i < question.choices.length; i++)
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(
                  color: Colors.black, // Set the desired border color here
                  width: 2.0, // Set the desired border width here
                ),
              ),
              child: RadioListTile<int>(
                value: i,
                groupValue: _selectedChoiceIndex,
                onChanged: (int? value) {
                  setState(() {
                    _selectedChoiceIndex = value;
                  });
                },
                title: Text(
                  question.choices[i],
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                ),
                controlAffinity: ListTileControlAffinity.trailing,
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _currentQuestionIndex == widget.questions.length - 1
                ? ElevatedButton(
                    onPressed: _selectedChoiceIndex != null
                        ? () {
                            if (_selectedChoiceIndex ==
                                question.correctAnswerIndex) {
                              _numCorrectAnswers++;
                              _earnedXP += xpPerQuestion;
                            }
                            widget.onComplete(_earnedXP);
                            _showXPDialog(_earnedXP);
                          }
                        : null,
                    child: Text('Selesai'),
                  )
                : ElevatedButton(
                    onPressed: _selectedChoiceIndex != null
                        ? () {
                            if (_selectedChoiceIndex ==
                                question.correctAnswerIndex) {
                              _numCorrectAnswers++;
                              _earnedXP += xpPerQuestion;
                            }
                            setState(() {
                              _currentQuestionIndex++;
                              _selectedChoiceIndex = null;
                            });
                          }
                        : null,
                    child: Text('Selanjutnya'),
                  ),
          ),
        ],
      ),
    );
  }
}
