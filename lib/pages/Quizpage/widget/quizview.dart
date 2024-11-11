import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizapp/pages/Homepage/homepage.dart';
import 'package:quizapp/pages/Quizpage/bloc/quiz_bloc.dart';
import 'package:quizapp/pages/Quizpage/widget/bloc/timer_bloc.dart';
import 'package:quizapp/pages/Quizpage/widget/completedwidget.dart';
import 'package:quizapp/pages/Quizpage/widget/questionwidget.dart';
import 'package:quizapp/widgets/myloadingindicator.dart';
import 'package:quizapp/db/choice_model.dart';

class QuizView extends StatefulWidget {
  final int studentId; // Receiving studentId as a parameter

  QuizView({required this.studentId});

  @override
  _QuizViewState createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  late PageController _pageController;
  int _lastPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  // Move to next question or navigate to Completedwidget if last question
  void _moveToNextQuestionOrComplete(int currentPageIndex, int totalQuestions) {
    if (currentPageIndex == totalQuestions - 1) {
      // If last page, navigate to the Completedwidget
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => Completedwidget(studentId: widget.studentId),
      ));
    } else {
  
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      context.read<TimerBloc>().add(StopTimer(resetTime: 30));
      context.read<TimerBloc>().add(StartTimer());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizBloc, QuizState>(
      builder: (context, state) {
        if (state.questions.isEmpty) {
          return Center(child: Myloadingindicator());
        }

        return NotificationListener<ScrollEndNotification>(
          onNotification: (scrollEnd) {
            // Trigger lazy loading when reaching the end of PageView
            if (_pageController.position.extentAfter < 100) {
              context.read<QuizBloc>().add(LoadQuestions());
            }
            return false;
          },
          child: PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            itemCount: state.questions.length,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (pageIndex) {
              _lastPage = pageIndex;
            },
            itemBuilder: (context, index) {
              final question = state.questions[index];
              final choices = state.questionChoices[question.id] ?? [];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  QuestionWidget(
                    question: question,
                    choices: choices,
                    onSubmitAnswer: (choiceId) {
                      context.read<QuizBloc>().add(SubmitAnswer(
                          question.id, choiceId, widget.studentId));
                      _moveToNextQuestionOrComplete(
                          index, state.questions.length);
                    },
                    onQuestionFinished: () {
                      _moveToNextQuestionOrComplete(
                          index, state.questions.length);
                    },
                    initialTime: 30,
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
