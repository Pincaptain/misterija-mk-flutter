import 'package:flutter/material.dart';

import 'package:misterija_mk/pages/splash.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*
     * Build the main app view 
     */
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: SplashPage(),
    );
  }
}
