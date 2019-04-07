import 'package:json_annotation/json_annotation.dart';

part 'users.g.dart';

@JsonSerializable()
class User extends Object {
  final int pk;
  final String username;
  final String firstName;
  final String lastName;

  User(this.pk, this.username, this.firstName, this.lastName);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class CurrentUser extends Object {
  final int pk;
  final String username;
  final String email;
  final String firstName;
  final String lastName;

  CurrentUser(this.pk, this.username, this.email, this.firstName, this.lastName);

  factory CurrentUser.fromJson(Map<String, dynamic> json) =>
      _$CurrentUserFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentUserToJson(this);
}

@JsonSerializable()
class Profile extends Object {
  final int pk;
  final String bio;
  final String location;
  final String avatar;
  final User user;

  Profile(this.pk, this.bio, this.location, this.avatar, this.user);

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}

@JsonSerializable()
class CurrentProfile extends Object {
  final int pk;
  final String bio;
  final String location;
  final String avatar;
  final CurrentUser user;

  CurrentProfile(this.pk, this.bio, this.location, this.avatar, this.user);

  factory CurrentProfile.fromJson(Map<String, dynamic> json) =>
      _$CurrentProfileFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentProfileToJson(this);
}