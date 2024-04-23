import 'package:flutter/material.dart';

void showErrorMessage(String message, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(message),
      );
    },
  );
}
