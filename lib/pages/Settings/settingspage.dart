import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quizapp/db/students_model.dart';
import 'package:quizapp/pages/Dashboard/dashboardpage.dart';
import 'package:quizapp/pages/Homepage/homepage.dart';
import 'package:quizapp/pages/Login/bloc/login_bloc.dart';
// Import the LoginBloc
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:quizapp/pages/Login/login_page.dart';
import 'package:quizapp/pages/Quizpage/quizpage.dart';

class SettingsPage extends StatelessWidget {
  final int studentId; // Receiving studentId as a parameter

  SettingsPage({required this.studentId});
  @override
  Widget build(BuildContext context) {
    // Get the student data from the Hive box
    final studentBox = Hive.box<Students>('studentsBox');

    final student =
        studentBox.values.firstWhere((student) => student.id == studentId);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true, // Use purple theme for AppBar
        title: Text("Profile",
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 20,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Center(
              child: Container(
                width: 280,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  // border: Border.all(color: Colors.black45),
                ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage("assets/avatar.jpg"),
                    ),
                    Text(student.studentName,
                        style: GoogleFonts.poppins(
                            color: Colors.pink[800], fontSize: 20)),
                    Text(student.mobileNo.toString(),
                        style: GoogleFonts.poppins(
                            color: Colors.grey[500], fontSize: 16)),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
                onTap: () {
                  context.read<LoginBloc>().add(LogoutUser());
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.logout_rounded,
                      color: Colors.red.shade900,
                    ),
                    Text("Logout",
                        style: GoogleFonts.poppins(
                            color: Colors.red[900], fontSize: 16))
                  ],
                )),
            SizedBox(
              height: 20,
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
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Homepage(studentId: studentId)));
              },
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
                          studentId: studentId,
                          currentindex: 1,
                        )));
              },
            ),
          ],
        ),
      ),
    );
  }
}
