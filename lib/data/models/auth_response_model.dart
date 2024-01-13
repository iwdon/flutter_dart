import 'dart:convert';

class AuthResponseModel {
  final String jwtToken;
  final User user;

  AuthResponseModel({
    required this.jwtToken,
    required this.user,
  });

  factory AuthResponseModel.fromJson(String str) =>
      AuthResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AuthResponseModel.fromMap(Map<String, dynamic> json) =>
      AuthResponseModel(
        jwtToken: json["jwt-token"] ??
            "", // Penanganan nilai null dan kunci yang sesuai
        user: User.fromMap(json["user"] ?? {}), // Penanganan nilai null
      );

  Map<String, dynamic> toMap() => {
        "jwt-token": jwtToken,
        "user": user.toMap(),
      };
}

class User {
  final int id;
  final String name;
  final String role;

  User({
    required this.id,
    required this.name,
    required this.role,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"] ?? 0, // Penanganan nilai null
        name: json["name"] ?? "", // Penanganan nilai null
        role: json["role"] ?? "", // Penanganan nilai null
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "role": role,
      };
}
