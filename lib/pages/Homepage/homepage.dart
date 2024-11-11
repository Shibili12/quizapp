import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizapp/pages/Dashboard/bloc/dashboard_bloc.dart';
import 'package:quizapp/pages/Dashboard/dashboardpage.dart';
import 'package:quizapp/pages/Quizpage/quizpage.dart';
import 'package:quizapp/pages/Settings/settingspage.dart';

class Homepage extends StatefulWidget {
  final int studentId;
  int? currentindex;

  Homepage({super.key, required this.studentId, this.currentindex = 0});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _currentIndex = 0;
  @override
  void initState() {
    setState(() {
      _currentIndex = widget.currentindex ?? 0;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          QuizPage(studentId: widget.studentId),
          BlocProvider(
            create: (context) => DashboardBloc()..add(LoadDashboardData()),
            child: DashboardPage(studentId: widget.studentId),
          ),
          SettingsPage(studentId: widget.studentId),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        backgroundColor: Colors.white,
        color: Colors.grey.shade300,
        height: 60,
        items: <Widget>[
          Icon(
            Icons.question_answer_outlined,
            size: 25,
            color: Colors.pink,
          ),
          Icon(
            Icons.dashboard_outlined,
            size: 25,
            color: Colors.pink,
          ),
          Icon(
            Icons.person_outline_outlined,
            size: 25,
            color: Colors.pink,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
