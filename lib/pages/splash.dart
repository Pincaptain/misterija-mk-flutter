import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flare_flutter/flare_actor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:misterija_mk/models/authentication.dart';
import 'package:misterija_mk/pages/login.dart';
import 'package:misterija_mk/pages/home.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  _doTransition() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");
    Widget destination;

    if (token != null) {
      Token.token = token;
      destination = HomePage();
    } else {
      destination = LoginPage(false);
    }

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => destination,
      ),
    );
  }

  _SplashPageState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    const timeout = const Duration(seconds: 3);
    var duration = timeout;
    new Timer(duration, _doTransition);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blueGrey,
        child: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                child: FlareActor(
                  'assets/animations/FingerprintSplash.flr',
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                  animation:"process",
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}