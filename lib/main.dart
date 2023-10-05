import 'package:flutter/material.dart';
import 'quizBrain.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


//void main() => runApp(Quizzler());

void main() {

  if (Platform.isAndroid) {
  print('Running on Android device');
 // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
 //TODO trying to get nav bar in android to hide, but this doesn't work here
   }
  runApp(Quizzler());
}

class Quizzler extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey.shade900,
          body: Padding(
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
  int numCorrect = 0;
  int numWrong = 0;
  QuizBrain quizBrain = QuizBrain();
  //Object type=QuizBrain. this instance is called quizBrain. an instance of QuizBrain()

  IconData currentIcon = Icons.star; // Initial icon
  Color currentIconColor = Colors.yellow;

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getQuestionAnswer();
    if (userPickedAnswer == correctAnswer) {
      numCorrect++;
      if (numCorrect == 5) {
        Alert(
          context: context,
          title: "Quizzler",
          desc: "You're doing great! Carry on!",
        ).show();
      }
      print('you got it right');
      currentIcon = Icons.check;
      currentIconColor = Colors.green;
    } else {
      print('You got it wrong');
      currentIcon = Icons.close;
      currentIconColor = Colors.red;
      numWrong++;
    }
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    //TODO this seems to work once there has been a screen interaction
    setState(() {
      quizBrain.nextQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                //    'This is where the question text will go.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Icon(currentIcon,
              color: currentIconColor,
              size: 200),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            numCorrect.toString(),
            style: TextStyle(
              color: Colors.green,
              fontSize: 40.0,
            ),
          ),
          SizedBox(width: 100),
          Text(
            numWrong.toString(),
            style: TextStyle(
              color: Colors.red,
              fontSize: 40.0,
            ),
          ),
        ]),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.green),
                child: Text(
                  'True',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () {
                  checkAnswer(true);
                }),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
                //The user picked false.
              },
            ),
          ),
        ),
        //      Row(children: scoreKeeper),
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
