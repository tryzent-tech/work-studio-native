import 'dart:convert';

VerifyOtpResponseModal verifyOtpResponseModalFromJson(String str) =>
    VerifyOtpResponseModal.fromJson(json.decode(str));

String verifyOtpResponseModalToJson(VerifyOtpResponseModal data) =>
    json.encode(data.toJson());

class VerifyOtpResponseModal {
  VerifyOtpResponseModal({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  VerifyOTPData data;

  factory VerifyOtpResponseModal.fromJson(Map<String, dynamic> json) =>
      VerifyOtpResponseModal(
        status: json["status"],
        message: json["message"],
        data: VerifyOTPData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class VerifyOTPData {
  VerifyOTPData({
    required this.userId,
    required this.username,
    required this.accessToken,
  });

  String userId;
  String username;
  String accessToken;

  factory VerifyOTPData.fromJson(Map<String, dynamic> json) => VerifyOTPData(
        userId: json["userId"],
        username: json["username"],
        accessToken: json["access-token"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "username": username,
        "access-token": accessToken,
      };
}
