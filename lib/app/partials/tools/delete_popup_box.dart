import 'package:flutter/material.dart';

buildDeleteDialogBox({
  required BuildContext context,
  required String titleText,
  required String subTitleText,
  required String cancelText,
  required String successText,
  required Function() cancleFunction,
  required Function() okFunction,
}) {
  var screenSize = MediaQuery.of(context).size;
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Card(
              child: SizedBox(
                height: 220,
                width: screenSize.width,
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      titleText,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.redAccent.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 2,
                      width: MediaQuery.of(context).size.width - 50,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        subTitleText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.lightBlue.shade900,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: buildConnectionControlButton(
                              buttonText: cancelText,
                              onPressed: cancleFunction,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: buildConnectionControlButton(
                              onPressed: okFunction,
                              buttonText: successText,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
              ),
            ),
          ),
        );
      });
}

//---------------------------------------------------------------------------------
ElevatedButton buildConnectionControlButton({
  required String buttonText,
  required Function() onPressed,
}) {
  return ElevatedButton(
    child: Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      child: Text(buttonText),
    ),
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      primary: Colors.indigo.shade800,
      onPrimary: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2.0),
      ),
    ),
  );
}

//---------------------------------------------------------------------------------