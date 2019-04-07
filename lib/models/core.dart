import 'package:json_annotation/json_annotation.dart';

import 'package:misterija_mk/models/users.dart';

part 'core.g.dart';

@JsonSerializable()
class Topic extends Object {
  final int pk;
  final String name;

  Topic(this.pk, this.name);

  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(json);

  Map<String, dynamic> toJson() => _$TopicToJson(this);
}

@JsonSerializable()
class Comment extends Object {
  final int pk;
  final String comment;
  final DateTime added;
  @JsonKey(name: 'author_profile')
  final Profile profile;
  final bool selected;
  @JsonKey(name: 'votes_count')
  final int votesCount;

  Comment(this.pk, this.comment, this.added, this.profile,
      this.selected, this.votesCount);

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}

@JsonSerializable()
class CreateComment extends Object {
  final String comment;
  final int post;

  CreateComment(this.comment, this.post);

  factory CreateComment.fromJson(Map<String, dynamic> json) =>
      _$CreateCommentFromJson(json);

  Map<String, dynamic> toJson() => _$CreateCommentToJson(this);
}

@JsonSerializable()
class PostImage extends Object {
  final int pk;
  final String image;

  PostImage(this.pk, this.image);

  factory PostImage.fromJson(Map<String, dynamic> json) => _$PostImageFromJson(json);

  Map<String, dynamic> toJson() => _$PostImageToJson(this);
}

@JsonSerializable()
class Post extends Object {
  final int pk;
  final String title;
  final String description;
  final double difficulty;
  final DateTime added;
  final String thumbnail;
  final List<Topic> topics;
  @JsonKey(name: 'author_profile')
  final Profile author;
  @JsonKey(name: 'comments_count')
  final int commentsCount;
  final List<PostImage> images;
  final List<Comment> comments;

  Post(this.pk, this.title, this.description, this.difficulty, this.added,
      this.thumbnail, this.topics, this.author, this.commentsCount,
      this.images, this.comments);

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}