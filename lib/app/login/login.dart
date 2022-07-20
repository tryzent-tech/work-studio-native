// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:provider/provider.dart';
import 'package:work_studio/app/partials/tools/native_action_button.dart';
import 'package:work_studio/app/partials/tools/social_auth_button.dart';
import 'package:work_studio/app/partials/tools/text_form_field.dart';
import 'package:work_studio/app/provider/google_signin_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController phoneOTP = TextEditingController();

  final _phoneNumberFormKey = GlobalKey<FormState>();
  final _phoneOTPFormKey = GlobalKey<FormState>();

  bool isPhoneNumberSent = false;
  bool isProcessSocialLogin = false;

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
                                  getOTP();
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
                  return SafeArea(
                    child: Column(
                      children: [
                        SizedBox(height: screenSize.height / 2 - 160),
                        const Center(
                            child: CircularProgressIndicator(
                          color: Color.fromARGB(255, 104, 60, 226),
                          strokeWidth: 5,
                        )),
                      ],
                    ),
                  );
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

  void loginWithGoggle(BuildContext context) async {
    setState(() {
      isProcessSocialLogin = true;
    });
    final provider = Provider.of<GoggleSignInProvider>(context, listen: false);
    Object googleLogin = await provider.googleLogin();
    print(googleLogin.toString());
    setState(() {
      isProcessSocialLogin = false;
    });
  }

//---------------------------------------------------------------------------------
  void loginWithFacebook() async {
    try {
      setState(() {
        isProcessSocialLogin = true;
      });
      FacebookAuth.instance
          .login(permissions: ["public_profile", "email"]).then((value) {
        FacebookAuth.instance.getUserData().then((userInfo) {
          print(userInfo.toString());
          setState(() {
            isProcessSocialLogin = false;
          });
        });
      });
    } catch (e) {
      print(e.toString());
    }
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
      child: const Center(
        child: Image(
          image: AssetImage(
            "assets/images/login-img.png",
          ),
          height: 220,
        ),
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
  void getOTP() {
    if (_phoneNumberFormKey.currentState!.validate() &&
        _phoneNumberFormKey.currentState != null) {
      setState(() {
        isPhoneNumberSent = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form submit successfully.')),
      );
    }
  }

  //---------------------------------------------------------------------------------
  void submitFormWithPhoneLogin() {
    if (_phoneOTPFormKey.currentState!.validate() &&
        _phoneOTPFormKey.currentState != null) {
      setState(() {
        isPhoneNumberSent = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form submit successfully.')),
      );
    }
  }
  //---------------------------------------------------------------------------------
}