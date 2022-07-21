// ignore_for_file: avoid_print, unnecessary_string_interpolations

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:work_studio/app/modals/otp_response_modal.dart';
import 'package:work_studio/app/modals/send_otp_modal.dart';

class LoginService {
  String developmentURL = 'https://network-auth.tryzent.com/auth/user';
  String productionURL = 'https://auth.workstudio.io/auth/user';

//---------------------------------------------------------------------------------
  Future<OtpResponseModal> getOTP(String mobileNumber) async {
    Phone phone = Phone(code: '+91', num: mobileNumber);
    SendOtpModal sendOtpModal = SendOtpModal(phone: phone, source: 'mobile');

    var body = json.encode(sendOtpModal.toJson());

    var response = await http.post(Uri.parse(developmentURL),
        headers: {"Content-Type": "application/json"}, body: body);

    if (response.statusCode == 200) {
      return otpResponseModalFromJson(response.body);
    } else {
      Data data = Data(accessToken: '');
      OtpResponseModal otpResponseModal = OtpResponseModal(
          data: data, message: 'Something went wrong!', status: '500');
      return otpResponseModal;
    }
  }
}
