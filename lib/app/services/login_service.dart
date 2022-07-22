// ignore_for_file: avoid_print, unnecessary_string_interpolations

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:work_studio/app/modals/otp_response_modal.dart';
import 'package:work_studio/app/modals/otp_verify_modal.dart';
import 'package:work_studio/app/modals/send_otp_modal.dart';

class LoginService {
  String developmentURL = 'https://network-auth.tryzent.com/auth/';
  String productionURL = 'https://auth.workstudio.io/auth/';

//---------------------------------------------------------------------------------
  Future<OtpResponseModal> getOTPFromServer(String mobileNumber) async {
    try {
      Phone phone = Phone(code: '+91', num: mobileNumber);
      SendOtpModal sendOtpModal = SendOtpModal(phone: phone, source: 'mobile');

      var body = json.encode(sendOtpModal.toJson());

      var response = await http.post(Uri.parse(developmentURL + "user"),
          headers: {"Content-Type": "application/json"}, body: body);

      if (response.statusCode == 200) {
        return otpResponseModalFromJson(response.body);
      } else {
        return returnErrorObject();
      }
    } catch (e) {
      return returnErrorObject();
    }
  }

//---------------------------------------------------------------------------------
  OtpResponseModal returnErrorObject() {
    Data data = Data(accessToken: '');
    OtpResponseModal otpResponseModal = OtpResponseModal(
        data: data,
        message: 'Something went wrong please try again !!!',
        status: '500');
    return otpResponseModal;
  }

//---------------------------------------------------------------------------------
  Future<VerifyOtpResponseModal> verifyOTPFromServer(
      String otp, String accessToken) async {
    try {
      Map _tempOTPPayload = {"otp": otp};

      var body = json.encode(_tempOTPPayload);
      var response = await http.post(Uri.parse(developmentURL + "verify-otp"),
          headers: {
            "Content-Type": "application/json",
            "access-token": accessToken
          },
          body: body);
      if (response.statusCode == 200) {
        return verifyOtpResponseModalFromJson(response.body);
      } else {
        return verifyOTPErrorObject();
      }
    } catch (e) {
      return verifyOTPErrorObject();
    }
  }

//---------------------------------------------------------------------------------
  VerifyOtpResponseModal verifyOTPErrorObject() {
    VerifyOTPData verifyOTPData =
        VerifyOTPData(accessToken: '', userId: '', username: '');
    VerifyOtpResponseModal verifyOtpResponseModal = VerifyOtpResponseModal(
        data: verifyOTPData,
        message: 'Something went wrong. Please try again !!!',
        status: '500');
    return verifyOtpResponseModal;
  }
  //---------------------------------------------------------------------------------
}
