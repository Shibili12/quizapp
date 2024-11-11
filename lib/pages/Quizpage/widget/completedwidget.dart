import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:quizapp/controller/questionanswercontroller.dart';
import 'package:quizapp/db/answers_model.dart';
import 'package:quizapp/db/choice_model.dart';
import 'package:quizapp/db/question_model.dart';
import 'package:quizapp/main.dart';
import 'package:quizapp/pages/Homepage/homepage.dart';
import 'package:quizapp/pages/Quizpage/bloc/quiz_bloc.dart';
import 'package:quizapp/pages/Quizpage/quizpage.dart';

class Completedwidget extends StatefulWidget {
  final int studentId;

  Completedwidget({required this.studentId});

  @override
  State<Completedwidget> createState() => _CompletedwidgetState();
}

class _CompletedwidgetState extends State<Completedwidget> {
  Future<void> clearQuizData() async {
    // Open the necessary Hive boxes
    final answersBox = Hive.box<Answers>('answersBox');
    final questionsBox = Hive.box<Question>('questionsBox');
    final choicesBox = Hive.box<Choice>('choicesBox');

    // Clear the contents of each box
    await answersBox.clear();
    await questionsBox.clear();
    await choicesBox.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/sucess.png"),
            Text("Completed",
                style: GoogleFonts.poppins(
                    color: Colors.pink[900],
                    fontSize: 25,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Icon(
                Icons.dashboard_outlined,
                color: Colors.pink,
              ),
              title: Text("Check your level",
                  style: GoogleFonts.poppins(
                      color: Colors.pink[800], fontSize: 17)),
              trailing: Icon(
                Icons.arrow_forward_outlined,
                color: Colors.grey,
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Homepage(
                    studentId: widget.studentId,
                    currentindex: 1,
                  ),
                ));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.question_answer_outlined,
                color: Colors.pink,
              ),
              title: Text("Go to Quiz",
                  style: GoogleFonts.poppins(
                      color: Colors.pink[800], fontSize: 17)),
              trailing: Icon(
                Icons.arrow_forward_outlined,
                color: Colors.grey,
              ),
              onTap: () async {
                await clearQuizData();
                await Questionanswercontroller().populateDummyQuestions();
                context
                    .read<QuizBloc>()
                    .add(LoadQuestions()); // Clear the quiz data
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => QuizPage(studentId: widget.studentId),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
