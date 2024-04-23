import 'package:employees_coffee_firestore/views/add_coffee.dart';
import 'package:employees_coffee_firestore/views/coffee_list.dart';
import 'package:employees_coffee_firestore/views/edit_coffee_pref.dart';
import 'package:employees_coffee_firestore/views/edit_profile.dart';
import 'package:employees_coffee_firestore/views/my_coffee.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List userids = [];

  void signOut() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CircleAvatar(
                    backgroundColor: Colors.brown,
                    child: IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.person),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditProfilePage(),
                        ));
                      },
                    )),
              )
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            height: 130,
            width: 130,
            child: CircleAvatar(
                backgroundColor: Colors.brown,
                child: Image.asset("assets/images/coffeecup.png", scale: 6)),
          ),
          const SizedBox(
            height: 20,
          ),
          Text("Welcome to the Coffee App!",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold, fontSize: 24)),
          const SizedBox(
            height: 40,
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const MyCoffeePage(),
            )),
            child: Container(
              padding: const EdgeInsets.all(25),
              margin: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                  color: Colors.brown, borderRadius: BorderRadius.circular(8)),
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/coffeecup.png",
                    scale: 16,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text("My Coffee",
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                ],
              )),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const CoffeeList(),
            )),
            child: Container(
              padding: const EdgeInsets.all(25),
              margin: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                  color: Colors.brown, borderRadius: BorderRadius.circular(8)),
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.list_alt,
                    color: Colors.white,
                    size: 27,
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Text("Show all Coffees List",
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                ],
              )),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: signOut,
            child: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(8)),
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text("Sign out",
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                ],
              )),
            ),
          ),
        ],
      )),
    );
  }
}
