import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flushbar/flushbar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:misterija_mk/widgets/authentication.dart';
import 'package:misterija_mk/models/authentication.dart';
import 'package:misterija_mk/pages/register.dart';
import 'package:misterija_mk/pages/home.dart';

class LoginPage extends StatefulWidget {
  LoginPage(this.isLoginSuccessful);

  final bool isLoginSuccessful;

  State<StatefulWidget> createState() => _LoginPageState(isLoginSuccessful);
}

class _LoginPageState extends State<LoginPage> {
  _LoginPageState(this.isLoginSuccessful) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  final bool isLoginSuccessful;

  final _loginForm = GlobalKey<FormState>();

  final _usernameFocus = FocusNode();
  final _passwordFocus = FocusNode();

  Flushbar _loadingFlushbar;

  String _username;
  String _password;

  bool _isLoginDisabled = false;

  String validateUsername(String input) {
    return input.isEmpty ? 'Внесете го вашето корисничко име' : null;
  }

  String validatePassword(String input) {
    return input.isEmpty ? 'Внесете ја вашата лозинка' : null;
  }

  _setUsername(input) {
    setState(() {
      _username = input;
    });
  }

  _setPassword(input) {
    setState(() {
      _password = input;
    });
  }

  _setLoginDisabled(bool disabled) {
    setState(() {
      _isLoginDisabled = disabled;
    });
  }

  _onLogin() {
    if (_loginForm.currentState.validate()) {
      _loginForm.currentState.save();

      if (_loadingFlushbar == null) {
        _setLoginDisabled(true);

        _loadingFlushbar = Flushbar(
          message: 'Податоците се валидираат...',
          backgroundColor: Colors.white12,
          showProgressIndicator: true,
        );
        _loadingFlushbar.show(context);

        _doLogin().then((value) {
          _setLoginDisabled(false);
          _loadingFlushbar.dismiss();
          _loadingFlushbar = null;

          if (value) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          }
        });
      }
    }
  }

  Future<bool> _doLogin() async {
      var data = Login(_username, _password);
      var response = await http.post(
        Uri.encodeFull(Client.client + 'api/users/login/'),
        headers: {
          'Accept': 'application/json',
        },
        body: data.toJson(),
      );

    if (response.statusCode != 200) {
      Flushbar(
        messageText: Text(
          'Внесените информации не се валидни!',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        duration: Duration(
          seconds: 3,
        ),
        backgroundColor: Colors.white12,
      ).show(context);

      return false;
    }

    var jsonString = response.body;
    var jsonData = json.decode(jsonString);

    Token.fromJson(jsonData);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('token', Token.token);

    return true;
  }

  _onRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterPage(),
      ),
    );
  }

  _doAfterBuild(BuildContext context) {
    if (isLoginSuccessful) {
      Flushbar(
        messageText: Text(
          'Регистрацијата беше успешна. Најавете се веднаш!',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.white12,
        duration: Duration(
          seconds: 3,
        ),
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _doAfterBuild(context));

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Form(
          key: _loginForm,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
            children: <Widget>[
              SizedBox(
                height: 48.0,
              ),
              UsernameForm(
                validator: validateUsername,
                onSaved: _setUsername,
                focusNode: _usernameFocus,
                onFieldSubmitted: (input) {
                  _usernameFocus.unfocus();
                  FocusScope.of(context).requestFocus(_passwordFocus);
                },
              ),
              SizedBox(
                height: 8.0,
              ),
              PasswordForm(
                validator: validatePassword,
                onSaved: _setPassword,
                focusNode: _passwordFocus,
                onFieldSubmitted: (input) {
                  _passwordFocus.unfocus();
                },
              ),
              SizedBox(
                height: 24.0,
              ),
              LoginButton(
                onPressed: _isLoginDisabled ? null : _onLogin,
              ),
              MaybeRegisterButton(
                onPressed: _onRegister,
              ),
            ],
          ),
        ),
      ),
    );
  }
}