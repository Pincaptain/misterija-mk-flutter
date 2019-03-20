class User {
  final int pk;
  final String username;
  final String firstName;
  final String lastName;

  User(this.pk, this.username, this.firstName, this.lastName);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['pk'],
      json['username'],
      json['first_name'],
      json['last_name'],
    );
  }
}

class CurrentUser {
  final int pk;
  final String username;
  final String email;
  final String firstName;
  final String lastName;

  CurrentUser(this.pk, this.username, this.email, this.firstName, this.lastName);

  factory CurrentUser.fromJson(Map<String, dynamic> json) {
    return CurrentUser(
      json['pk'],
      json['username'],
      json['email'],
      json['first_name'],
      json['last_name'],
    );
  }
}

class Profile {
  final int pk;
  final String bio;
  final String location;
  final String avatar;
  final User user;

  Profile(this.pk, this.bio, this.location, this.avatar, this.user);

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      json['pk'],
      json['bio'],
      json['location'],
      json['avatar'],
      User.fromJson(json['user']),
    );
  }
}

class CurrentProfile {
  final int pk;
  final String bio;
  final String location;
  final String avatar;
  final CurrentUser user;

  CurrentProfile(this.pk, this.bio, this.location, this.avatar, this.user);

  factory CurrentProfile.fromJson(Map<String, dynamic> json) {
    return CurrentProfile(
      json['pk'],
      json['bio'],
      json['location'],
      json['avatar'],
      CurrentUser.fromJson(json['user']),
    );
  }
}