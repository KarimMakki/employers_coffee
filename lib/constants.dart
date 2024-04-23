import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final database = FirebaseFirestore.instance;
final userDatabase = database.collection("users");
final coffeeDatabase = database.collection("coffee");
final currentUser = FirebaseAuth.instance.currentUser;
