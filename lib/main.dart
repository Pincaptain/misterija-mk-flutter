import 'package:flutter/material.dart';

import 'package:misterija_mk/pages/splash.dart';

void main() => runApp(MysteryApp());

class MysteryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: SplashPage(),
    );
  }
}
