import 'package:flutter/material.dart';

import 'package:percent_indicator/percent_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:misterija_mk/models/core.dart';
import 'package:misterija_mk/pages/post.dart';

class PostTopicOutlineButton extends StatelessWidget {
  PostTopicOutlineButton({@required this.postTopic, @required this.onPressed});

  final Topic postTopic;
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
    return Color.lerp(Colors.lightGreenAccent, Colors.redAccent, difficulty);
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
                          builder: (context) => PostPage(
                            post: post,
                          ),
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

class PostCommentCard extends StatelessWidget {
  PostCommentCard({@required this.postComment, @required this.onVote});

  final Comment postComment;
  final GestureTapCallback onVote;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      color: postComment.selected ? Colors.green[600] : Colors.white12,
      child: Column(
        children: <Widget>[
          Container(
            child: ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      postComment.profile.avatar,
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(
                      Radius.circular(50)
                  ),
                ),
              ),
              title: Text(
                  postComment.profile.user.firstName.isEmpty ? postComment.profile.user.lastName.isEmpty ? postComment.profile.user.username : postComment.profile.user.lastName : postComment.profile.user.firstName + ' ' + postComment.profile.user.lastName,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                postComment.added.toString(),
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              trailing: Column(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.thumb_up,
                      color: Colors.white,
                    ),
                    onPressed: onVote,
                    tooltip: 'Гласај',
                  ),
                  Text(
                    postComment.votesCount.toString(),
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 10.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  postComment.comment,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PostImagesCarouselSlider extends StatelessWidget {
  PostImagesCarouselSlider({@required this.postImages});

  final List<PostImage> postImages;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.0),
      child: CarouselSlider(
        enlargeCenterPage: true,
        height: 200.0,
        items: postImages.map((postImage) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                    color: Colors.white12,
                    image: DecorationImage(
                      image: NetworkImage(
                        postImage.image,
                      ),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    )
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}