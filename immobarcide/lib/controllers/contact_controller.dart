import 'package:get/get.dart';
import '../repository/contact_repo.dart';

class ContactController extends GetxController {
  static ContactController get instance => Get.find();

  //Repository
  final _contactRepo = Get.put(ContactRepo());
  getContactData() {
    return _contactRepo.getContact();
  }
}
