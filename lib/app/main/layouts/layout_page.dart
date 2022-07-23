import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_studio/app/login/login.dart';
import 'package:work_studio/app/main/screens/homepage.dart';
import 'package:work_studio/app/partials/tools/delete_popup_box.dart';
import 'package:work_studio/app/storage/variables.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({
    Key? key,
  }) : super(key: key);
  @override
  _LayoutPageState createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  final Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();

  @override
  void initState() {
    // getLoggedInData();
    super.initState();
  }

  void getLoggedInData() async {
    final SharedPreferences _preferences = await _sharedPreferences;
    var isUserLoggedIn = _preferences.getBool("isLoggedIn");
    if (isUserLoggedIn == true) {
      Navigator.push(context, MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Homepage(mainURL: mainApplicationURL);
        },
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: GestureDetector(
        child: Scaffold(
          backgroundColor: const Color.fromARGB(1, 237, 242, 246),
          body: Builder(builder: (context) {
            return const LoginPage();
          }),
        ),
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
}
