import 'package:flutter/material.dart';

class UsernameForm extends StatelessWidget {
  UsernameForm({@required this.validator, @required this.onSaved, @required this.focusNode, @required this.onFieldSubmitted});

  final FormFieldValidator<String> validator;
  final FormFieldSetter<String> onSaved;
  final FocusNode focusNode;
  final ValueChanged<String> onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onSaved: onSaved,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      autofocus: false,
      textInputAction: TextInputAction.next,
      style: TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        hintText: 'Корисничко име',
        hintStyle: TextStyle(
          color: Colors.white,
        ),
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
}

class PasswordForm extends StatelessWidget {
  PasswordForm({@required this.validator, @required this.onSaved, @required this.focusNode, @required this.onFieldSubmitted});

  final FormFieldValidator<String> validator;
  final FormFieldSetter<String> onSaved;
  final FocusNode focusNode;
  final ValueChanged<String> onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onSaved: onSaved,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      autofocus: false,
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
}

class EmailForm extends StatelessWidget {
  EmailForm({@required this.validator, @required this.onSaved, @required this.focusNode, @required this.onFieldSubmitted});

  final FormFieldValidator<String> validator;
  final FormFieldSetter<String> onSaved;
  final FocusNode focusNode;
  final ValueChanged<String> onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      validator: validator,
      textInputAction: TextInputAction.next,
      onSaved: onSaved,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      autofocus: false,
      style: TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        hintText: 'Е-пошта',
        hintStyle: TextStyle(
          color: Colors.white,
        ),
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
}

class LoginButton extends StatelessWidget {
  LoginButton({@required this.onPressed});

  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
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
  }
}

class MaybeRegisterButton extends StatelessWidget {
  MaybeRegisterButton({@required this.onPressed});

  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
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
      onPressed: onPressed,
    );
  }
}

class RegisterButton extends StatelessWidget {
  RegisterButton({@required this.onPressed});

  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
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
}

class MaybeLoginButton extends StatelessWidget {
  MaybeLoginButton({@required this.onPressed});

  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
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
      onPressed: onPressed,
    );
  }
}