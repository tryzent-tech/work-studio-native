//---------------------------------------------------------------------------------
import 'package:flutter/material.dart';

Row nativeActionButton(
    {required String buttonText, required Function() onPressed}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: ElevatedButton(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
              child: Text(
                buttonText,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              primary: const Color.fromARGB(255, 108, 88, 206),
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
