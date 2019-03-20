import 'package:misterija_mk/models/users.dart';

class PostTopic {
  final int pk;
  final String name;

  PostTopic(this.pk, this.name);

  factory PostTopic.fromJson(Map<String, dynamic> json) {
    return PostTopic(
      json['pk'],
      json['name'],
    );
  }
}

class Post {
  final int pk;
  final String title;
  final String description;
  final double difficulty;
  final String added;
  final String thumbnail;
  final List<PostTopic> postTopics;
  final Profile authorProfile;
  final int commentsCount;

  Post(this.pk, this.title, this.description, this.difficulty, this.added,
      this.thumbnail, this.postTopics, this.authorProfile, this.commentsCount);

  factory Post.fromJson(Map<String, dynamic> json) {
    var postTopics = List<PostTopic>();

    for (var postTopicJson in json['topics']) {
      postTopics.add(PostTopic.fromJson(postTopicJson));
    }

    return Post(
      json['pk'],
      json['title'],
      json['description'],
      json['difficulty'],
      json['added'],
      json['thumbnail'],
      postTopics,
      Profile.fromJson(json['author_profile']),
      json['comments_count'],
    );
  }

}