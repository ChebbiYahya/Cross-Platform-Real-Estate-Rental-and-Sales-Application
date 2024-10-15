import 'package:cloud_firestore/cloud_firestore.dart';

class ContactModel {
  final String? adress;
  final String? email;
  final String? phone;
  final String? facebook;
  final String? instagram;
  const ContactModel({
    this.adress,
    this.email,
    this.phone,
    this.facebook,
    this.instagram,
  });

  toJson() {
    return {
      "adress": adress,
      "email": email,
      "phone": phone,
      "facebook": facebook,
      "instagram": instagram
    };
  }

  factory ContactModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ContactModel(
        adress: data["adress"],
        email: data["email"],
        phone: data["phone"],
        facebook: data["facebook"],
        instagram: data["instagram"]);
  }
}
