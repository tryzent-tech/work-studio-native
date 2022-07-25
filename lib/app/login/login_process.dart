// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:work_studio/app/helpers/login_data_modal.dart';
import 'package:work_studio/app/helpers/login_object_helper.dart';
import 'package:work_studio/app/helpers/url_helper.dart';
import 'package:work_studio/app/main/screens/homepage.dart';
import 'package:work_studio/app/modals/otp_response_modal.dart';
import 'package:work_studio/app/partials/appbar/main_appbar.dart';
import 'package:work_studio/app/partials/tools/please_wait_indicator.dart';
import 'package:work_studio/app/partials/tools/snackbar.dart';
import 'package:work_studio/app/provider/google_signin_provider.dart';
import 'package:work_studio/app/services/login_service.dart';
import 'package:work_studio/app/storage/local_storage.dart';

class LoginProcess extends StatefulWidget {
  const LoginProcess({
    Key? key,
  }) : super(key: key);
  @override
  _LoginProcessState createState() => _LoginProcessState();
}

class _LoginProcessState extends State<LoginProcess> {
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController phoneOTP = TextEditingController();

  final _phoneNumberFormKey = GlobalKey<FormState>();
  final _phoneOTPFormKey = GlobalKey<FormState>();

  bool isPhoneNumberSent = false;
  bool isProcessSocialLogin = false;

  LoginService loginService = LoginService();
  final LocalStorage _localStorage = LocalStorage();

  String _tempAccessToken = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: buildAppBar2(),
      backgroundColor: Colors.white,
      body: Builder(builder: (context) {
        if (isProcessSocialLogin) {
          return pulseProcressbar(screenSize, 100);
        } else {
          return const SizedBox.shrink();
        }
      }),
    );
  }

  //---------------------------------------------------------------------------------
  void sendNumberAndGetOTP() async {
    if (_phoneNumberFormKey.currentState!.validate() &&
        _phoneNumberFormKey.currentState != null) {
//
      OtpResponseModal responseModal =
          await loginService.getOTPFromServer(phoneNumber.text);

      if (responseModal.status == "success") {
        setState(() => isPhoneNumberSent = true);
        setState(() {
          _tempAccessToken = responseModal.data.accessToken;
        });
      } else {
        setState(() => isPhoneNumberSent = false);
        showSnackBar(
            backgroundColor: const Color.fromARGB(255, 239, 40, 26),
            message: responseModal.message,
            context: context);
      }
    }
  }

  //---------------------------------------------------------------------------------

  void loginWithGoggle(BuildContext context) async {
    setState(() => isProcessSocialLogin = true);
    final provider = Provider.of<GoggleSignInProvider>(context, listen: false);
    GoogleSignInAccount? userInfo = await provider.googleLogin();
    setState(() => isProcessSocialLogin = false);
    googleRedirectPage(userInfo);
  }

//---------------------------------------------------------------------------------
  googleRedirectPage(GoogleSignInAccount? userInfo) async {
    //
    LoginDataModal loginDataModal = createGoogleLoginPayload(userInfo);

    Map mappedUsersDetails = loginDataModal.toMap();
    String rawJson = jsonEncode(mappedUsersDetails);
    List<int> bytes = utf8.encode(rawJson);
    final base64String = base64.encode(bytes);

    String accessToken = await _localStorage.getGoogleAccessToken();
    String mainURL = getDevelopmentURL(base64String, accessToken, "not-found");

    _localStorage.setIsLoggedIn(true);
    _localStorage.setURL(mainURL);

    navigateToWebViewPage(mainURL);
  }

//---------------------------------------------------------------------------------
  void loginWithFacebook() async {
    try {
      setState(() {
        isProcessSocialLogin = true;
      });
      FacebookAuth.instance
          .login(permissions: ["public_profile", "email"]).then((value) {
        //
        FacebookAuth.instance.getUserData().then((userInfo) async {
          AccessToken? accessToken = await FacebookAuth.instance.accessToken;
          LoginDataModal loginDataModal = createFacebookLoginPayload(userInfo);

          Map mappedUsersDetails = loginDataModal.toMap();

          log(mappedUsersDetails.toString());

          String rawJson = jsonEncode(mappedUsersDetails);
          List<int> bytes = utf8.encode(rawJson);
          final base64String = base64.encode(bytes);

          String mainURL =
              getDevelopmentURL(base64String, "not-found", accessToken!.token);

          _localStorage.setIsLoggedIn(true);
          _localStorage.setURL(mainURL);

          setState(() {
            isProcessSocialLogin = false;
          });

          navigateToWebViewPage(mainURL);
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }

//---------------------------------------------------------------------------------
  void navigateToWebViewPage(String mainURL) {
    Navigator.push(
      context,
      PageTransition(
        child: Homepage(mainURL: mainURL),
        type: PageTransitionType.rightToLeft,
        duration: const Duration(milliseconds: 300),
      ),
    );
  }

  //---------------------------------------------------------------------------------
}
