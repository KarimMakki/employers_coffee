import 'package:employees_coffee_firestore/widgets/custom_loading.dart';
import 'package:employees_coffee_firestore/widgets/google_sign_in_button.dart';
import 'package:employees_coffee_firestore/widgets/my_button.dart';
import 'package:employees_coffee_firestore/widgets/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/show_error_message.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({super.key, required this.showRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // error message to user

  void signInUser() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const CustomLoading();
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
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
              "Welcome! Login to continue using the app",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
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
              height: 26,
            ),
            MyButton(onTap: signInUser, text: "Sign in"),
            const SizedBox(
              height: 18,
            ),
            const GoogleSigninButton(),
            const SizedBox(
              height: 26,
            ),
            Text(
              "Don't have an account?",
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: widget.showRegisterPage,
              child: Text(
                "Create an Account",
                style: GoogleFonts.poppins(
                    decoration: TextDecoration.underline,
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      )),
    );
  }
}
