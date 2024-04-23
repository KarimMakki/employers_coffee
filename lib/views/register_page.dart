import 'package:employees_coffee_firestore/widgets/show_error_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../functions/add_users_to_db.dart';
import '../widgets/my_button.dart';
import '../widgets/my_textfield.dart';
import '../widgets/show_loader_dialog.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({super.key, required this.showLoginPage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void registerNewUser() async {
    // show loading circle
    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return const Center(
    //       child: CircularProgressIndicator(),
    //     );
    //   },
    // );
    showLoaderDialog(context);
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
      addUsertoDatabase(_firstNameController.text.trim(),
          _lastNameController.text.trim(), _emailController.text.trim());
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      showErrorMessage(e.message.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/coffee-cup.png",
                scale: 3,
              ),
              const SizedBox(
                height: 45,
              ),
              Text(
                "Register now by filling the following:",
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 18,
              ),
              MyTextField(
                  controller: _firstNameController,
                  hintText: "First Name",
                  obscureText: false),
              const SizedBox(
                height: 18,
              ),
              MyTextField(
                  controller: _lastNameController,
                  hintText: "Last Name",
                  obscureText: false),
              const SizedBox(
                height: 18,
              ),
              MyTextField(
                controller: _emailController,
                hintText: "Email",
                obscureText: false,
              ),
              const SizedBox(
                height: 18,
              ),
              MyTextField(
                controller: _passwordController,
                hintText: "Password",
                obscureText: true,
              ),
              const SizedBox(
                height: 18,
              ),
              MyTextField(
                  controller: _confirmPasswordController,
                  hintText: "Confirm Password",
                  obscureText: true),
              const SizedBox(
                height: 26,
              ),
              MyButton(onTap: registerNewUser, text: "Register now"),
              const SizedBox(
                height: 26,
              ),
              Text(
                "Already a user?",
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: widget.showLoginPage,
                child: Text(
                  "Login to your Account",
                  style: GoogleFonts.poppins(
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
