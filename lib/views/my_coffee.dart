import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employees_coffee_firestore/constants.dart';
import 'package:employees_coffee_firestore/models/coffee_model.dart';
import 'package:employees_coffee_firestore/views/add_coffee.dart';
import 'package:employees_coffee_firestore/views/edit_coffee_pref.dart';
import 'package:employees_coffee_firestore/views/login_page.dart';
import 'package:employees_coffee_firestore/widgets/custom_loading.dart';
import 'package:employees_coffee_firestore/widgets/show_loader_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCoffeePage extends StatefulWidget {
  const MyCoffeePage({super.key});

  @override
  State<MyCoffeePage> createState() => _MyCoffeePageState();
}

class _MyCoffeePageState extends State<MyCoffeePage> {
  var currentfirebaseUser = FirebaseAuth.instance.currentUser;
  Coffee? myCoffee;
  Future getCoffeePref() async {
    DocumentReference userRef = userDatabase.doc(currentfirebaseUser!.email);
    final DocumentSnapshot documentSnapshot = await userRef.get();
    final data = documentSnapshot.data() as Map<String, dynamic>;
    Map<String, dynamic> coffeePref = await data['coffeePref'];

    myCoffee = Coffee.fromJson(coffeePref);

    return myCoffee;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        shadowColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              "assets/images/coffeecup.png",
              scale: 15,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "My Coffee",
              style: GoogleFonts.poppins(
                  fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: getCoffeePref(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CustomLoading();
          } else if (snapshot.hasData) {
            return EditCoffeePage(coffee: snapshot.data);
          } else {
            return const AddCoffeePage();
          }
        },
      ),
    );
  }
}
