import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:quizapp/db/choice_model.dart';
import 'package:quizapp/db/question_model.dart';
import 'package:quizapp/main.dart';
import 'package:quizapp/pages/Quizpage/widget/bloc/timer_bloc.dart';
import 'package:quizapp/pages/Quizpage/widget/quizview.dart';

class QuestionWidget extends StatefulWidget {
  final Question question;
  final List<Choice> choices;
  final Function(int choiceId) onSubmitAnswer;
  final int initialTime;
  final VoidCallback onQuestionFinished;

  QuestionWidget({
    required this.question,
    required this.choices,
    required this.onSubmitAnswer,
    required this.initialTime,
    required this.onQuestionFinished,
  });

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  int? selectedChoiceId;
  bool _answerSubmitted = false;

  @override
  void initState() {
    super.initState();

    context.read<TimerBloc>().add(StartTimer());
  }

  void _handleAnswerSubmission(int choiceId) {
    if (!_answerSubmitted) {
      setState(() {
        _answerSubmitted = true;
      });
      widget.onSubmitAnswer(choiceId);
      context.read<TimerBloc>().add(StopTimer(resetTime: widget.initialTime));
      widget.onQuestionFinished();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      builder: (context, timerState) {
        if (timerState.timeRemaining == 0 && !_answerSubmitted) {
          _answerSubmitted = true; // Prevent multiple submissions
          widget.onSubmitAnswer(-1); // Consider -1 for unanswered questions
          widget.onQuestionFinished(); // Move to next question
        }

        return Container(
          margin: EdgeInsets.fromLTRB(8, 10, 8, 15),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black54,
            ),
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey[100],
          ),
          height: MediaQuery.of(context).size.height * .72,
          child: Column(
            children: [
              // Sticky header showing the question
              Container(
                height: 180,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.pink.shade900,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.pink[100],
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      "Question : ${widget.question.id}",
                      style: GoogleFonts.poppins(
                        color: Colors.pink[900],
                        fontSize: 16,
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          widget.question.question,
                          style: GoogleFonts.poppins(
                              color: Colors.pink[900],
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Time',
                      style: GoogleFonts.poppins(),
                    ),
                    Expanded(
                      child: LinearPercentIndicator(
                        width: MediaQuery.of(context).size.width * 0.68,
                        lineHeight: 10.0,
                        percent: timerState.timeRemaining / widget.initialTime,
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: Colors.orange,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    Text(
                      '00:${timerState.timeRemaining.toString().padLeft(2, '0')}',
                      style: GoogleFonts.poppins(color: Colors.orange[900]),
                    ),
                  ],
                ),
              ),
              // Display choices
              ...widget.choices.map((choice) {
                bool isSelected = selectedChoiceId == choice.id;
                bool isCorrect = widget.question.answerChoicesID ==
                    widget.choices.indexOf(choice);

                return GestureDetector(
                  onTap: () {
                    if (!_answerSubmitted) {
                      setState(() {
                        selectedChoiceId = choice.id;
                      });
                      _handleAnswerSubmission(choice.id); // Submit the answer
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 70,
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: .6,
                        color: isSelected == true
                            ? isCorrect == true
                                ? Colors.green
                                : Colors.red
                            : Colors.grey,
                      ),
                      color: isSelected == true
                          ? isCorrect == true
                              ? Colors.green[400]
                              : Colors.red[400]
                          : Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        choice.choice,
                        style: GoogleFonts.poppins(fontSize: 17),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    context.read<TimerBloc>().add(StopTimer(resetTime: widget.initialTime));
    super.dispose();
  }
}
