import 'package:flutter/material.dart';

import 'package:percent_indicator/percent_indicator.dart';

import 'package:misterija_mk/models/posts.dart';
import 'package:misterija_mk/pages/post.dart';

class PostTopicOutlineButton extends StatelessWidget {
  PostTopicOutlineButton({@required this.postTopic, @required this.onPressed});

  final PostTopic postTopic;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 3.0,
        right: 3.0,
        top: 1.0,
        bottom: 1.0,
      ),
      child: OutlineButton(
        onPressed: onPressed,
        borderSide: BorderSide(
          color: Colors.white,
          width: 1.5,
        ),
        child: Text(
          postTopic.name,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  const PostCard({this.post});

  final Post post;

  makePostDifficultyColor(difficulty) {
    if (difficulty <= 0.2) {
      return Colors.lightGreen;
    } else if (difficulty <= 0.5) {
      return Colors.yellow;
    } else if (difficulty <= 0.75) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  makePostDifficultyName(difficulty) {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 0.0,
        color: Colors.white12,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Icon(
                    Icons.question_answer,
                    color: Colors.white,
                  ),
                ),
                Container(
                  child: Text(
                    post.commentsCount.toString(),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            title: new Text(
              post.title,
              style: new TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            subtitle: Row(
              children: <Widget>[
                LinearPercentIndicator(
                  width: 50.0,
                  percent: post.difficulty,
                  progressColor: makePostDifficultyColor(post.difficulty),
                  backgroundColor: Colors.white12,
                ),
                Text(
                  makePostDifficultyName(post.difficulty),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                )
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: IconButton(
                    color: Colors.white,
                    icon: Icon(
                      Icons.keyboard_arrow_right,
                    ),
                    iconSize: 26,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostPage(),
                        ),
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
}