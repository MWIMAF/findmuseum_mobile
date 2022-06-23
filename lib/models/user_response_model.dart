import 'dart:convert';

UserResponseModel userResponseJson(String str) =>
    UserResponseModel.fromJson(jsonDecode(str));

class UserResponseModel {
  late final int id;
  late final String name;
  late final String username;
  late final String email;

  UserResponseModel(
      {required this.id,
      required this.name,
      required this.username,
      required this.email,}
    );

  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    return UserResponseModel(
        id: json['id'],
        name: json['name'],
        username: json['username'],
        email: json['email'],);
  }
}
