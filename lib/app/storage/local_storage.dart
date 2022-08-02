import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  final Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();

  setIsLoggedIn(bool value) async {
    final SharedPreferences _preferences = await _sharedPreferences;
    _preferences.setBool("isLoggedIn", value);
  }

  Future<bool> getIsLoggedIn() async {
    final SharedPreferences _preferences = await _sharedPreferences;
    return _preferences.getBool("isLoggedIn") ?? false;
  }

  setURL(String url) async {
    final SharedPreferences _preferences = await _sharedPreferences;
    _preferences.setString("applicationURL", url);
  }

  Future<String> getURL() async {
    final SharedPreferences prefs = await _sharedPreferences;
    String? applicationURL = prefs.getString('applicationURL') ?? "";
    return applicationURL;
  }

  setGoogleIdToken(String token) async {
    final SharedPreferences _preferences = await _sharedPreferences;
    _preferences.setString("googleIdToken", token);
  }

  Future<String> getGoogleIdToken() async {
    final SharedPreferences prefs = await _sharedPreferences;
    String? token = prefs.getString('googleIdToken') ?? "";
    return token;
  }

  setGoogleAccessToken(String accessToken) async {
    final SharedPreferences _preferences = await _sharedPreferences;
    _preferences.setString("googleAccessToken", accessToken);
  }

  Future<String> getGoogleAccessToken() async {
    final SharedPreferences prefs = await _sharedPreferences;
    String? accessToken = prefs.getString('googleAccessToken') ?? "";
    return accessToken;
  }

  setFacebookAccessToken(String accessToken) async {
    final SharedPreferences _preferences = await _sharedPreferences;
    _preferences.setString("facebookAccessToken", accessToken);
  }

  Future<String> getFacebookAccessToken() async {
    final SharedPreferences prefs = await _sharedPreferences;
    String? accessToken = prefs.getString('facebookAccessToken') ?? "";
    return accessToken;
  }

  setCurrentPageURL(String url) async {
    final SharedPreferences _preferences = await _sharedPreferences;
    _preferences.setString("currentPageURL", url);
  }

  Future<String> getCurrentPageURL() async {
    final SharedPreferences prefs = await _sharedPreferences;
    String? currentPageURL = prefs.getString('currentPageURL') ?? "";
    return currentPageURL;
  }
}
