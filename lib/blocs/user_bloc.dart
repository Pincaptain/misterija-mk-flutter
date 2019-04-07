import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'bloc.dart';
import 'package:misterija_mk/models/users.dart';
import 'package:misterija_mk/models/auth.dart';

class UserBloc extends BlocBase {
  // User stream controller with sink and stream
  final _userController = StreamController<CurrentProfile>.broadcast();

  // Return user stream
  Stream<CurrentProfile> get user => _userController.stream;

  // Return user sink
  Sink<CurrentProfile> get _inUser => _userController.sink;

  Function get fetchUser => () async {
    /*
     * Get current user details from server
     * Add the user to sink if successful 
     */
    var response = await http.get(
      Uri.encodeFull(Client.client + 'api/users/profiles/current/'),
       headers: {
        'Authorization': Token.toHeader(),
      }
    );

    if (response.statusCode != 200) {
      return;
    }

    var jsonString = utf8.decode(response.bodyBytes);
    var jsonData = json.decode(jsonString);
    var user = CurrentProfile.fromJson(jsonData);

    _inUser.add(user);
  };

  @override
  dispose() {
    /*
     * Provide the super class method dispose to close the stream controllers 
     */
    _userController?.close();
  }
}