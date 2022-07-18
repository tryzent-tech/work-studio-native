import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:work_studio/app/provider/google_signin_provider.dart';

class GoogleSignInPage extends StatefulWidget {
  const GoogleSignInPage({
    Key? key,
  }) : super(key: key);
  @override
  _GoogleSignInPageState createState() => _GoogleSignInPageState();
}

class _GoogleSignInPageState extends State<GoogleSignInPage> {
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
                    "https://lh3.googleusercontent.com/_ctcOQs9VPB30P4l7bhVMTJz3MCOSVuZUZXW-xSX7237nvUw0VDx7uGSD-CMgVpYwubYzreK1cUXMjNxVyWhokkWwQ6Oz1RK9Fzh4kli5NQw3C9WgA=w600-l80-sg-rp",
                  ),
                  height: 220,
                ),
              ),
            ),
            const SizedBox(height: 200),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Center(
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
                    final provider = Provider.of<GoggleSignInProvider>(context,
                        listen: false);
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
              ),
            ),
          ],
        ),
      ),
    );
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
