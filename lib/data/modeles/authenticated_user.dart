// To parse this JSON data, do
//
//     final authenticatedUser = authenticatedUserFromJson(jsonString);

import 'dart:convert';

AuthenticatedUser authenticatedUserFromJson(String str) => AuthenticatedUser.fromJson(json.decode(str));

String authenticatedUserToJson(AuthenticatedUser data) => json.encode(data.toJson());

class AuthenticatedUser {
  String? accessToken;
  Authentication? authentication;
  User? user;

  AuthenticatedUser({
    this.accessToken,
    this.authentication,
    this.user,
  });

  factory AuthenticatedUser.fromJson(Map<String, dynamic> json) => AuthenticatedUser(
    accessToken: json["accessToken"],
    authentication: json["authentication"] == null ? null : Authentication.fromJson(json["authentication"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "authentication": authentication?.toJson(),
    "user": user?.toJson(),
  };
}

class Authentication {
  String? strategy;
  Payload? payload;

  Authentication({
    this.strategy,
    this.payload,
  });

  factory Authentication.fromJson(Map<String, dynamic> json) => Authentication(
    strategy: json["strategy"],
    payload: json["payload"] == null ? null : Payload.fromJson(json["payload"]),
  );

  Map<String, dynamic> toJson() => {
    "strategy": strategy,
    "payload": payload?.toJson(),
  };
}

class Payload {
  int? iat;
  int? exp;
  String? aud;
  String? sub;
  String? jti;

  Payload({
    this.iat,
    this.exp,
    this.aud,
    this.sub,
    this.jti,
  });

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    iat: json["iat"],
    exp: json["exp"],
    aud: json["aud"],
    sub: json["sub"],
    jti: json["jti"],
  );

  Map<String, dynamic> toJson() => {
    "iat": iat,
    "exp": exp,
    "aud": aud,
    "sub": sub,
    "jti": jti,
  };
}

class User {
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? email;
  String? username;

  User({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.email,
    this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    email: json["email"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "email": email,
    "username": username,
  };
}
