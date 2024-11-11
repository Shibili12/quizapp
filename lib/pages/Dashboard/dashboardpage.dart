import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:quizapp/pages/Homepage/homepage.dart';
import 'package:quizapp/pages/Quizpage/quizpage.dart';
import 'package:quizapp/pages/Settings/settingspage.dart';
import 'package:quizapp/pages/dashboard/bloc/dashboard_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizapp/widgets/myloadingindicator.dart';

class DashboardPage extends StatelessWidget {
  final int studentId; // Receiving studentId as a parameter

  DashboardPage({required this.studentId});

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
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text("", style: GoogleFonts.poppins(color: Colors.white)),
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
                          )));
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.question_answer_outlined,
                    color: Colors.pink,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: BlocProvider(
          create: (context) => DashboardBloc()..add(LoadDashboardData()),
          child: BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
              if (state is DashboardLoading) {
                return Center(child: Myloadingindicator());
              } else if (state is DashboardError) {
                return Center(child: Text(state.message));
              } else if (state is DashboardLoaded) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Dashboard",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 200,
                              width: 160,
                              padding: EdgeInsets.all(8.0),
                              child: PieChart(
                                PieChartData(
                                  sections: [
                                    PieChartSectionData(
                                      value: state.answeredQuestions.toDouble(),
                                      color: Colors.orange[200],
                                      title: "Answered",
                                      radius: 75,
                                      titleStyle: GoogleFonts.poppins(
                                          fontSize: 7,
                                          color: Colors.orange[900],
                                          fontWeight: FontWeight.bold),
                                    ),
                                    PieChartSectionData(
                                      value:
                                          state.unansweredQuestions.toDouble(),
                                      color: Colors.red[200],
                                      title: "Unanswered",
                                      radius: 75,
                                      titleStyle: GoogleFonts.poppins(
                                          fontSize: 7,
                                          color: Colors.red[900],
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 200,
                              width: 160,
                              padding: EdgeInsets.all(8.0),
                              child: PieChart(
                                PieChartData(
                                  sections: [
                                    PieChartSectionData(
                                      value: state.correctAnswers.toDouble(),
                                      color: Colors.green,
                                      title: "Correct",
                                      radius: 75,
                                      titleStyle: GoogleFonts.poppins(
                                          fontSize: 7,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    PieChartSectionData(
                                      value: state.wrongAnswers.toDouble(),
                                      color: Colors.red,
                                      title: "Wrong",
                                      radius: 75,
                                      titleStyle: GoogleFonts.poppins(
                                          fontSize: 7,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(14),
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          height: 70,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.pink[50]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total Questions",
                                  style: GoogleFonts.poppins(
                                      color: Colors.purple[900],
                                      fontWeight: FontWeight.bold)),
                              Text("${state.totalQuestions}",
                                  style: GoogleFonts.poppins(
                                      color: Colors.purple[900],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              padding: EdgeInsets.all(14),
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              height: 100,
                              width: MediaQuery.of(context).size.width * .46,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.green[50]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${state.correctAnswers}",
                                      style: GoogleFonts.poppins(
                                          color: Colors.green[900],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                  Text("Correct \n Answers",
                                      style: GoogleFonts.poppins(
                                          color: Colors.green[900],
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(14),
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              height: 100,
                              width: MediaQuery.of(context).size.width * .46,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.red[200]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${state.wrongAnswers}",
                                      style: GoogleFonts.poppins(
                                          color: Colors.red[900],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                  Text("Wrong \n Answers",
                                      style: GoogleFonts.poppins(
                                          color: Colors.red[900],
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(14),
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          height: 70,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.orange[100]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Answered Questions",
                                  style: GoogleFonts.poppins(
                                      color: Colors.orange[900],
                                      fontWeight: FontWeight.bold)),
                              Text("${state.answeredQuestions}",
                                  style: GoogleFonts.poppins(
                                      color: Colors.orange[900],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          padding: EdgeInsets.all(14),
                          height: 70,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.blue[100]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Unanswered Questions",
                                  style: GoogleFonts.poppins(
                                      color: Colors.blue[900],
                                      fontWeight: FontWeight.bold)),
                              Text("${state.unansweredQuestions}",
                                  style: GoogleFonts.poppins(
                                      color: Colors.blue[900],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                            ],
                          ),
                        ),

                        // Pie chart to show answered vs unanswered
                      ],
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
