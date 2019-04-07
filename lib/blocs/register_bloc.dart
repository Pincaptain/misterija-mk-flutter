import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

import 'bloc.dart';
import 'package:misterija_mk/models/auth.dart';

// All types of register result
enum RegisterResult {
  Success,
  InvalidCredentials,
  UnexpectedError,
}

class RegisterBloc extends BlocBase {
  // Stream controllers for username, password, email and register
  final _usernameController = StreamController<String>.broadcast();
  final _passwordController = StreamController<String>.broadcast();
  final _emailController = StreamController<String>.broadcast();
  final _registerController = StreamController<RegisterResult>.broadcast();

  // Last username, password and email combination
  var _usernameValue = '';
  var _passwordValue = '';
  var _emailValue = '';

  // Return a stream transformer that further validates the username
  Stream<String> get username =>
      _usernameController.stream.transform(_usernameValidator);
  // Return a stream transformer that further validates the password
  Stream<String> get password =>
      _passwordController.stream.transform(_passwordValidator);
  // Return a stream transformer that further validates the email
  Stream<String> get email =>
      _emailController.stream.transform(_emailValidator);
  // Return a stream that shows if the fields are valid or not
  Stream<bool> get validate =>
      Observable.combineLatest3(username, password, email, (u, p, e) => true);
  // Return a register result stream that shows the register results
  Stream<RegisterResult> get register => _registerController.stream;

  // Sinks for username, password, email and register attempts
  Sink<String> get _inUsername => _usernameController.sink;
  Sink<String> get _inPassword => _passwordController.sink;
  Sink<String> get _inEmail => _emailController.sink;
  Sink<RegisterResult> get _inRegister => _registerController.sink;

  Function get onRegister => () async {
    /*
     * Try to register the user with provided input
     * Add register result to sink
     */
    var data = Register(_usernameValue, _emailValue, _passwordValue);
    var response = await http.post(
      Uri.encodeFull(Client.client + 'api/users/register/'),
      body: data.toJson(),
    );

    if (response.statusCode >= 400 && response.statusCode < 500) {
      _inRegister.add(RegisterResult.InvalidCredentials);

      return;
    } else if (response.statusCode != 201) {
      _inRegister.add(RegisterResult.UnexpectedError);

      return;
    }

    _inRegister.add(RegisterResult.Success);
  };

  Function(String) get onUsernameChanged => (username) {
    /*
     * Change the last known username value
     * Add the new username to sink for further validation 
     */
    _usernameValue = username;
    _inUsername.add(username);
  };

  Function(String) get onEmailChanged => (email) {
    /*
     * Change the last known email value
     * Add the new username to sink for further validation 
     */
    _emailValue = email;
    _inEmail.add(email);
  };

  Function(String) get onPasswordChanged => (password) {
    /*
     * Change the last known password value
     * Add the new username to sink for further validation 
     */
    _passwordValue = password;
    _inPassword.add(password);
  };

  var _usernameValidator = StreamTransformer<String, String>.fromHandlers(
    /*
     * Transform the username stream based on input
     * Provide errors/validation if the rules are not obeyed
     * Return the input if everything is okay
     */
    handleData: (username, sink) {
      if (username.isNotEmpty) {
        sink.add(username);
      } else {
        sink.addError('Корисничкото име не може да биде празно');
      }
    }
  );

  var _passwordValidator = StreamTransformer<String, String>.fromHandlers(
    /*
     * Transform the password stream based on input
     * Provide errors/validation if the rules are not obeyed
     * Return the input if everything is okay
     */
    handleData: (password, sink) {
      if (password.isNotEmpty) {
        sink.add(password);
      } else {
        sink.addError('Лозинката не може да биде празна');
      }
    }
  );

  var _emailValidator = StreamTransformer<String, String>.fromHandlers(
    /*
     * Transform the email stream based on input
     * Provide errors/validation if the rules are not obeyed
     * Return the input if everything is okay
     */
    handleData: (email, sink) {
      if (email.isNotEmpty) {
        var regExp = new RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

        if (regExp.hasMatch(email)) {
          sink.add(email);
        } else {
          sink.addError('Внесената е-пошта не е валидна');
        }
      } else {
        sink.addError('Е-поштата не може да биде празна');
      }
    }
  );

  @override
  void dispose() {
    /*
     * Provide the super class method dispose to close the stream controllers 
     */
    _usernameController?.close();
    _passwordController?.close();
    _emailController?.close();
    _registerController?.close();
    _registerController?.close();
  }
}