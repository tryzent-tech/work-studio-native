import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../provider/google_signin_provider.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({
    Key? key,
  }) : super(key: key);
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    getAccessToken();
  }

  getAccessToken() {
    _sharedPreferences.then((SharedPreferences prefs) {
      String? idToken = prefs.getString('idToken') ?? "";
      log(idToken);
    });
    _sharedPreferences.then((SharedPreferences prefs) {
      String? accessToken = prefs.getString('accessToken') ?? "";
      log(accessToken);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 100),
              Container(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image(
                          image: NetworkImage(
                            currentUser.photoURL!,
                          ),
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return const Text('Image not found.');
                          }),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Center(
                  child: Text(
                    "Name : " + currentUser.displayName!,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Center(
                  child: Text(
                    "Email : " + currentUser.email!,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//---------------------------------------------------------------------------------
  AppBar buildAppBar() {
    return AppBar(
      title: const Text("Your Profile"),
      backgroundColor: Colors.indigo,
      elevation: 0,
      shadowColor: Colors.transparent,
      toolbarHeight: 55,
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.arrow_back_outlined,
          color: Colors.white,
        ),
      ),
      actions: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: IconButton(
            onPressed: () {
              final provider =
                  Provider.of<GoggleSignInProvider>(context, listen: false);
              provider.googleLogout();
            },
            iconSize: 22,
            icon: const Icon(
              FontAwesomeIcons.powerOff,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
