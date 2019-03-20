import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:flushbar/flushbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:misterija_mk/models/users.dart';
import 'package:misterija_mk/models/authentication.dart';
import 'package:misterija_mk/models/posts.dart';
import 'package:misterija_mk/widgets/users.dart';
import 'package:misterija_mk/widgets/posts.dart';
import 'package:misterija_mk/widgets/general.dart';
import 'package:misterija_mk/pages/login.dart';
import 'package:misterija_mk/pages/settings.dart';
import 'package:misterija_mk/pages/account.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _HomePageState() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  CurrentProfile _currentProfile;

  List<PostTopic> _postTopics = List<PostTopic>();
  List<Post> _posts = List<Post>();

  @protected
  @mustCallSuper
  initState() {
    super.initState();
    _doFetchCurrentProfile();
    _doFetchPostTopics();
    _doFetchPosts();
  }

  Future<bool> _doFetchCurrentProfile() async {
    var response = await http.get(
      Uri.encodeFull(Client.client + 'api/users/profiles/current/'),
      headers: {
        'Authorization': Token.toHeader(),
        'Accept': 'application/json',
      }
    );

    if (response.statusCode != 200) {
      Flushbar(
        messageText: Text(
          'Неочекуван проблем! Ве молиме рестартирајте ја апликацијата.',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        duration: Duration(
          seconds: 3,
        ),
      ).show(context);

      return false;
    }

    var jsonString = response.body;
    var jsonData = json.decode(jsonString);

    setState(() {
      _currentProfile = CurrentProfile.fromJson(jsonData);
    });

    return true;
  }

  Future<bool> _doFetchPostTopics() async {
    var response = await http.get(
      Uri.encodeFull(Client.client + 'api/posts/topics/'),
      headers: {
        'Accept': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      Flushbar(
        messageText: Text(
          'Неочекуван проблем! Ве молиме рестартирајте ја апликацијата.',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        duration: Duration(
          seconds: 3,
        ),
      ).show(context);

      return false;
    }

    var jsonString = utf8.decode(response.bodyBytes);
    var jsonBody = json.decode(jsonString);
    var postTopicsList = List<PostTopic>();

    for (var child in jsonBody) {
      postTopicsList.add(PostTopic.fromJson(child));
    }

    setState(() {
      _postTopics = postTopicsList;
    });

    return true;
  }

  Future<bool> _doFetchPosts() async {
    var response = await http.get(
      Uri.encodeFull(Client.client + 'api/posts/'),
      headers: {
        'Accept': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      Flushbar(
        messageText: Text(
          'Неочекуван проблем! Ве молиме рестартирајте ја апликацијата.',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        duration: Duration(
          seconds: 3,
        ),
      ).show(context);

      return false;
    }

    var jsonString = utf8.decode(response.bodyBytes);
    var jsonBody = json.decode(jsonString);
    var postsList = List<Post>();

    for (var child in jsonBody) {
      postsList.add(Post.fromJson(child));
    }

    setState(() {
      _posts = postsList;
    });

    return true;
  }

  Future<bool> _doFetchPostsByTopic(PostTopic postTopic) async {
    var response = await http.get(
      Uri.encodeFull(Client.client + 'api/posts/filter/?topic=' + postTopic.pk.toString()
      ),
      headers: {
        'Accept': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      Flushbar(
        messageText: Text(
          'Неочекуван проблем! Ве молиме рестартирајте ја апликацијата.',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        duration: Duration(
          seconds: 3,
        ),
      ).show(context);

      return false;
    }

    var jsonString = utf8.decode(response.bodyBytes);
    var jsonBody = json.decode(jsonString);
    var postsList = List<Post>();

    for (var child in jsonBody) {
      postsList.add(Post.fromJson(child));
    }

    setState(() {
      _posts = postsList;
    });

    return true;
  }

  Future<bool> _doFetchPostsByQuery(String query) async {
    var response = await http.get(
      Uri.encodeFull(Client.client + 'api/posts/filter/?query=' + query),
      headers: {
        'Accept': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      Flushbar(
        messageText: Text(
          'Неочекуван проблем! Ве молиме рестартирајте ја апликацијата.',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        duration: Duration(
          seconds: 3,
        ),
      ).show(context);

      return false;
    }

    var jsonString = utf8.decode(response.bodyBytes);
    var jsonBody = json.decode(jsonString);
    var postsList = List<Post>();

    for (var child in jsonBody) {
      postsList.add(Post.fromJson(child));
    }

    setState(() {
      _posts = postsList;
    });

    return true;
  }

  _onAccount() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AccountPage(),
      ),
    );
  }

  _onLogout() async {
    if (Token.doLogout()) {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString('token', null);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(false),
        ),
      );
    }
  }

  _onSearch() async {
    String query = await showSearch(
      context: context,
      delegate: PostSearch(),
    );

    _doFetchPostsByQuery(query);
  }

  _onSettings(int value) {
    switch (value) {
      case 0: // Case: Settings Popup Item
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SettingsPage(),
          ),
        );
        break;
      case 1: // Case: Information Popup Item
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Информации'
              ),
              content: Text(
                'Мистерија МК - Верзија 1.0 е софтвер кој им нуди на корисниците голем број на загатки од различен тип без притоа истиот тој да им помага во решавањето. Апликацијата е направена со цел да го зајакне критичното размислување на корисниците и притоа да им овозможи удобна околина за меѓусебна соработка.',
              ),
            );
          }
        );
        break;
    }
  }

  Future<void> _onRefresh() async {
    _doFetchPostTopics();
    _doFetchPosts();
    _doFetchCurrentProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        cardColor: Colors.blueGrey,
        iconTheme: IconThemeData(

          color: Colors.white,
        ),
        textTheme: TextTheme(
          body1: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          elevation: 0.0,
          title: Row(
            children: <Widget>[
              Text(
                'Дома',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.blueGrey,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
              ),
              onPressed: () {
                _onSearch();
              },
            ),
            PopupMenuButton(
              tooltip: 'Прикажи мени',
              onSelected: _onSettings,
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: 0,
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Icon(
                            Icons.settings,
                            color: Colors.white,
                          ),
                          margin: EdgeInsets.only(
                            right: 10.0,
                          ),
                        ),
                        Text(
                            'Опции'
                        )
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Icon(
                            Icons.info_outline,
                            color: Colors.white,
                          ),
                          margin: EdgeInsets.only(
                            right: 10.0,
                          ),
                        ),
                        Text(
                            'Информации'
                        )
                      ],
                    ),
                  ),
                ];
              },
            ),
          ],
        ),
        drawer: Drawer(
          elevation: 0.0,
          child: Container(
            color: Colors.blueGrey,
            child: ListView(
              children: <Widget>[
                DrawerProfileHeader(
                  currentProfile: _currentProfile,
                ),
                DrawerItem(
                  text: 'Сметка',
                  icon: Icons.account_circle,
                  onPressed: _onAccount,
                ),
                DrawerItem(
                  text: 'Одјави се',
                  icon: Icons.exit_to_app,
                  onPressed: _onLogout,
                ),
              ],
            ),
          ),
        ),
        body: Container(
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            child: ListView.builder(
              itemCount: _posts.length == 0 ? 1 : _posts.length,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0 && _posts.length == 0) {
                  return Container(
                    height: 35,
                    margin: EdgeInsets.only(
                      top: 3.0,
                      bottom: 6.0,
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _postTopics.length,
                      itemBuilder: (BuildContext context, int index) {
                        return PostTopicOutlineButton(
                          postTopic: _postTopics[index],
                          onPressed: () {
                            _doFetchPostsByTopic(_postTopics[index]);
                          },
                        );
                      },
                    ),
                  );
                } else if (index == 0) {
                  return Column(
                    children: <Widget>[
                      Container(
                        height: 35,
                        margin: EdgeInsets.only(
                          top: 3.0,
                          bottom: 6.0,
                        ),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _postTopics.length,
                          itemBuilder: (BuildContext context, int index) {
                            return PostTopicOutlineButton(
                              postTopic: _postTopics[index],
                              onPressed: () {
                                _doFetchPostsByTopic(_postTopics[index]);
                              },
                            );
                          },
                        ),
                      ),
                      PostCard(
                        post: _posts[index],
                      ),
                    ],
                  );
                } else {
                  return PostCard(
                    post: _posts[index],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class PostSearch extends SearchDelegate<String> {
  PostSearch() {
    _doFetchPostSuggestions();
  }

  var _suggestions = List<String>();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: transitionAnimation,
        ),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, query);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    close(context, query);
    return ListView();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> filteredSuggestions = _suggestions.where((suggestion) => suggestion.toLowerCase().contains(query.toLowerCase())).toList();

    if (query != '') {
      return ListView.builder(
        itemCount: filteredSuggestions.length,
        itemBuilder: (context, index) {
          return SearchSuggestionButton(
            suggestion: filteredSuggestions[index],
            onPressed: () => _onSuggestion(filteredSuggestions[index]),
          );
        },
      );
    } else {
      return ListView();
    }
  }

  _doFetchPostSuggestions() async {
    var response = await http.get(
      Uri.encodeFull(Client.client + 'api/posts/suggestions'),
      headers: {
        'Accept': 'application/json',
      }
    );

    var jsonString = utf8.decode(response.bodyBytes);
    var jsonData = json.decode(jsonString);
    var suggestionsList = List<String>();

    for (var child in jsonData) {
      suggestionsList.add(child['title']);
    }

    _suggestions = suggestionsList;
  }

  _onSuggestion(String suggestion) {
    query = suggestion;
  }
}