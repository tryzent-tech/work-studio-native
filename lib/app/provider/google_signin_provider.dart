import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoggleSignInProvider extends ChangeNotifier {
  final googleSignin = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    try {
      final googleUser = await googleSignin.signIn();
      if (googleUser != null) {
        _user = googleUser;
      }

      final googleAuth = await googleUser!.authentication;

      log(googleAuth.accessToken!);
      log(googleAuth.idToken!);

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }

    notifyListeners();
  }

  Future googleLogout() async {
    await googleSignin.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
