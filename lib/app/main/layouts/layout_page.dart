import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:work_studio/app/login/login.dart';
import 'package:work_studio/app/main/screens/homepage.dart';
import 'package:work_studio/app/partials/tools/delete_popup_box.dart';
import 'package:work_studio/app/partials/tools/please_wait_indicator.dart';
import 'package:work_studio/app/storage/local_storage.dart';
import 'package:work_studio/app/storage/variables.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({
    Key? key,
  }) : super(key: key);
  @override
  _LayoutPageState createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  final LocalStorage _localStorage = LocalStorage();

  bool isUserLoggedIn = false;
  bool isProcessing = true;
  String mainApplicationURL = "";

  @override
  void initState() {
    getUserInfoFromLocalStorage();
    super.initState();
  }

  void getUserInfoFromLocalStorage() async {
    bool isLoggedIn = await _localStorage.getIsLoggedIn();
    mainApplicationURL = await _localStorage.getURL();
    //
    // log(isLoggedIn.toString());
    // log(mainApplicationURL.toString());
    //
    if (isLoggedIn && mainApplicationURL != "") {
      //
      setState(() => isUserLoggedIn = true);
      navigateToWebViewPage(mainApplicationURL);
      //
    } else {
      setState(() => isUserLoggedIn = false);
    }
    setState(() => isProcessing = false);
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    //
    return WillPopScope(
      child: GestureDetector(
        child: Builder(builder: (context) {
          if (isProcessing == false && isUserLoggedIn == false) {
            return Scaffold(
              backgroundColor: mainBackgroundColor,
              body: Builder(builder: (context) {
                return const LoginPage();
              }),
            );
          } else {
            return Scaffold(
              backgroundColor: mainBackgroundColor,
              body: Column(
                children: [
                  Builder(builder: (context) {
                    return pulseProcressbar(screenSize, 0);
                  }),
                ],
              ),
            );
          }
        }),
        onTap: () {
          tapOnWholeScreen(context);
        },
      ),
      onWillPop: () {
        return _onBackPressed();
      },
    );
  }

//---------------------------------------------------------------------------------
  void tapOnWholeScreen(BuildContext context) {
    final FocusScopeNode currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }

  //---------------------------------------------------------------------------------
  Future<bool> _onBackPressed() async {
    return await buildDeleteDialogBox(
      context: context,
      titleText: 'Alert!',
      subTitleText: 'Are you sure to exit ?',
      successText: 'EXIT',
      cancelText: 'CANCEL',
      okFunction: () {
        Navigator.of(context).pop(true);
      },
      cancleFunction: () {
        Navigator.of(context).pop(false);
      },
    );
  }

  //---------------------------------------------------------------------------------
  void navigateToWebViewPage(String mainURL) {
    Navigator.of(context).pushAndRemoveUntil(
      PageTransition(
        child: Homepage(mainURL: mainURL),
        type: PageTransitionType.rightToLeft,
        duration: const Duration(milliseconds: 300),
      ),
      (Route<dynamic> route) => false,
    );
  }

  //---------------------------------------------------------------------------------
}
