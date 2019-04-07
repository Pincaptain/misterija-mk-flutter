// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Login _$LoginFromJson(Map<String, dynamic> json) {
  return Login(json['username'] as String, json['password'] as String);
}

Map<String, dynamic> _$LoginToJson(Login instance) => <String, dynamic>{
      'username': instance.username,
      'password': instance.password
    };

Register _$RegisterFromJson(Map<String, dynamic> json) {
  return Register(json['username'] as String, json['email'] as String,
      json['password'] as String);
}

Map<String, dynamic> _$RegisterToJson(Register instance) => <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'password': instance.password
    };
