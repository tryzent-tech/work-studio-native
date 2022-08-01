import 'package:work_studio/app/storage/variables.dart';

String getDevelopmentURL(
    String base64String, String idToken, String accessToken) {
  String mainURL =
      "https://network.tryzent.com/native-sdk-login?nativeuserinfo=" +
          base64String +
          "&idToken=" +
          idToken +
          "&accessToken=" +
          accessToken;
  return mainURL;
}

String getProductionURL(
    String base64String, String idToken, String accessToken) {
  String mainURL = "https://workstudio.io/native-sdk-login?nativeuserinfo=" +
      base64String +
      "&idToken=" +
      idToken +
      "&accessToken=" +
      accessToken;
  return mainURL;
}

String getMainApplicationURL(
    String base64String, String idToken, String accessToken) {
  String mainURL = mainApplicationURL +
      "native-sdk-login?nativeuserinfo=" +
      base64String +
      "&idToken=" +
      idToken +
      "&accessToken=" +
      accessToken;
  return mainURL;
}
