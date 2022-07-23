//---------------------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Container customProgressIndicator(Size screenSize) {
  return Container(
    child: Column(
      children: [
        SizedBox(height: screenSize.height / 2 - 90),
        const Center(
            child: SizedBox(
          height: 35,
          width: 35,
          child: CircularProgressIndicator(
            color: Color.fromARGB(255, 9, 77, 223),
            strokeWidth: 6,
          ),
        )),
        const SizedBox(height: 40),
        const Center(
            child: Text(
          "Processing, please wait...",
          style: TextStyle(
              color: Colors.indigo, fontSize: 18, fontWeight: FontWeight.w700),
        )),
      ],
    ),
    color: Colors.white,
    height: screenSize.height,
    width: screenSize.width,
  );
}

Container pulseProcressbar(Size screenSize) {
  return Container(
    padding: const EdgeInsets.all(0),
    height: screenSize.height,
    color: Colors.white,
    child: Column(
      children: [
        SizedBox(height: screenSize.height / 2 - 100),
        SpinKitPulse(
          size: 72,
          itemBuilder: (BuildContext context, int index) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 83, 34, 189),
                borderRadius: BorderRadius.circular(50),
              ),
            );
          },
        ),
      ],
    ),
  );
}
