// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_studio/app/provider/google_signin_provider.dart';

class GoogleFacebookSignInPage extends StatefulWidget {
  const GoogleFacebookSignInPage({
    Key? key,
  }) : super(key: key);
  @override
  _GoogleFacebookSignInPageState createState() =>
      _GoogleFacebookSignInPageState();
}

class _GoogleFacebookSignInPageState extends State<GoogleFacebookSignInPage> {
  bool isFacebookLoggedIn = false;
  Map _userDetails = {};

  final Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();

  @override
  void initState() {
    log(_userDetails.toString());

    super.initState();
  }

  void pageNavigation({required Widget childWidget}) {
    Navigator.push(
      context,
      PageTransition(
        child: childWidget,
        type: PageTransitionType.rightToLeft,
        duration: const Duration(milliseconds: 300),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: googleSigninAppbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: const Center(
                child: Image(
                  image: NetworkImage(
                    "https://media.kasperskydaily.com/wp-content/uploads/sites/36/2015/11/05092303/google-facebook-featured.png",
                  ),
                  height: 220,
                ),
              ),
            ),
            const SizedBox(height: 200),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 4),
              child: facebookLoginButton(context),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 4),
              child: googleLoginButton(context),
            ),
          ],
        ),
      ),
    );
  }

//---------------------------------------------------------------------------------
  Center googleLoginButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              FaIcon(
                FontAwesomeIcons.google,
                color: Colors.white,
              ),
              SizedBox(width: 10),
              Text(
                "Sign Up with Google",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        onPressed: () {
          final provider =
              Provider.of<GoggleSignInProvider>(context, listen: false);
          provider.googleLogin();
        },
        style: ElevatedButton.styleFrom(
          primary: const Color.fromARGB(255, 44, 122, 240),
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
        ),
      ),
    );
  }

  //---------------------------------------------------------------------------------
  Center facebookLoginButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              FaIcon(
                FontAwesomeIcons.facebook,
                color: Colors.white,
              ),
              SizedBox(width: 10),
              Text(
                "Sign Up with Facebook",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        onPressed: () {
          facebookLogin();
        },
        style: ElevatedButton.styleFrom(
          primary: const Color.fromARGB(255, 44, 122, 240),
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
        ),
      ),
    );
  }

//---------------------------------------------------------------------------------
  void facebookLogin() async {
    try {
      FacebookAuth.instance
          .login(permissions: ["public_profile", "email"]).then((value) {
        FacebookAuth.instance.getUserData().then((userInfo) {
          setState(() {
            isFacebookLoggedIn = true;
            _userDetails = userInfo;
          });
          setLoginStatus(_userDetails);
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void setLoginStatus(Map _userDetails) async {
    final SharedPreferences _preferences = await _sharedPreferences;
    _preferences.setBool("isLoggedIn", true);
    _preferences.setString("userName", _userDetails['name']);
    _preferences.setString("email", _userDetails['email']);
    _preferences.setString(
        "profileImage", _userDetails['picture']['data']['url']);
  }

//---------------------------------------------------------------------------------
  AppBar googleSigninAppbar() {
    return AppBar(
      title: const Text(
        "Google Signin/Signout",
        style: TextStyle(fontSize: 16),
      ),
      leading: const Icon(
        Icons.menu,
        color: Colors.white,
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            )),
      ],
      shadowColor: Colors.white,
      backgroundColor: Colors.indigo,
      foregroundColor: Colors.amber,
      toolbarHeight: 55,
      titleSpacing: 10,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
  //---------------------------------------------------------------------------------
}
