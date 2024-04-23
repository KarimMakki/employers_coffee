import 'package:employees_coffee_firestore/functions/add_users_to_db.dart';
import 'package:employees_coffee_firestore/widgets/custom_loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Google sign In
  signInWithGoogle(BuildContext context) async {
    showDialog(context: context, builder: (context) => const CustomLoading());

    // begin interactive sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    // create a new credential for user
    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);

    Future<dynamic> checkIfEmailInUse(String emailAddress) async {
      // Fetch sign-in methods for the email address
      final list =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(emailAddress);

      // In case list is not empty
      if (list.isEmpty) {
        await addUsertoDatabase(gUser.displayName.toString(),
            gUser.displayName.toString(), gUser.email);
      }
    }

    await checkIfEmailInUse(gUser.email);

    Navigator.of(context).pop();
    // finally, let's sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
