import 'dart:convert';
import 'dart:developer';
import 'package:flutter_application_gallery/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const Url = 'https://technichal.prominaagency.com/api/auth/login';

class LoginApi {
  Future<UserDataModel> userLogin(String email, String password) async {
    late UserDataModel user;
    var response = await http.post(
      Uri.parse(Url),
      body: {
        'email': email,
        'password': password,
      },
    );
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      user = UserDataModel.fromJson(json);
    } else {
      print('the error eas in ${response.statusCode}');
    }
    var token = user.token;
    SharedPreferences pref = await SharedPreferences.getInstance();
    var mytoken = await pref.setString('Token', token);
    var name = user.userModel.name;
    log(name);

    // SharedPreferences prefName = await SharedPreferences.getInstance();
    // var UserName = await pref.setString('name', name);

    return user;
  }
}
