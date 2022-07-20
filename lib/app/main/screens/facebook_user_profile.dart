// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_studio/app/main/screens/home.dart';

import '../../provider/google_signin_provider.dart';

class FacebookUserProfile extends StatefulWidget {
  const FacebookUserProfile({
    Key? key,
  }) : super(key: key);
  @override
  _FacebookUserProfileState createState() => _FacebookUserProfileState();
}

class _FacebookUserProfileState extends State<FacebookUserProfile> {
  final Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();

  String userName = "";
  String email = "";
  String profileURL = "";

  @override
  void initState() {
    super.initState();
    getUsersDetails();
  }

  getUsersDetails() {
    _sharedPreferences.then((SharedPreferences prefs) {
      setState(() {
        userName = prefs.getString('userName') ?? "";
        email = prefs.getString('email') ?? "";
        profileURL = prefs.getString('profileImage') ?? "";
      });
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
                            profileURL != ""
                                ? profileURL
                                : "https://qph.cf2.quoracdn.net/main-thumb-1278318002-200-ydzfegagslcexelzgsnplcklfkienzfr.jpeg",
                          ),
                          fit: BoxFit.contain,
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
                    "Name : " + userName,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Center(
                  child: Text(
                    "Email : " + email,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Center(
                    child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 4, 68, 120),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28, vertical: 14)),
                  child: const Text("Go to Work Studio"),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute<void>(
                      builder: (BuildContext context) {
                        return const Homepage();
                      },
                    ));
                  },
                )),
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
      title: const Text("Facebook Profile"),
      backgroundColor: Colors.indigo,
      elevation: 0,
      shadowColor: Colors.transparent,
      toolbarHeight: 55,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        splashRadius: 20,
        icon: const Icon(
          Icons.arrow_back_outlined,
          color: Colors.white,
        ),
      ),
      actions: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: IconButton(
            splashRadius: 20,
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
