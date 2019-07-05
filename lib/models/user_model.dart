import 'dart:convert';

class User {
  String user;
  String password;

  User({
    this.user,
    this.password
  });

  factory User.fromJson(Map<String, dynamic> json) => new User(
    user: json["user"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "password": password,
  };
}

User userFromJson(String str) {
  final jsonData = json.decode(str);
  return User.fromJson(jsonData);
}

String userToJson(User data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}