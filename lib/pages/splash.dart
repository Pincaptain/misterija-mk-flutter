import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flare_flutter/flare_actor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';

import 'package:misterija_mk/models/auth.dart';
import 'package:misterija_mk/pages/login.dart';
import 'package:misterija_mk/pages/home.dart';
import 'package:misterija_mk/pages/no_connection.dart';

class SplashPage extends StatefulWidget {
  SplashPage() {
    /*
     * Disable mobile status bar (bar with clock, battery, etc)
     * Only enable portrait screen mode.
     */
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  _SplashPageState() {
    /*
     * Start the splash screen timer
     * Once the timer ends start the transition
     */
    const timeout = const Duration(seconds: 3);
    var duration = timeout;
    new Timer(duration, doTransition);
  }

  doTransition() async {
    /*
     * Check multiple conditions and based on that decide the next page
     * Check internet connectivity
     * Check if the user is authenticated
     */
    var sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    var destination;
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      destination = NoConnectionPage();
    } else if (token != null) {
      Token.token = token;
      destination = HomePage();
    } else {
      destination = LoginPage();
    }

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => destination,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    /*
     * Provides a view for the page
     */
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