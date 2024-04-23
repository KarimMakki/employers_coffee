import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employees_coffee_firestore/constants.dart';
import 'package:employees_coffee_firestore/models/coffee_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddCoffeePage extends StatefulWidget {
  const AddCoffeePage({super.key});

  @override
  State<AddCoffeePage> createState() => _AddCoffeePageState();
}

class _AddCoffeePageState extends State<AddCoffeePage> {
  Future addCoffeeReference(Coffee coffee, String email, String name) async {
    DocumentReference userRef = userDatabase.doc(email);
    Map<String, dynamic> coffeePref = {};
    coffeePref = coffee.toFireStoreJson();
    await userRef.update({'coffeePref': coffeePref});
  }

  String? dropdownValue;
  bool isHot = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
              Text("Add Coffee",
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
                      hint: const Text("Choose your Coffee type"),
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
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: GestureDetector(
                      onTap: () {
                        addCoffeeReference(
                          Coffee(
                              type: dropdownValue.toString(),
                              isHot: isHot,
                              employeeName:
                                  currentUser!.displayName.toString()),
                          currentUser!.email.toString(),
                          currentUser!.email.toString(),
                        );
                        _showSnackBarAndPop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        decoration: BoxDecoration(
                            color: Colors.brown,
                            borderRadius: BorderRadius.circular(8)),
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
                            Text("Add your Coffee",
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                          ],
                        )),
                      ),
                    ),
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

  void _showSnackBarAndPop(BuildContext context) {
    // Pop off the current page
    Navigator.pop(context);

    // Show the Snackbar in the previous page
    final snackBar = SnackBar(
      content: Text(
        'Coffee added successfully!',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.green,
    );

    // Using Future.delayed to wait for the previous page to be removed from the widget tree
    Future.delayed(Duration(milliseconds: 100), () {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }
}
