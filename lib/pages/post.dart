import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:percent_indicator/percent_indicator.dart';
import 'package:http/http.dart' as http;
import 'package:flushbar/flushbar.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:misterija_mk/models/core.dart';
import 'package:misterija_mk/models/auth.dart';
import 'package:misterija_mk/widgets/core.dart';

class PostPage extends StatefulWidget {
  PostPage({@required this.post});

  final Post post;

  @override
  State<StatefulWidget> createState() => _PostPageState(post);
}

class _PostPageState extends State<PostPage>  {
  _PostPageState(this.post);

  final Post post;
  Post _post;

  bool _areCommentsVisible;

  String _comment;

  final _commentFormKey = GlobalKey<FormState>();

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    _setCommentsVisibility(true);
    _doFetchDetailPost();
  }

  makeDetailPostDifficultyColor(difficulty) {
    return Color.lerp(Colors.green, Colors.red, difficulty);
  }

  makeDetailPostDifficultyName(difficulty) {
    if (difficulty <= 0.2) {
      return 'Едноставна тежина';
    } else if (difficulty <= 0.5) {
      return 'Средна тежина';
    } else if (difficulty <= 0.75) {
      return 'Жешка тежина';
    } else {
      return 'Пеколна тежина';
    }
  }

  _setCommentsVisibility(bool visible) {
    setState(() {
      _areCommentsVisible = visible;
    });
  }

  _changeCommentsVisibility() {
    setState(() {
      _areCommentsVisible = !_areCommentsVisible;
    });
  }

  _doFetchDetailPost() async {
    var response = await http.get(
      Uri.encodeFull(Client.client + 'api/posts/' + post.pk.toString() + '/'),
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

    setState(() {
      _post = Post.fromJson(jsonBody);
    });

    return true;
  }

  _onSettings(int value) {
    switch (value) {
      case 0:
        launch(Client.client + 'api/posts/' + _post.pk.toString() + '/');
        break;
      case 1:
        launch('https://www.riddles.com/');
        break;
      case 2:

        break;
    }
  }

  _onFeedback() {

  }

  _onComment(term) async {
    if (_commentFormKey.currentState.validate()) {
      _commentFormKey.currentState.save();
      var createPostComment = CreateComment(_comment, _post.pk);

      var response = await http.post(
        Uri.encodeFull(Client.client + 'api/posts/comments/create/'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': Token.toHeader(),
        },
        body: json.encode(createPostComment.toJson()),
      );

      if (response.statusCode != 201) {
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

      _commentFormKey.currentState.reset();
      _doFetchDetailPost();

      return true;
    }
  }

  _onVote(Comment postComment, int index) async {
    var response = await http.get(
      Uri.encodeFull(Client.client + 'api/posts/comments/vote/${postComment.pk.toString()}/'),
      headers: {
        'Accept': 'application/json',
        'Authorization': Token.toHeader(),
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

    var jsonString = utf8.decode(response.bodyBytes);
    var jsonBody = json.decode(jsonString);
    var newPostComment = Comment.fromJson(jsonBody);
    var modifiedPostComment = Comment(postComment.pk, postComment.comment, postComment.added, postComment.profile, newPostComment.selected, newPostComment.votesCount);

    setState(() {
      _post.comments[index] = modifiedPostComment;
    });

    return true;
  }

  _onDelete(Comment postComment, int index) async {

  }

  _onEdit(Comment postComment, int index) async {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        elevation: 0.0,
        title: Row(
          children: <Widget>[
            Text(
              _post == null ? post.title : _post.title,
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
          Theme(
            data: Theme.of(context).copyWith(
              cardColor: Colors.blueGrey,
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
              textTheme: TextTheme(
                  body1: TextStyle(
                    color: Colors.white,
                  )
              ),
            ),
            child: PopupMenuButton(
              onSelected: _onSettings,
              tooltip: 'Прикажи мени',
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: 0,
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Icon(
                            Icons.share,
                            color: Colors.white,
                          ),
                          margin: EdgeInsets.only(
                            right: 10.0,
                          ),
                        ),
                        Text(
                          'Сподели'
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
                            Icons.open_in_browser,
                            color: Colors.white,
                          ),
                          margin: EdgeInsets.only(
                            right: 10.0,
                          ),
                        ),
                        Text(
                          'Извор'
                        )
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Icon(
                            Icons.help_outline,
                            color: Colors.white,
                          ),
                          margin: EdgeInsets.only(
                            right: 10.0,
                          ),
                        ),
                        Text(
                          'Решение'
                        )
                      ],
                    ),
                  ),
                ];
              },
            ),
          ),
        ],
      ),
      body: _post == null ? Container() : SingleChildScrollView(
        child: Column(
          children: <Widget>[
            PostImagesCarouselSlider(
              postImages: _post.images,
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(
                  left: 10.0,
                  top: 6.0,
                  bottom: 6.0,
                ),
                child: LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 20,
                  lineHeight: 7.0,
                  percent: _post.difficulty,
                  progressColor: makeDetailPostDifficultyColor(_post.difficulty),
                  backgroundColor: Colors.white12,
                ),
              ),
            ),
            Container(
              child: Card(
                elevation: 0.0,
                color: Colors.white12,
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            _post.author.avatar,
                          ),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(50)
                        )
                      ),
                    ),
                    title: Text(
                      _post.author.user.firstName.isEmpty ? _post.author.user.lastName.isEmpty ? _post.author.user.username : _post.author.user.lastName : _post.author.user.firstName + ' ' + _post.author.user.lastName,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      _post.added.toString(),
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                    trailing: IconButton(
                      tooltip: 'Повратна информација',
                      icon: Icon(
                        Icons.feedback,
                        color: Colors.white,
                      ),
                      onPressed: _onFeedback,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 0.0,
                bottom: 0.0,
                left: 6.0,
                right: 6.0,
              ),
              child: Center(
                child: Card(
                  elevation: 0.0,
                  color: Colors.white12,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                            bottom: 10.0,
                          ),
                          child: Text(
                            _post.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        Text(
                          _post.description,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 0.0,
                bottom: 0.0,
                left: 6.0,
                right: 6.0,
              ),
              child: Column(
                children: <Widget>[
                  Card(
                    elevation: 0.0,
                    color: Colors.white12,
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                tooltip: 'Прикажи/сокри одговори',
                                icon: Icon(
                                  Icons.comment,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  _changeCommentsVisibility();
                                },
                              ),
                            ],
                          ),
                          title: Text(
                            'Одговори',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Text(
                            _post.comments.length.toString(),
                            style: TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                        ),
                        Card(
                          elevation: 0.0,
                          color: Colors.black.withOpacity(0.0),
                          child: Container(
                            padding: EdgeInsets.only(
                              top: 0.0,
                              bottom: 10.0,
                              left: 10.0,
                              right: 10.0,
                            ),
                            child: Form(
                              key: _commentFormKey,
                              child: TextFormField(
                                validator: (input) {
                                  return input.isEmpty ? 'Празен одговор нема да се прифати' : null;
                                },
                                onSaved: (input) {
                                  setState(() {
                                    _comment = input;
                                  });
                                },
                                textInputAction: TextInputAction.send,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                onFieldSubmitted: _onComment,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                  labelText: 'Внесете одговор',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              child: Container(
                margin: EdgeInsets.only(
                  top: 0.0,
                  bottom: 6.0,
                  left: 6.0,
                  right: 6.0,
                ),
                height: _post.comments.length * 116 * 1.0,
                child: ListView.builder(
                  itemCount: _post.comments.length,
                  itemBuilder: (context, index) {
                    return PostCommentCard(
                      postComment: _post.comments[index],
                      onVote: () => _onVote(_post.comments[index], index),
                    );
                  },
                ),
                ),
              visible: _areCommentsVisible,
            ),
          ],
        ),
      ),
    );
  }
}