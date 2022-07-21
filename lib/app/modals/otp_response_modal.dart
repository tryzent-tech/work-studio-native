// To parse this JSON data, do
//
//     final otpResponseModal = otpResponseModalFromJson(jsonString);

import 'dart:convert';

OtpResponseModal otpResponseModalFromJson(String str) =>
    OtpResponseModal.fromJson(json.decode(str));

String otpResponseModalToJson(OtpResponseModal data) =>
    json.encode(data.toJson());

class OtpResponseModal {
  OtpResponseModal({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  Data data;

  factory OtpResponseModal.fromJson(Map<String, dynamic> json) =>
      OtpResponseModal(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.accessToken,
  });

  String accessToken;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        accessToken: json["access-token"],
      );

  Map<String, dynamic> toJson() => {
        "access-token": accessToken,
      };
}
