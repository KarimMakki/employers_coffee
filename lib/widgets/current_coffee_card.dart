import 'package:employees_coffee_firestore/models/coffee_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CurrentCoffeeCard extends StatelessWidget {
  final Coffee coffee;
  const CurrentCoffeeCard({super.key, required this.coffee});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.brown, borderRadius: BorderRadius.circular(7)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Your Current Coffee: ",
                style: GoogleFonts.poppins(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    color: Colors.white)),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Image.asset(
                  "assets/images/coffee-cup.png",
                  scale: 14,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  coffee.type.toString(),
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Image.asset(
                  coffee.isHot!
                      ? "assets/images/hot-coffee.png"
                      : "assets/images/iced-coffee.png",
                  scale: 14,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  coffee.isHot! ? "Hot Coffee" : "Iced Coffee",
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
