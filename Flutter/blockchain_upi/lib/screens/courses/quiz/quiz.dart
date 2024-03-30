import 'package:blockchain_upi/screens/courses/quiz/quiz_helper.dart';
import 'package:blockchain_upi/screens/courses/quiz/quiz_results.dart';
import 'package:flutter/material.dart';


class Quiz extends StatefulWidget {
  final List<Map<String, dynamic>> questions;
  const Quiz({
    super.key, required this.questions
  });

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int _questionIndex = 0;
  int _totalScore = 0;
  bool answerWasSelected = false;
  bool endOfQuiz = false;
  bool correctAnswerSelected = false;

  void _questionAnswered(bool answerScore) {
    setState(() {
      // answer was selected
      answerWasSelected = true;
      // check if answer was correct
      if (answerScore) {
        _totalScore++;
        correctAnswerSelected = true;
      }
      //when the quiz ends
      if (_questionIndex + 1 == widget.questions.length) {
        setState(() {
          endOfQuiz = true;
        });
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      if (_questionIndex < widget.questions.length - 1) {
        _questionIndex++;
        answerWasSelected = false;
        correctAnswerSelected = false;
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                QuizResult(result: _totalScore, total:widget.questions.length),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            color: Color.fromRGBO(20, 30, 97, 1),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: double.infinity,
                  // height: 160.0,
                  padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          'Question ${_questionIndex + 1} out of ${widget.questions.length}',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.questions[_questionIndex]['question'],
                          // textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 21.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ...(widget.questions[_questionIndex]['answers']
                as List<Map<String, Object>>)
                    .map(
                      (answer) {
                    bool isCorrect = answer['score'] as bool;
                    bool isSelected = answerWasSelected && isCorrect;
                    bool isWrong = answerWasSelected && !isCorrect;

                    return Answer(
                      answerText: answer['answerText'] as String,
                      borderColor: isSelected
                          ? Colors.green
                          : isWrong
                          ? Colors.red
                          : null,
                      answerTap: () {
                        if (answerWasSelected) {
                          return;
                        }
                        _questionAnswered(isCorrect);
                      },
                    );
                  },
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // minimumSize: Size(double.infinity, 40.0),
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(10.0), // Border radius
                    ),
                  ),
                  onPressed: () {
                    if (!answerWasSelected) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            'Please select an answer before going to the next question'),
                      ));
                      return;
                    }
                    _nextQuestion();
                  },
                  child: Text(endOfQuiz ? 'See Results' : 'Next Question'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}