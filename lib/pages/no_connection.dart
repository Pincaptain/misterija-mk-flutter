import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flare_flutter/flare_actor.dart';
import 'package:connectivity/connectivity.dart';

import 'splash.dart';

class NoConnectionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NoConnectionPageState();
}

class _NoConnectionPageState extends State<NoConnectionPage> {
  StreamSubscription<ConnectivityResult> _connectionSubscription;

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    _connectionSubscription = Connectivity().onConnectivityChanged.listen(_onConnectionChanged);
  }

  _onConnectionChanged(ConnectivityResult result) {
    if (result != ConnectivityResult.none) {
      _connectionSubscription.cancel();

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SplashPage()
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              child: Expanded(
                child: FlareActor(
                  'assets/animations/NoConnection.flr',
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                  animation:"Default",
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}