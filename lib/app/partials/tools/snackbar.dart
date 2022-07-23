//---------------------------------------------------------------------------------
import 'package:flutter/material.dart';

void showSnackBar(
    {required String message,
    required Color backgroundColor,
    required BuildContext context}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text(message)),
      backgroundColor: backgroundColor,
    ),
  );
}
