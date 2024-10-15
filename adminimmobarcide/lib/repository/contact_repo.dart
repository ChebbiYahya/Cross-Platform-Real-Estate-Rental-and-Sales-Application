import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/contact_model.dart';

class ContactRepo extends GetxController {
  static ContactRepo get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<ContactModel> getContact() async {
    final snapshot = await _db.collection("contact").get();
    final userData =
        snapshot.docs.map((e) => ContactModel.fromSnapshot(e)).single;
    return userData;
  }

  Future<void> updateContact(ContactModel contact) async {
    await _db.collection("contact").doc("1").update(contact.toJson());
  }
}
