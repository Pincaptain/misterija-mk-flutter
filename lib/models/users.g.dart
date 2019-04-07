// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(json['pk'] as int, json['username'] as String,
      json['firstName'] as String, json['lastName'] as String);
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'pk': instance.pk,
      'username': instance.username,
      'firstName': instance.firstName,
      'lastName': instance.lastName
    };

CurrentUser _$CurrentUserFromJson(Map<String, dynamic> json) {
  return CurrentUser(
      json['pk'] as int,
      json['username'] as String,
      json['email'] as String,
      json['firstName'] as String,
      json['lastName'] as String);
}

Map<String, dynamic> _$CurrentUserToJson(CurrentUser instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'username': instance.username,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName
    };

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return Profile(
      json['pk'] as int,
      json['bio'] as String,
      json['location'] as String,
      json['avatar'] as String,
      json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>));
}

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'pk': instance.pk,
      'bio': instance.bio,
      'location': instance.location,
      'avatar': instance.avatar,
      'user': instance.user
    };

CurrentProfile _$CurrentProfileFromJson(Map<String, dynamic> json) {
  return CurrentProfile(
      json['pk'] as int,
      json['bio'] as String,
      json['location'] as String,
      json['avatar'] as String,
      json['user'] == null
          ? null
          : CurrentUser.fromJson(json['user'] as Map<String, dynamic>));
}

Map<String, dynamic> _$CurrentProfileToJson(CurrentProfile instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'bio': instance.bio,
      'location': instance.location,
      'avatar': instance.avatar,
      'user': instance.user
    };
