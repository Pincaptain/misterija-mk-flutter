import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flushbar/flushbar.dart';

import 'package:misterija_mk/blocs/login_bloc.dart';
import 'register.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  LoginPage();

  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Business logic component for login
  final _loginBloc = LoginBloc();

  _LoginPageState() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  @mustCallSuper
  @override
  initState() {
    super.initState();
    _onLoginResult();
  }

  _onLoginResult() {
    /*
     * Listen for login result
     * If login result successful redirect to home page
     * If login result failed show flushbar with error message 
     */
    _loginBloc.auth.listen((result) {
      if (result == LoginResult.UnexpectedError) {
        Flushbar(
          message: 'Дојде до неочекуван проблем. Обидете се повторно.',
          duration: Duration(seconds: 3),
        ).show(context);
      } else if (result == LoginResult.InvalidCredentials) {
        Flushbar(
          message: 'Внесените податоци се невалидни. Обидете се повторно.',
          duration: Duration(seconds: 3),
        ).show(context);
      } else {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomePage()));
      }
    });
  }

  _onRegister() {
    /*
    * Redirect to register page
    */
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => RegisterPage()));
  }

  @override
  Widget build(BuildContext context) {
    /*
     * Build login page view 
     */
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(
            horizontal: 24.0,
          ),
          children: <Widget>[
            SizedBox(
              height: 48.0,
            ),
            StreamBuilder<String>(
              stream: _loginBloc.username,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return TextField(
                  onChanged: _loginBloc.onUsernameChanged,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Корисничко име',
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    errorText: snapshot.error,
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: 8.0,
            ),
            StreamBuilder<String>(
              stream: _loginBloc.password,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return TextField(
                  onChanged: _loginBloc.onPasswordChanged,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Лозинка',
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    errorText: snapshot.error,
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: 24.0,
            ),
            StreamBuilder<bool>(
              stream: _loginBloc.validate,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return RaisedButton(
                  onPressed: snapshot.data != null ? _loginBloc.onAuth : null,
                  color: Colors.white12,
                  elevation: 0.0,
                  highlightElevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  child: Text(
                    'Најави се',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                );
              },
            ),
            RaisedButton(
              onPressed: _onRegister,
              color: Colors.blueGrey,
              elevation: 0.0,
              highlightElevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Text(
                'Регистрирај се',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    /*
     * Call dispose from super to close streams 
     */
    super.dispose();
    _loginBloc.dispose();
  }
}