import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'package:misterija_mk/models/users.dart';
import 'package:misterija_mk/models/auth.dart';
import 'package:misterija_mk/models/core.dart';
import 'package:misterija_mk/widgets/core.dart';
import 'package:misterija_mk/widgets/general.dart';
import 'package:misterija_mk/pages/login.dart';
import 'package:misterija_mk/pages/settings.dart';
import 'package:misterija_mk/pages/account.dart';
import 'package:misterija_mk/blocs/user_bloc.dart';
import 'package:misterija_mk/blocs/topics_bloc.dart';
import 'package:misterija_mk/blocs/posts_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserBloc _userBloc = UserBloc();
  TopicsBloc _topicsBloc = TopicsBloc();
  PostsBloc _postsBloc = new PostsBloc();

  // Write user state since drawers calls build when opened
  CurrentProfile _user;

  _HomePageState() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  @protected
  @mustCallSuper
  initState() {
    super.initState();
    _onUser();

    _userBloc.fetchUser();
    _topicsBloc.fetchTopics();
    _postsBloc.fetchPosts();
  }

  _onUser() {
    /*
     * Listen for changes in current user
     * If new current user comes change the state 
     */
    _userBloc.user.listen((user) {
      setState(() {
       _user = user;
      });
    });
  }

  _onAccount() {
    /*
     * Redirect to accout page 
     */
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => AccountPage()));
  }

  _onLogout() async {
    /*
     * Logout the user by calling token logout function
     * Check Token.doLogout for more info
     */
    if (await Token.doLogout()) {
      Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  _onSearch() async {
    /*
     * Provide a post search delegate that returns a query
     * Use the query to retun a new list of posts
     */
    var query = await showSearch(
      context: context,
      delegate: PostSearch(),
    );

    _postsBloc.fetchPostsByQuery(query);
  }

  _onSettings(int value) {
    /*
     * Do some self descriptive operation based on settings 
     */
    switch (value) {
      case 0: // Case: Settings Popup Item
        Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SettingsPage()));
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
                'Мистерија МК е софтвер кој им нуди на корисниците голем број на загатки од различен тип без притоа истиот тој да им помага во решавањето. Апликацијата е направена со цел да го зајакне критичното размислување на корисниците и притоа да им овозможи удобна околина за меѓусебна соработка.',
              ),
            );
          }
        );
        break;
    }
  }

  Future<void> _onRefresh() async {
    /*
     * Refresh the feed by fetching all the posts, topics and users again
     */
    _userBloc.fetchUser();
    _topicsBloc.fetchTopics();
    _postsBloc.fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    /*
     * Build the home page view 
     */
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
                UserAccountsDrawerHeader(
                  accountName: Text(
                    _user == null ? '' : _user.user.firstName.isEmpty ? _user.user.lastName.isEmpty ? _user.user.username : _user.user.lastName : _user.user.firstName + ' ' + _user.user.lastName,
                  ),
                  accountEmail: Text(
                    _user == null ? '' : _user.user.email.isEmpty ? 'Корисникот нема внесено е-пошта' : _user.user.email,
                  ),
                  currentAccountPicture: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          _user == null ? '' : _user.avatar,
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(
                          Radius.circular(50)
                      ),
                    ),
                  ),
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
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 35.0,
                  margin: EdgeInsets.only(
                    top: 3.0,
                    bottom: 6.0,
                  ),
                  child: StreamBuilder<List<Topic>>(
                    stream: _topicsBloc.topics,
                    initialData: List(),
                    builder: (context, snapshot) {
                      print(snapshot.data.length);
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return PostTopicOutlineButton(
                            onPressed: () {
                              _postsBloc.fetchPostsByTopic(snapshot.data[index]);
                            },
                            postTopic: snapshot.data[index],
                          );
                        },
                        scrollDirection: Axis.horizontal,
                      );
                    }
                  ),
                ),
                Expanded(
                  child: StreamBuilder<List<Post>>(
                    stream: _postsBloc.posts,
                    initialData: List(),
                    builder: (context, snapshot) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return PostCard(
                            post: snapshot.data[index],
                          );
                        }
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    /*
     * Call dispose to get rid of streams/connections 
     */
    super.dispose();
    _userBloc?.dispose();
    _topicsBloc?.dispose();
    _postsBloc?.dispose();
  }
}

class PostSearch extends SearchDelegate<String> {
  PostSearch() {
    /*
     * Fetch all suggestions on start
     */
    _doFetchPostSuggestions();
  }

  var _suggestions = List<String>();

  @override
  List<Widget> buildActions(BuildContext context) {
    /*
     * Build actions view 
     */
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
    /*
     * Build leading view 
     */
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
    /*
     * Close the delegate and return the provided query
     */
    close(context, query);
    return ListView();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    /*
     * Build the suggestions based on the query 
     */
    var filteredSuggestions = _suggestions
        .where((suggestion) => suggestion.toLowerCase().contains(query.toLowerCase()))
        .toList();

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
    /*
     * Fetch the suggestions from database
     * Add them to the suggestions list of the delegate
     */
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
    /*
     * Once a suggestion is clicked change the query 
     */
    query = suggestion;
  }
}