import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constants.dart';

Future getCoffeeDataofCurrentUser() async {
  dynamic coffeedata;

  await coffeeDatabase
      .where("userid", isEqualTo: currentUser!.uid)
      .get()
      .then((QuerySnapshot querySnapshot) {
    for (var docsSnapshot in querySnapshot.docs) {
      coffeedata = docsSnapshot.data()! as Map<String, dynamic>;
    }
  });

  return coffeedata;
}

Future getdocIDofCoffeeData() async {
  dynamic docid;
  var currentfirebaseUser = FirebaseAuth.instance.currentUser;

  await coffeeDatabase
      .where("userid", isEqualTo: currentfirebaseUser!.uid)
      .get()
      .then((QuerySnapshot querySnapshot) {
    for (var docsSnapshot in querySnapshot.docs) {
      docid = docsSnapshot.id;
    }
  });

  return docid;
}
