import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  DrawerItem({@required this.text, @required this.onPressed, this.icon});

  final String text;
  final GestureTapCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.all(0.0),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.white,
        ),
        title: Text(
          text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      onPressed: onPressed,
    );
  }
}

class SearchSuggestionButton extends StatelessWidget {
  SearchSuggestionButton({@required this.suggestion, @required this.onPressed});

  final String suggestion;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Container(
        height: 50,
        alignment: Alignment.centerLeft,
        child: Text(
          suggestion,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      onPressed: onPressed,
    );
  }
}