import 'package:flutter/material.dart';

import 'package:flare_flutter/flare_actor.dart';

import 'splash.dart';
import 'package:misterija_mk/blocs/no_connection_bloc.dart';

class NoConnectionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NoConnectionPageState();
}

class _NoConnectionPageState extends State<NoConnectionPage> {
  // Business logic component for no connection page
  final _noConnectionBloc = NoConnectionBloc();

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    _onConnectivityChanged();
  }

  _onConnectivityChanged() {
    /*
     * Listen on connection changes
     * If connectivity returns true redirects to splash
     * Else it waits / does nothing
     */
    _noConnectionBloc.outConnectivity.listen((isConnected) {
      if (isConnected) {
        Navigator
            .of(context)
            .push(MaterialPageRoute(builder: (context) => SplashPage()));
      }
    });
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

  @override
  void dispose() {
    /*
     * Override dispose to close streams and connections
     */
    super.dispose();
    _noConnectionBloc.dispose();
  }
}