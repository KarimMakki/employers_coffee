import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employees_coffee_firestore/constants.dart';
import 'package:employees_coffee_firestore/models/coffee_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future editCoffee(Coffee newCoffee) async {
  var currentfirebaseUser = FirebaseAuth.instance.currentUser;

  DocumentReference userRef = userDatabase.doc(currentfirebaseUser!.email);
  Map<String, dynamic> coffeePref = {};
  coffeePref = newCoffee.toFireStoreJson();
  await userRef.update({"coffeePref": coffeePref});
}
