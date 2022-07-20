import 'package:flutter/material.dart';
import 'package:work_studio/app/partials/tools/native_action_button.dart';
import 'package:work_studio/app/partials/tools/social_auth_button.dart';
import 'package:work_studio/app/partials/tools/text_form_field.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: Colors.white,
      body: GestureDetector(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SafeArea(
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
                          onPressed: () {},
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
                    onPressed: () {}),
                const SizedBox(height: 5),
                socialAuthButton(
                    buttonColor: const Color.fromARGB(255, 11, 109, 190),
                    buttonIconPath: 'assets/icons/fb-icon.png',
                    buttonText: 'Sign up with Facebook',
                    onPressed: () {}),
                const SizedBox(height: 20),
              ],
            ),
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
              errorText: 'Please enter phone number',
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
}
