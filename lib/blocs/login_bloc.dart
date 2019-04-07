import 'dart:async';
import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:misterija_mk/models/auth.dart';
import 'bloc.dart';

// All types of login result
enum LoginResult {
  Success,
  InvalidCredentials,
  UnexpectedError,
}

class LoginBloc extends BlocBase {
  // Stream controllers for username, password and auth
  final _usernameController = StreamController<String>.broadcast();
  final _passwordController = StreamController<String>.broadcast();
  final _authController = StreamController<LoginResult>.broadcast();

  // Last username and password combination
  var _usernameValue = '';
  var _passwordValue = '';

  // Return a stream transformer that further validates the username
  Stream<String> get username =>
      _usernameController.stream.transform(_usernameValidator);
  // Return a stream transformer that further validates the password      
  Stream<String> get password =>
      _passwordController.stream.transform(_passwordValidator);
  // Return a stream that shows if the fields are valid or not
  Stream<bool> get validate =>
      Observable.combineLatest2(username, password, (u, p) => true);
  // Return a login result stream that shows the login results
  Stream<LoginResult> get auth => _authController.stream;

  // Sinks for username, password and authentication attempts
  Sink<String> get _inUsername => _usernameController.sink;
  Sink<String> get _inPassword => _passwordController.sink;
  Sink<LoginResult> get _inAuth => _authController.sink;


  Function(String) get onUsernameChanged => (username) {
    /*
     * Update the last known username from input
     * Add the new usernamee to the sink/transformer 
     */
    _usernameValue = username;
    _inUsername.add(username);
  };

  Function(String) get onPasswordChanged => (password) {
    /*
     * Update the last known password from input
     * Add the new password to the sink/transformer 
     */
    _passwordValue = password;
    _inPassword.add(password);
  };

  Function get onAuth => () async {
    /*
     * Authenticate the user based on the last known username and password combination
     * If successful save the obtained token to local storage for further usages
     * Add login result to auth sink based on status
     */
    var data = Login(_usernameValue, _passwordValue);
    var response = await http.post(
      Uri.encodeFull(Client.client + 'api/users/login/'),
      body: data.toJson(),
    );

    if (response.statusCode >= 400 && response.statusCode < 500) {
      _inAuth.add(LoginResult.InvalidCredentials);

      return;
    } else if (response.statusCode != 200) {
      _inAuth.add(LoginResult.UnexpectedError);

      return;
    }

    var jsonString = utf8.decode(response.bodyBytes);
    var jsonBody = json.decode(jsonString);

    Token.fromJson(jsonBody);

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('token', Token.token);

    _inAuth.add(LoginResult.Success);
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

  @override
  void dispose() {
    /*
     * Provide the super class method dispose to close the stream controllers 
     */
    _usernameController?.close();
    _passwordController?.close();
    _authController?.close();
  }
}