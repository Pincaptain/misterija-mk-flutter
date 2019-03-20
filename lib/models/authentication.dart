class Client {
  static String client = 'http://192.168.1.124:80/';
}

class Login {
  final String username;
  final String password;

  Login(this.username, this.password);

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      json['username'],
      json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': this.username,
      'password': this.password,
    };
  }
}

class Register {
  final String username;
  final String email;
  final String password;

  Register(this.username, this.email, this.password);

  factory Register.fromJson(Map<String, dynamic> json) {
    return Register(
      json['username'],
      json['email'],
      json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  }
}

class Token {
  static String token;

  static void fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  static Map<String, dynamic> toJson() {
    return {
      'token': token,
    };
  }

  static bool isAuthenticated() {
    return token != null;
  }

  static bool doLogout() {
    if (token == null) {
      return false;
    }

    token = null;

    return true;
  }

  static String toHeader() {
    return 'Token ' + token;
  }
}