//---------------------------------------------------------------------------------
import 'package:flutter/material.dart';

Container randomTextField({
  required String hintText,
  required TextInputType keyboardType,
  required TextEditingController controller,
  required String fieldType,
  required String errorText,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    child: TextFormField(
      controller: controller,
      cursorColor: Colors.black,
      style: const TextStyle(
        fontSize: 16,
        color: Color.fromARGB(255, 34, 36, 37),
      ),
      validator: (value) {
        if (fieldType == "phoneNumber") {
          if (value == null || value.isEmpty || value.length != 10) {
            return errorText;
          }
        } else {
          if (value == null || value.isEmpty) {
            return errorText;
          }
        }
        return null;
      },
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.all(15),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 1),
          borderRadius: BorderRadius.circular(30),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 236, 21, 21), width: 2),
          borderRadius: BorderRadius.circular(30),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 236, 21, 21), width: 2),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onChanged: (value) {
        // do something
      },
    ),
  );
}
