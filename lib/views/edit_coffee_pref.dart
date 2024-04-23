import 'package:employees_coffee_firestore/models/coffee_model.dart';
import 'package:employees_coffee_firestore/widgets/edit_coffee.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
import '../functions/get_coffeedata_of_user.dart';
import '../widgets/current_coffee_card.dart';

class EditCoffeePage extends StatefulWidget {
  final Coffee coffee;
  const EditCoffeePage({super.key, required this.coffee});

  @override
  State<EditCoffeePage> createState() => _EditCoffeePageState();
}

class _EditCoffeePageState extends State<EditCoffeePage> {
  var currentfirebaseUser = FirebaseAuth.instance.currentUser;

//   final List _docIDs = [];

//   Future getDocID() async {
// // await coffeeDatabase.get().then((snapshot) => snapshot.docs.forEach((document) { }));
//     await coffeeDatabase.get().then((snapshot) {
//       for (var document in snapshot.docs) {
//         _docIDs.add(document.reference.id);
//       }
//     });
//   }

  // @override
  // void initState() {
  //   getDocID();
  //   super.initState();
  // }

  String? dropdownValue;
  bool isHot = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CurrentCoffeeCard(
            coffee: widget.coffee,
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.coffee,
                color: Colors.brown,
              ),
              const SizedBox(
                width: 7,
              ),
              Text("Edit your Coffee",
                  style: GoogleFonts.poppins(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  )),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 350,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                width: 3,
                color: Colors.brown,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: Form(
              // key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      elevation: 5,
                      focusColor: Colors.brown,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      hint: Text(widget.coffee.type!),
                      value: dropdownValue,
                      items: <String>[
                        'Latte',
                        'Cappucino',
                        'Americano',
                        'Espresso'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(fontSize: 20),
                          ),
                        );
                      }).toList(),
                      // Step 5.
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SwitchListTile(
                      title: Text(isHot ? "Hot Coffee" : "Iced Coffee"),
                      value: isHot,
                      onChanged: (bool value) {
                        setState(() {
                          isHot = value;
                        });
                      },
                      secondary: Image.asset(
                        isHot
                            ? "assets/images/hot-coffee.png"
                            : "assets/images/iced-coffee.png",
                        scale: 16,
                      ),
                    ),
                  ),
                  FutureBuilder(
                    future: getdocIDofCoffeeData(),
                    builder: (context, snapshot) {
                      final docID = snapshot.data;
                      final newCoffee = Coffee(
                          type: dropdownValue?.toString() ?? widget.coffee.type,
                          isHot: isHot,
                          employeeName: currentfirebaseUser!.email);
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: GestureDetector(
                          onTap: () {
                            editCoffee(newCoffee);
                            Navigator.of(context).pop();
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                    content: Container(
                                        height: 350,
                                        width: double.maxFinite,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                "assets/images/coffee-cup.png",
                                                scale: 3.5,
                                              ),
                                              const SizedBox(
                                                height: 25,
                                              ),
                                              Text(
                                                "Coffee edited successfully!",
                                                style: GoogleFonts.poppins(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.047,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              const SizedBox(
                                                height: 30,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 15),
                                                  decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: Center(
                                                      child: Text("Done",
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      18))),
                                                ),
                                              )
                                            ])));
                              },
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            margin: const EdgeInsets.symmetric(horizontal: 22),
                            decoration: BoxDecoration(
                                color: Colors.brown,
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                                child: Text("Submit",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16))),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
