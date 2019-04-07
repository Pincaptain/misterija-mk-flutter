import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'bloc.dart';
import 'package:misterija_mk/models/auth.dart';
import 'package:misterija_mk/models/core.dart';

class PostsBloc extends BlocBase {
  // Stream controller for posts
  final _postsController = StreamController<List<Post>>();

  // Return a posts stream
  Stream<List<Post>> get posts => _postsController.stream;

  // Stream for posts
  Sink<List<Post>> get _inPosts => _postsController.sink;

  Function get fetchPosts => () async {
    /*
     * Fetch all posts from server
     * If the operation is successful add then to posts sink 
     */
    var response = await http.get(
      Uri.encodeFull(Client.client + 'api/posts/'),
    );

    if (response.statusCode != 200) {
      return;
    }

    var jsonString = utf8.decode(response.bodyBytes);
    var jsonData = json.decode(jsonString);
    var posts = 
        await Stream.fromIterable(jsonData)
            .map((value) => Post.fromJson(value))
            .toList();

    _inPosts.add(posts);
  };

  Function(Topic) get fetchPostsByTopic => (topic) async {
    /*
     * Fetch posts by topic from server
     * If the operation is successful add then to posts sink
     */
    var response = await http.get(
      Uri.encodeFull(Client.client + 'api/posts/filter/?topic=' + topic.pk.toString()),
    );

    if (response.statusCode != 200) {
      return;
    }

    var jsonString = utf8.decode(response.bodyBytes);
    var jsonData = json.decode(jsonString);
    var posts = 
        await Stream.fromIterable(jsonData)
            .map((value) => Post.fromJson(value))
            .toList();

    _inPosts.add(posts);
  };

  Function(String) get fetchPostsByQuery => (query) async {
    /*
     * Fetch all posts by query from server
     * If the operation is successful add then to posts sink 
     */
    var response = await http.get(
      Uri.encodeFull(Client.client + 'api/posts/filter/?query=' + query),
    );

    if (response.statusCode != 200) {
      return;
    }

    var jsonString = utf8.decode(response.bodyBytes);
    var jsonData = json.decode(jsonString);
    var posts = 
        await Stream.fromIterable(jsonData)
            .map((value) => Post.fromJson(value))
            .toList();

    _inPosts.add(posts);
  };

  @override
  dispose() {
    /*
     * Provide the super class method dispose to close the stream controllers 
     */
    _postsController?.close();
  }
}