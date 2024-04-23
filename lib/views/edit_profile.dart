import 'package:employees_coffee_firestore/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  var currentfirebaseUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    TextEditingController profileName =
        TextEditingController(text: currentfirebaseUser?.displayName ?? "user");
    TextEditingController email =
        TextEditingController(text: currentfirebaseUser?.email ?? "user");
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'My Profile',
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          leading: BackButton(
            color: Colors.white,
          ),
          backgroundColor: Colors.brown,
          toolbarHeight: 70,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          )),
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Column(
            children: [
              Column(
                children: [
                  CircleAvatar(
                    child: Image.network(
                      currentfirebaseUser!.photoURL ??
                          "https://cdn-icons-png.freepik.com/512/3135/3135715.png",
                      scale: 1.7,
                    ),
                    radius: 50,
                  ),
                  SizedBox(height: 6),
                  Text(
                    currentfirebaseUser!.displayName?.toUpperCase() ??
                        "User".toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  enabled: false,
                  controller: profileName,
                  cursorColor: Colors.brown,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person_outline,
                      color: Colors.brown,
                      size: 28,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  enabled: false,
                  controller: email,
                  cursorColor: Colors.brown,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Colors.brown,
                      size: 28,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
