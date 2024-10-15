import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String fullName;
  final String? email;
  final String phoneNum;
  final String? password;
  const UserModel({
    this.id,
    this.email,
    this.password,
    required this.fullName,
    required this.phoneNum,
  });
  UserModel setId(String IdUser) {
    return UserModel(
      id: IdUser,
      email: this.email,
      password: this.password,
      fullName: this.fullName,
      phoneNum: this.phoneNum,
    );
  }

  toJson() {
    return {
      "id": id,
      "fullName": fullName,
      "email": email,
      "phoneNum": phoneNum,
      "password": password
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
        id: document.id,
        email: data["email"],
        password: data["password"],
        fullName: data["fullName"],
        phoneNum: data["phoneNum"]);
  }
}
