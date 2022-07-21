// To parse this JSON data, do
//
//     final sendOtpModal = sendOtpModalFromJson(jsonString);

import 'dart:convert';

SendOtpModal sendOtpModalFromJson(String str) =>
    SendOtpModal.fromJson(json.decode(str));

String sendOtpModalToJson(SendOtpModal data) => json.encode(data.toJson());

class SendOtpModal {
  SendOtpModal({
    required this.phone,
    required this.source,
  });

  Phone phone;
  String source;

  factory SendOtpModal.fromJson(Map<String, dynamic> json) => SendOtpModal(
        phone: Phone.fromJson(json["phone"]),
        source: json["source"],
      );

  Map<String, dynamic> toJson() => {
        "phone": phone.toJson(),
        "source": source,
      };
}

class Phone {
  Phone({
    required this.code,
    required this.num,
  });

  String code;
  String num;

  factory Phone.fromJson(Map<String, dynamic> json) => Phone(
        code: json["code"],
        num: json["num"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "num": num,
      };
}
