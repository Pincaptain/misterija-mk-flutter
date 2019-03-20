import 'package:flutter/material.dart';

import 'package:flushbar/flushbar.dart';
import 'package:http/http.dart' as http;

import 'package:misterija_mk/widgets/authentication.dart';
import 'package:misterija_mk/models/authentication.dart';
import 'package:misterija_mk/pages/login.dart';

class RegisterPage extends StatefulWidget {
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerForm = GlobalKey<FormState>();

  final _usernameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  Flushbar _loadingFlushbar;

  String _username;
  String _email;
  String _password;

  bool _isRegisterDisabled = false;

  String validateUsername(input) {
    return input.isEmpty ? 'Внесете го вашето корисничко име' : null;
  }

  String validateEmail(input) {
    RegExp regExp = new RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return regExp.hasMatch(input) ? null : 'Внесената е-пошта не е валидна';
  }

  String validatePassword(input) {
    return input.isEmpty ? 'Внесете ја вашата лозинка' : null;
  }

  _setUsername(input) {
    setState(() {
      _username = input;
    });
  }

  _setEmail(input) {
    setState(() {
      _email = input;
    });
  }

  _setPassword(input) {
    setState(() {
      _password = input;
    });
  }

  _setRegisterDisabled(bool disable) {
    setState(() {
      _isRegisterDisabled = disable;
    });
  }

  _onRegister() {
    if (_registerForm.currentState.validate()) {
      _registerForm.currentState.save();

      if (_loadingFlushbar == null) {
        _setRegisterDisabled(true);

        _loadingFlushbar = Flushbar(
          message: 'Податоците се валидираат',
          backgroundColor: Colors.white12,
          showProgressIndicator: true,
        );
        _loadingFlushbar.show(context);

        _doRegister().then((value) {
          _setRegisterDisabled(false);
          _loadingFlushbar.dismiss();
          _loadingFlushbar = null;

          if (value) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(true),
              ),
            );
          }
        });
      }
    }
  }

  Future<bool> _doRegister() async {
    var data = Register(_username, _email, _password);
    var response = await http.post(
      Uri.encodeFull(Client.client + 'api/users/register/'),
      headers: {
        'Accept': 'application/json',
      },
      body: data.toJson(),
    );

    if (response.statusCode != 201) {
      Flushbar(
        messageText: Text(
          'Внесените информации не се валидни или веќе постои корисник со тоа име.',
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

    return true;
  }

  _onLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(false),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Form(
          key: _registerForm,
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
                  FocusScope.of(context).requestFocus(_emailFocus);
                },
              ),
              SizedBox(
                height: 8.0,
              ),
              EmailForm(
                validator: validateEmail,
                onSaved: _setEmail,
                focusNode: _emailFocus,
                onFieldSubmitted: (input) {
                  _emailFocus.unfocus();
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
              RegisterButton(
                onPressed: _isRegisterDisabled ? null : _onRegister,
              ),
              MaybeLoginButton(
                onPressed: _onLogin,
              ),
            ],
          ),
        ),
      ),
    );
  }
}