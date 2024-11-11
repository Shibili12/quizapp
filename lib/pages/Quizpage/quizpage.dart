import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizapp/controller/quetationrepository.dart';
import 'package:quizapp/pages/Dashboard/dashboardpage.dart';
import 'package:quizapp/pages/Homepage/homepage.dart';
import 'package:quizapp/pages/Quizpage/bloc/quiz_bloc.dart';
import 'package:quizapp/pages/Quizpage/widget/quizview.dart';
import 'package:quizapp/pages/Settings/settingspage.dart';

class QuizPage extends StatelessWidget {
  final int studentId; // Receiving studentId as a parameter

  QuizPage({required this.studentId});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Colors.white], // Gradient from indigo to white
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            "",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Homepage(
                          studentId: studentId,
                          currentindex: 2,
                        )));
              },
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person_outline_rounded,
                  color: Colors.pink,
                ),
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Homepage(
                            studentId: studentId,
                            currentindex: 1,
                          )));
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.dashboard_outlined,
                    color: Colors.pink,
                  ),
                ),
              ),
            ),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        body: BlocProvider(
          create: (context) => QuizBloc(
            studentId: studentId,
            questionRepository: HiveQuestionRepository(),
          )..add(LoadQuestions()),
          child: QuizView(
            studentId: studentId,
          ),
        ),
      ),
    );
  }
}
