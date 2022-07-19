import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:work_studio/app/main/screens/user_profile.dart';
import 'package:work_studio/app/partials/tools/delete_popup_box.dart';
import 'package:work_studio/app/signin_signout/google_facebook_signin.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({
    Key? key,
  }) : super(key: key);
  @override
  _LayoutPageState createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: GestureDetector(
        child: Scaffold(
          body: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  // return const Homepage();
                  return const UserProfile();
                } else if (snapshot.hasError) {
                  return const Center(child: Text("Something went wrong!"));
                } else {
                  // return const GoogleSignInPage();
                  return const GoogleFacebookSignInPage();
                }
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
