import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizapp/pages/Login/login_page.dart';
import 'package:quizapp/pages/registration/bloc/student_bloc.dart';

class RegistrationPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegistrationPage({Key? key}) : super(key: key);

  void _registerUser(BuildContext context) {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();
    final mobileNumber = int.tryParse(_mobileController.text.trim());

    if (username.isEmpty || password.isEmpty || mobileNumber == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter all fields")),
      );
      return;
    }

    context
        .read<StudentBloc>()
        .add(RegisterUser(username, mobileNumber, password));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<StudentBloc, StudentState>(
        listener: (context, state) {
          if (state is RegistrationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Registration successful!")),
            );
            Navigator.pop(context);
          } else if (state is RegistrationFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 25,
              ),
              Image.asset(
                "assets/Loginscreen.png",
                width: 350,
                height: 350,
              ),
              // Username Field
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                child: TextField(
                  style: GoogleFonts.poppins(),
                  controller: _usernameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey)),
                    prefixIcon:
                        Icon(Icons.person_outline, color: Colors.pink[400]),
                    hintText: "Username",
                    hintStyle: GoogleFonts.poppins(),
                  ),
                ),
              ),
              // Mobile Number Field
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                child: TextField(
                  style: GoogleFonts.poppins(),
                  controller: _mobileController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey)),
                    prefixIcon: Icon(Icons.phone, color: Colors.pink[400]),
                    hintText: "Mobile Number",
                    hintStyle: GoogleFonts.poppins(),
                  ),
                ),
              ),
              // Password Field
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                child: TextField(
                  style: GoogleFonts.poppins(),
                  controller: _passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey)),
                    prefixIcon:
                        Icon(Icons.lock_open_outlined, color: Colors.pink[400]),
                    hintText: "Password",
                    hintStyle: GoogleFonts.poppins(),
                  ),
                ),
              ),
              // Register Button
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                child: GestureDetector(
                  onTap: () => _registerUser(context),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.pink[800],
                    ),
                    width: double.infinity,
                    height: 60,
                    child: Center(
                      child: Text(
                        "Register",
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: GoogleFonts.poppins(color: Colors.grey),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ));
                    },
                    child: Text(
                      "Login",
                      style: GoogleFonts.poppins(color: Colors.pink),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
