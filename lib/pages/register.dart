import 'package:flutter/material.dart';

import 'package:flushbar/flushbar.dart';

import 'package:misterija_mk/blocs/register_bloc.dart';
import 'package:misterija_mk/pages/login.dart';

class RegisterPage extends StatefulWidget {
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Business login component for register page
  final _registerBloc = RegisterBloc();

  @mustCallSuper
  @override
  initState() {
    super.initState();
    _onRegisterResult();
  }

  _onRegisterResult() {
    /*
     * Listen for register results
     * If register result successful redirect to login screen
     * If register result failed show flushbar with specific error message 
     */
    _registerBloc.register.listen((result) {
      if (result == RegisterResult.UnexpectedError) {
        Flushbar(
          message: 'Дојде до неочекуван проблем. Обидете се повторно.',
          duration: Duration(seconds: 3),
        ).show(context);
      } else if (result == RegisterResult.InvalidCredentials) {
        Flushbar(
          message: 'Внесените податоци не се валидни или се веќе искористени.'
              ' Обидете се повторно.',
          duration: Duration(seconds: 3),
        ).show(context);
      } else {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => LoginPage()));
      }
    });
  }

  _onLogin() {
    /*
     * Redirect to login page 
     */
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    /*
     * Build the register page view 
     */
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 24.0,
          ),
          children: <Widget>[
            SizedBox(
              height: 48.0,
            ),
            StreamBuilder<String>(
              stream: _registerBloc.username,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return TextField(
                  onChanged: _registerBloc.onUsernameChanged,
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
              stream: _registerBloc.email,
              builder: (context, snapshot) {
                return TextField(
                  onChanged: _registerBloc.onEmailChanged,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Е-пошта',
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
              }
            ),
            SizedBox(
              height: 8.0,
            ),
            StreamBuilder<String>(
              stream: _registerBloc.password,
              builder: (context, snapshot) {
                return TextField(
                  onChanged: _registerBloc.onPasswordChanged,
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
              }
            ),
            SizedBox(
              height: 24.0,
            ),
            StreamBuilder<bool>(
              stream: _registerBloc.validate,
              builder: (context, snapshot) {
                return RaisedButton(
                  onPressed: snapshot.data != null ? _registerBloc.onRegister : null,
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
                    'Регистрирај се',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                );
              }
            ),
            RaisedButton(
              onPressed: _onLogin,
              color: Colors.blueGrey,
              elevation: 0.0,
              highlightElevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Text(
                'Најави се',
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
     * Override dispose to close streams and connections
     */
    super.dispose();
    _registerBloc.dispose();
  }
}
