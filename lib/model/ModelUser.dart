import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:json_annotation/json_annotation.dart';

import 'ModelGlobalData.dart';

@JsonSerializable()
class User {
  String id;
  String email;
  String phoneNumber;
  String name;
  DateTime birthDate;
  bool isActive;
  String avatarUri;
  List<String> roles; // Add roles field

  User({
    required this.id,
    required this.email,
    required this.phoneNumber,
    required this.name,
    required this.birthDate,
    required this.isActive,
    required this.avatarUri,
    required this.roles, // Include roles in the constructor
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      name: json['name'] as String,
      birthDate: DateTime.parse(json['birthDate']),
      isActive: json['isActive'] as bool,
      avatarUri: json['avatarUri'] as String,
      roles: (json['roles'] as List).map((e) => e.toString()).toList(), // Parse roles
    );
  }

  Map<String, dynamic> toJson() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String birthDateString = formatter.format(this.birthDate);

    return {
      'id': this.id,
      'email': this.email,
      'phoneNumber': this.phoneNumber,
      'name': this.name,
      'birthDate': birthDateString,
      'isActive': this.isActive,
      'avatarUri': this.avatarUri,
      'roles': this.roles, // Include roles in the JSON serialization
    };
  }
  final storage = new FlutterSecureStorage();

  void saveUserData(User user) async {
    String userData = jsonEncode(user.toJson());
    await storage.write(key: 'userData', value: userData);
  }
  void clearUserData() async {
    await storage.write(key: 'userData', value: null);
  }
  void readUserData() async
  {
    String? userData = await storage.read(key: 'userData');

    if (userData != null) {
      Map<String, dynamic> userMap = jsonDecode(userData);
      GlobalData.LoginUser = User.fromJson(userMap);
    }
  }

}


class Register{
  final String email;
  final String password;
  final String phoneNumber;
  final String name;
  final DateTime birthDate;

  Register({
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.name,
    required this.birthDate,
  });

  factory Register.fromJson(Map<String, dynamic> json) {
    return Register(
      email: json['email'] as String,
      password: json['password'] as String,
      phoneNumber: json['phoneNumber'] as String,
      name: json['name'] as String,
      birthDate: DateTime.parse(json['birthDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'name': name,
      'birthDate': birthDate.toIso8601String(),
    };
  }
}