import 'package:google_sign_in/google_sign_in.dart';
import 'package:work_studio/app/helpers/login_data_modal.dart';

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
    email: userInfo["email"] ?? "",
    username: userInfo["email"] ?? "",
    firstname: userInfo["name"] ?? "",
    lastname: userInfo["name"] ?? "",
    avatar: userInfo["picture"]["data"]["url"] ?? "",
    otp: '',
    password: '',
  );
  return loginDataModal;
}
