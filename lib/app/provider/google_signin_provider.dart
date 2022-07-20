// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoggleSignInProvider extends ChangeNotifier {
  final googleSignin = GoogleSignIn();

  GoogleSignInAccount? _googleUserInformation;

  GoogleSignInAccount get user => _googleUserInformation!;

  Future<GoogleSignInAccount?> googleLogin() async {
    try {
      final Future<SharedPreferences> _sharedPreferences =
          SharedPreferences.getInstance();

      final SharedPreferences _preferences = await _sharedPreferences;

      final googleUserInfo = await googleSignin.signIn();

      if (googleUserInfo != null) {
        _googleUserInformation = googleUserInfo;
      }

      final googleAuth = await googleUserInfo!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      _preferences.setString("idToken", googleAuth.accessToken!);
      _preferences.setString("accessToken", googleAuth.idToken!);

      notifyListeners();

      return googleUserInfo;
      //
    } on Exception catch (e) {
      //
      notifyListeners();
      //
      print(e.toString());
      return _googleUserInformation;
    }
  }

  Future googleLogout() async {
    await googleSignin.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
