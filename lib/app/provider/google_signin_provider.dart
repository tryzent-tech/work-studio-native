// ignore_for_file: avoid_print

import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:work_studio/app/storage/local_storage.dart';

class GoggleSignInProvider extends ChangeNotifier {
  final googleSignin = GoogleSignIn();

  GoogleSignInAccount? _googleUserInformation;

  GoogleSignInAccount get user => _googleUserInformation!;

  Future<GoogleSignInAccount?> googleLogin() async {
    try {
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

      LocalStorage _localStorage = LocalStorage();
      _localStorage.setGoogleIdToken(googleAuth.idToken!);
      _localStorage.setGoogleAccessToken(googleAuth.accessToken!);

      log("Id Token -> " + googleAuth.idToken!);
      log("Access Token -> " + googleAuth.accessToken!);

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
