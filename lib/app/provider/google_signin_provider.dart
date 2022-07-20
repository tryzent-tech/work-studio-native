import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoggleSignInProvider extends ChangeNotifier {
  final googleSignin = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future<Object> googleLogin() async {
    final Future<SharedPreferences> _sharedPreferences =
        SharedPreferences.getInstance();

    try {
      final SharedPreferences _preferences = await _sharedPreferences;

      final googleUser = await googleSignin.signIn();
      if (googleUser != null) {
        _user = googleUser;
      }

      final googleAuth = await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      Object userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      _preferences.setString("idToken", googleAuth.accessToken!);
      _preferences.setString("accessToken", googleAuth.idToken!);
      return googleUser;
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return {};
    }

    notifyListeners();
  }

  Future googleLogout() async {
    await googleSignin.disconnect();
    FirebaseAuth.instance.signOut();
  }
}
