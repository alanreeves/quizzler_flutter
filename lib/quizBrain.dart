import 'questions.dart';

class QuizBrain {
  int _qNum = 0;
  List<Questions> _questionBank = [
    Questions(q: 'The currency of Japan is the yen.', a: true),
    Questions(q: 'The Eiffel Tower is located in Berlin.', a: false),
    Questions(q: 'The human brain weighs approximately 5 pounds.', a: false),
    Questions(q: 'A triangle has four sides.', a: false),
    Questions(
        q: 'The Great Barrier Reef is off the coast of Australia.', a: true),
    Questions(q: 'Goldfish have a three-second memory.', a: false),
    Questions(
        q: 'The Declaration of Independence was signed in 1776.', a: true),
    Questions(q: 'The largest planet in the solar system is Saturn.', a: false),
    Questions(q: 'The capital of Brazil is Rio de Janeiro.', a: false),
    Questions(
        q: 'The Sahara Desert is the largest desert in the world.', a: true),
  ];

 String getQuestionText() {
   return _questionBank[_qNum].questionText;
 }

  bool getQuestionAnswer() {
    return _questionBank[_qNum].questionAnswer;
  }

  void nextQuestion() {
   if (_qNum < _questionBank.length-1){
     _qNum++;
     print('_qNum=$_qNum');
   }
  }

}
//Learning: Underscore makes object private to this class