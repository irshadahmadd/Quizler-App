// ignore_for_file: prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables, avoid_print, use_key_in_widget_constructors, library_private_types_in_public_api
import 'package:quiz_correct/quiz_brain_.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';
QuizBrain quizBrain = QuizBrain();
void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text('QuizApp'),
        ),
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getAnswer();

    setState(() {
      if (quizBrain.isFinished() == true) {
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'You\'ve reached the end of the quiz.',
        ).show();

        quizBrain.reset();

        scoreKeeper = [];
      } else {
        if (userPickedAnswer == correctAnswer) {
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        // ignore: prefer_const_literals_to_create_immutables
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  quizBrain.getQuestionText(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  checkAnswer(true);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
                child: Text('True'),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      checkAnswer(false);
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.red),
                  ),
                  child: Text('False')),
            ),
          ),
          Row(
            children: scoreKeeper,
          )
        ]);
  }
}
