import 'package:get/get.dart';
import '../models/contact_model.dart';
import '../repository/contact_repo.dart';

class ContactController extends GetxController {
  static ContactController get instance => Get.find();

  //Repository
  final _contactRepo = Get.put(ContactRepo());
  getContactData() {
    return _contactRepo.getContact();
  }

  updateRecord(ContactModel contact) async {
    await _contactRepo.updateContact(contact);
  }
}
