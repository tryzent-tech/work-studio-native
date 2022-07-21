import 'dart:convert';

class LoginDataModal {
  final String id;
  final String username;
  final String email;
  final String firstname;
  final String lastname;
  final String source;
  final String avatar;
  final String otp;
  final String password;

  LoginDataModal({
    required this.id,
    required this.username,
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.source,
    required this.avatar,
    required this.otp,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'firstname': firstname,
      'lastname': lastname,
      'source': source,
      'avatar': avatar,
      'otp': otp,
      'password': password,
    };
  }

  factory LoginDataModal.fromMap(Map<String, dynamic> map) {
    return LoginDataModal(
      id: map['id'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      firstname: map['firstname'] ?? '',
      lastname: map['lastname'] ?? '',
      source: map['source'] ?? '',
      avatar: map['avatar'] ?? '',
      otp: map['otp'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginDataModal.fromJson(String source) =>
      LoginDataModal.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LoginDataModal(id: $id, username: $username, email: $email, firstname: $firstname, lastname: $lastname, source: $source, avatar: $avatar, otp: $otp, password: $password)';
  }
}
