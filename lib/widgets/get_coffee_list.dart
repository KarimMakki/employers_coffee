import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employees_coffee_firestore/constants.dart';
import 'package:employees_coffee_firestore/models/coffee_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class GetCoffeeList extends StatefulWidget {
  const GetCoffeeList({super.key});

  @override
  State<GetCoffeeList> createState() => _GetCoffeeListState();
}

class _GetCoffeeListState extends State<GetCoffeeList> {
  final Stream<QuerySnapshot> _coffeeStream = userDatabase.snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _coffeeStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SpinKitFoldingCube(
            color: Colors.brown,
          );
        }
        if (snapshot.data!.docs.isNotEmpty) {
          return ListView(
              children: snapshot.data!.docs
                  .map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    if (data["coffeePref"] != null) {
                      Coffee mycoffee = Coffee.fromJson(data["coffeePref"]);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          tileColor: Colors.brown,
                          horizontalTitleGap: 10,
                          leadingAndTrailingTextStyle:
                              GoogleFonts.poppins(color: Colors.white),
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                mycoffee.isHot!
                                    ? "assets/images/hot-coffee.png"
                                    : "assets/images/iced-coffee.png",
                                scale: 18,
                              ),
                              Text(mycoffee.isHot! ? "Hot" : "Iced"),
                            ],
                          ),
                          title: Text(
                            "${mycoffee.type}",
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 21,
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Text(
                                mycoffee.employeeName.toString(),
                                style: TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return SizedBox();
                    }
                  })
                  .toList()
                  .cast());
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: Image.asset(
                    "assets/images/coffee-cup.png",
                  )),
              const SizedBox(height: 16),
              const Text(
                "No Coffees yet!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )
            ],
          );
        }
      },
    );
  }
}
