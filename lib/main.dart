import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quizapp/controller/questionanswercontroller.dart';
import 'package:quizapp/db/answers_model.dart';
import 'package:quizapp/db/choice_model.dart';
import 'package:quizapp/db/login_model.dart';
import 'package:quizapp/db/question_model.dart';
import 'package:quizapp/db/students_model.dart';
import 'package:quizapp/pages/Dashboard/bloc/dashboard_bloc.dart';
import 'package:quizapp/pages/Login/bloc/login_bloc.dart';
import 'package:quizapp/pages/Login/login_page.dart';
import 'package:quizapp/pages/Quizpage/widget/bloc/timer_bloc.dart';
import 'package:quizapp/pages/registration/bloc/student_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(QuestionAdapter());
  Hive.registerAdapter(ChoiceAdapter());
  Hive.registerAdapter(StudentsAdapter());
  Hive.registerAdapter(AnswersAdapter());
  Hive.registerAdapter(LoginModelAdapter());
  await Hive.openBox<Question>('questionsBox');
  await Hive.openBox<Choice>('choicesBox');
  await Hive.openBox<Students>('studentsBox');
  await Hive.openBox<Answers>('answersBox');
  await Hive.openBox<LoginModel>('loginBox');

  await Questionanswercontroller().populateDummyQuestions();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => StudentBloc(),
        ),
        BlocProvider(
          create: (context) => TimerBloc(30),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: false,
        ),
        home: LoginPage(),
      ),
    );
  }
}
