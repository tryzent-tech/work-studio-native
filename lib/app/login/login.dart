// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_studio/app/helpers/login_data_modal.dart';
import 'package:work_studio/app/helpers/login_object_helper.dart';
import 'package:work_studio/app/helpers/url_helper.dart';
import 'package:work_studio/app/main/screens/homepage.dart';
import 'package:work_studio/app/modals/otp_response_modal.dart';
import 'package:work_studio/app/modals/otp_verify_modal.dart';
import 'package:work_studio/app/partials/tools/native_action_button.dart';
import 'package:work_studio/app/partials/tools/please_wait_indicator.dart';
import 'package:work_studio/app/partials/tools/social_auth_button.dart';
import 'package:work_studio/app/partials/tools/text_form_field.dart';
import 'package:work_studio/app/provider/google_signin_provider.dart';
import 'package:work_studio/app/services/login_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();

  TextEditingController phoneNumber = TextEditingController();
  TextEditingController phoneOTP = TextEditingController();

  final _phoneNumberFormKey = GlobalKey<FormState>();
  final _phoneOTPFormKey = GlobalKey<FormState>();

  bool isPhoneNumberSent = false;
  bool isProcessSocialLogin = false;

  LoginService loginService = LoginService();

  String _tempAccessToken = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: Colors.white,
      body: GestureDetector(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Stack(
            children: [
              SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    loginpageBannerImage(),
                    const SizedBox(height: 8),
                    loginPageTitle(),
                    const SizedBox(height: 8),
                    loginpageSubtitle(),
                    Builder(builder: (context) {
                      if (!isPhoneNumberSent) {
                        return Column(
                          children: [
                            const SizedBox(height: 5),
                            mobileNumberFormField(),
                          ],
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    }),
                    Builder(builder: (context) {
                      if (isPhoneNumberSent) {
                        return Column(
                          children: [
                            const SizedBox(height: 5),
                            enterOTPFormField(),
                          ],
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    }),
                    Builder(builder: (context) {
                      if (!isPhoneNumberSent) {
                        return Column(
                          children: [
                            const SizedBox(height: 5),
                            nativeActionButton(
                                buttonText: 'Get OTP',
                                onPressed: () {
                                  sendNumberAndGetOTP();
                                }),
                          ],
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    }),
                    Builder(builder: (context) {
                      if (isPhoneNumberSent) {
                        return Column(
                          children: [
                            const SizedBox(height: 5),
                            nativeActionButton(
                              buttonText: 'Submit',
                              onPressed: () {
                                submitFormWithPhoneLogin();
                              },
                            ),
                          ],
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    }),
                    const SizedBox(height: 5),
                    socialAuthButton(
                        buttonColor: const Color.fromARGB(255, 38, 153, 247),
                        buttonIconPath: 'assets/icons/google-icon.png',
                        buttonText: 'Sign up with Google',
                        onPressed: () {
                          loginWithGoggle(context);
                        }),
                    const SizedBox(height: 5),
                    socialAuthButton(
                        buttonColor: const Color.fromARGB(255, 11, 109, 190),
                        buttonIconPath: 'assets/icons/fb-icon.png',
                        buttonText: 'Sign up with Facebook',
                        onPressed: () {
                          loginWithFacebook();
                        }),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              Builder(builder: (context) {
                if (isProcessSocialLogin) {
                  return customProgressIndicator(screenSize);
                } else {
                  return const SizedBox.shrink();
                }
              })
            ],
          ),
        ),
        onTap: () {
          tapOnWholeScreen(context);
        },
      ),
    );
  }

//---------------------------------------------------------------------------------
  Container mobileNumberFormField() {
    return Container(
      margin: const EdgeInsets.all(0),
      child: Form(
        key: _phoneNumberFormKey,
        child: Column(
          children: [
            randomTextField(
              hintText: 'Enter Mobile Number',
              keyboardType: TextInputType.phone,
              controller: phoneNumber,
              fieldType: 'phoneNumber',
              errorText: 'Please enter valid phone number',
            ),
          ],
        ),
      ),
    );
  }

//---------------------------------------------------------------------------------
  Container enterOTPFormField() {
    return Container(
      margin: const EdgeInsets.all(0),
      child: Form(
        key: _phoneOTPFormKey,
        child: Column(
          children: [
            randomTextField(
              hintText: 'Enter OTP',
              keyboardType: TextInputType.phone,
              controller: phoneOTP,
              fieldType: 'OTP',
              errorText: 'Please enter OTP',
            ),
          ],
        ),
      ),
    );
  }

//---------------------------------------------------------------------------------
  Center loginpageSubtitle() {
    return Center(
      child: Text(
        "Its Free",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.indigo.shade900,
        ),
      ),
    );
  }

  //---------------------------------------------------------------------------------
  Center loginPageTitle() {
    return Center(
      child: Text(
        "Create Your Network !",
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w900,
          color: Colors.indigo.shade900,
        ),
      ),
    );
  }

//---------------------------------------------------------------------------------
  Container loginpageBannerImage() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          _phoneNumberFormKey.currentState?.reset();
          _phoneOTPFormKey.currentState?.reset();
          tapOnWholeScreen(context);
        },
        child: const Center(
          child: Image(
            image: AssetImage(
              "assets/images/login-img.png",
            ),
            height: 220,
          ),
        ),
      ),
    );
  }

//---------------------------------------------------------------------------------
  void reloadCurrentPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => super.widget,
      ),
    );
  }

//---------------------------------------------------------------------------------
  AppBar buildAppBar() {
    return AppBar(
      title: Container(
        child: const Image(
          image: AssetImage(
            "assets/images/ws-long-logo.png",
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20),
      ),
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      elevation: 20,
      centerTitle: true,
      shadowColor: Colors.transparent,
      toolbarHeight: 60,
    );
  }

  //---------------------------------------------------------------------------------
  void tapOnWholeScreen(BuildContext context) {
    final FocusScopeNode currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
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
            message: responseModal.message);
      }
    }
  }

  //---------------------------------------------------------------------------------
  void submitFormWithPhoneLogin() async {
    if (_phoneOTPFormKey.currentState!.validate() &&
        _phoneOTPFormKey.currentState != null &&
        _tempAccessToken != "") {
      //

      VerifyOtpResponseModal verifyOtpResponseModal = await loginService
          .verifyOTPFromServer(phoneOTP.text, _tempAccessToken);

      setState(() => isPhoneNumberSent = false);
      _phoneNumberFormKey.currentState?.reset();
      _phoneOTPFormKey.currentState?.reset();
      tapOnWholeScreen(context);

      if (verifyOtpResponseModal.status == "success") {
        //
        LoginDataModal loginDataModal = createMobileLoginPayload();

        Map mappedUsersDetails = loginDataModal.toMap();
        String rawJson = jsonEncode(mappedUsersDetails);
        List<int> bytes = utf8.encode(rawJson);
        final base64String = base64.encode(bytes);

        String mainURL = getDevelopmentURL(
            base64String, "not-found", verifyOtpResponseModal.data.accessToken);
        navigateToWebViewPage(mainURL);
      } else {
        showSnackBar(
            backgroundColor: const Color.fromARGB(255, 239, 40, 26),
            message: 'Something went wrong. Please try again !!!');
      }
    } else {
      showSnackBar(
          backgroundColor: const Color.fromARGB(255, 239, 40, 26),
          message: 'Something went wrong. Please try again !!!');
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
    final SharedPreferences prefs = await _sharedPreferences;
    //
    String? idToken = prefs.getString('idToken') ?? "";
    // String? accessToken = prefs.getString('accessToken') ?? "";
    //
    LoginDataModal loginDataModal = createGoogleLoginPayload(userInfo);

    Map mappedUsersDetails = loginDataModal.toMap();
    String rawJson = jsonEncode(mappedUsersDetails);
    List<int> bytes = utf8.encode(rawJson);
    final base64String = base64.encode(bytes);

    String mainURL = getDevelopmentURL(base64String, idToken, "not-found");

    // log(mainURL);

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

          // log(mainURL);

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
  void showSnackBar({required String message, required Color backgroundColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(message)),
        backgroundColor: backgroundColor,
      ),
    );
  }

  //---------------------------------------------------------------------------------
}
