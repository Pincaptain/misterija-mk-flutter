import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'bloc.dart';
import 'package:misterija_mk/models/auth.dart';
import 'package:misterija_mk/models/core.dart';

class TopicsBloc extends BlocBase {
  // Topics stream controller with sink and stream
  final _topicsController = StreamController<List<Topic>>.broadcast();

  // Return topics stream
  Stream<List<Topic>> get topics => _topicsController.stream;

  // Return topics sink
  Sink<List<Topic>> get _inTopics => _topicsController.sink;

  Function get fetchTopics => () async {
    /*
     * Get all the topics from server
     * Add topics list to sink 
     */
    var response = await http.get(
      Uri.encodeFull(Client.client + 'api/posts/topics/'),
    );

    if (response.statusCode != 200) {
      return;
    }

    var jsonString = utf8.decode(response.bodyBytes);
    var jsonData = json.decode(jsonString);
    var topics = 
        await Stream.fromIterable(jsonData)
            .map((value) => Topic.fromJson(value))
            .toList();

    _inTopics.add(topics);
  };

  @override
  dispose() {
    /*
     * Provide the super class method dispose to close the stream controllers 
     */
    _topicsController?.close();
  }
}