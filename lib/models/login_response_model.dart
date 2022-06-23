import 'dart:convert';

LoginResponseModel loginResponseJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  LoginResponseModel({
    required this.code,
    required this.message,
    required this.data,
    required this.token,
  });
  late final int code;
  late final String message;
  late final Data data;
  late final String token;

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = Data.fromJson(json['data']);
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['message'] = message;
    _data['data'] = data.toJson();
    _data['token'] = token;
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    this.createdAt,
    this.updatedAt,
  });
  late final int id;
  late final String name;
  late final String username;
  late final String email;
  late final String? createdAt;
  late final String? updatedAt;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['username'] = username;
    _data['email'] = email;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}
