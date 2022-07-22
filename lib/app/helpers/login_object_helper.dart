import 'package:google_sign_in/google_sign_in.dart';
import 'package:work_studio/app/helpers/login_data_modal.dart';

LoginDataModal createMobileLoginPayload(String otp) {
  LoginDataModal loginDataModal = LoginDataModal(
    source: "MOBILE",
    id: "",
    email: "",
    username: "",
    avatar: "",
    firstname: "",
    lastname: "",
    otp: otp,
    password: "",
  );
  return loginDataModal;
}

LoginDataModal createGoogleLoginPayload(GoogleSignInAccount? userInfo) {
  LoginDataModal loginDataModal = LoginDataModal(
    source: "GOOGLE",
    id: userInfo!.id,
    email: userInfo.email,
    username: userInfo.email,
    avatar: userInfo.photoUrl.toString(),
    firstname: userInfo.displayName.toString(),
    lastname: userInfo.displayName.toString(),
    otp: '',
    password: '',
  );
  return loginDataModal;
}

LoginDataModal createFacebookLoginPayload(Map<String, dynamic> userInfo) {
  LoginDataModal loginDataModal = LoginDataModal(
    source: "FACEBOOK",
    id: userInfo["id"],
    email: userInfo["email"] ?? "unknown",
    username: userInfo["email"] ?? "unknown",
    firstname: userInfo["name"] ?? "unknown",
    lastname: userInfo["name"] ?? "unknown",
    avatar: userInfo["picture"]["data"]["url"] ?? "unknown",
    otp: '',
    password: '',
  );
  return loginDataModal;
}
