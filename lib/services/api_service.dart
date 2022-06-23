import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:findmuseum_mobile/config.dart';
import 'package:findmuseum_mobile/models/museum_response_model.dart';
import 'package:findmuseum_mobile/models/login_request_model.dart';
import 'package:findmuseum_mobile/models/login_response_model.dart';
import 'package:findmuseum_mobile/models/city_response_model.dart';
import 'package:findmuseum_mobile/models/register_request_model.dart';
import 'package:findmuseum_mobile/models/register_response_model.dart';
import 'package:findmuseum_mobile/models/user_response_model.dart';
import 'package:findmuseum_mobile/services/shared_services.dart';

class APIService {
  static var client = http.Client();

  static Future<bool> login(LoginRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, Config.loginApi);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      //Shared Services
      await SharedServices.setLoginDetails(loginResponseJson(response.body));
      return true;
    } else {
      return false;
    }
  }

  static Future<RegisterResponseModel> register(
      RegisterRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, Config.registerApi);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    return registerResponseJson(response.body);
  }

  static Future<UserResponseModel> getUserProfile() async {
    var loginDetails = await SharedServices.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails!.token}'
    };

    var url = Uri.http(Config.apiURL, '/api/user/${loginDetails.data.id}');

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    //Shared Services
    return userResponseJson(response.body);
    // }
  }

  static Future<List<CityResponseModel>> getCities() async {
    var loginDetails = await SharedServices.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, '/api/city/');

    var response = await client.get(
      url,
      headers: requestHeaders,
    );
    print(response.body);

    //Shared Services
    return cityResponseJson(response.body);
    // }
  }
}
