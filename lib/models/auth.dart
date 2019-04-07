import 'package:json_annotation/json_annotation.dart';

import 'package:shared_preferences/shared_preferences.dart';

part 'auth.g.dart';

class Client {
  static String client = 'http://192.168.1.124:80/';
}

@JsonSerializable()
class Login extends Object {
  final String username;
  final String password;

  Login(this.username, this.password);

  factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);

  Map<String, dynamic> toJson() => _$LoginToJson(this);
}

@JsonSerializable()
class Register extends Object {
  final String username;
  final String email;
  final String password;

  Register(this.username, this.email, this.password);

  factory Register.fromJson(Map<String, dynamic> json) =>
      _$RegisterFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterToJson(this);
}

class Token {
  static String token;

  static void fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  static Map<String, dynamic> toJson() {
    return {
      'token': token,
    };
  }

  static bool isAuthenticated() {
    return token != null;
  }

  static Future<bool> doLogout() async{
    if (token == null) {
      return false;
    }

    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('token', null);
    token = null;

    return true;
  }

  static String toHeader() {
    return 'Token ' + token;
  }
}