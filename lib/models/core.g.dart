// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'core.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Topic _$TopicFromJson(Map<String, dynamic> json) {
  return Topic(json['pk'] as int, json['name'] as String);
}

Map<String, dynamic> _$TopicToJson(Topic instance) =>
    <String, dynamic>{'pk': instance.pk, 'name': instance.name};

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment(
      json['pk'] as int,
      json['comment'] as String,
      json['added'] == null ? null : DateTime.parse(json['added'] as String),
      json['author_profile'] == null
          ? null
          : Profile.fromJson(json['author_profile'] as Map<String, dynamic>),
      json['selected'] as bool,
      json['votes_count'] as int);
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'pk': instance.pk,
      'comment': instance.comment,
      'added': instance.added?.toIso8601String(),
      'author_profile': instance.profile,
      'selected': instance.selected,
      'votes_count': instance.votesCount
    };

CreateComment _$CreateCommentFromJson(Map<String, dynamic> json) {
  return CreateComment(json['comment'] as String, json['post'] as int);
}

Map<String, dynamic> _$CreateCommentToJson(CreateComment instance) =>
    <String, dynamic>{'comment': instance.comment, 'post': instance.post};

PostImage _$PostImageFromJson(Map<String, dynamic> json) {
  return PostImage(json['pk'] as int, json['image'] as String);
}

Map<String, dynamic> _$PostImageToJson(PostImage instance) =>
    <String, dynamic>{'pk': instance.pk, 'image': instance.image};

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
      json['pk'] as int,
      json['title'] as String,
      json['description'] as String,
      (json['difficulty'] as num)?.toDouble(),
      json['added'] == null ? null : DateTime.parse(json['added'] as String),
      json['thumbnail'] as String,
      (json['topics'] as List)
          ?.map((e) =>
              e == null ? null : Topic.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['author_profile'] == null
          ? null
          : Profile.fromJson(json['author_profile'] as Map<String, dynamic>),
      json['comments_count'] as int,
      (json['images'] as List)
          ?.map((e) =>
              e == null ? null : PostImage.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['comments'] as List)
          ?.map((e) =>
              e == null ? null : Comment.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'pk': instance.pk,
      'title': instance.title,
      'description': instance.description,
      'difficulty': instance.difficulty,
      'added': instance.added?.toIso8601String(),
      'thumbnail': instance.thumbnail,
      'topics': instance.topics,
      'author_profile': instance.author,
      'comments_count': instance.commentsCount,
      'images': instance.images,
      'comments': instance.comments
    };
