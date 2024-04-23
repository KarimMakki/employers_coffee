// add user to Firestore database
import '../constants.dart';

Future addUsertoDatabase(
    String firstName, String lastName, String email) async {
  await userDatabase
      .doc(email)
      .set({"firstName": firstName, "lastName": lastName, "email": email});
}
