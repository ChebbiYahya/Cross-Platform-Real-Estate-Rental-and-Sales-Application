import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:immobarcide/repository/authentification_repo.dart';

import '../models/user_model.dart';

class AuthentificationController extends GetxController {
  static AuthentificationController get instance => Get.find();
  final _authentificationRepo = Get.put(AuthentificationRepository());
  Future<bool?> createUserController(UserModel user) async {
    bool? status =
        await _authentificationRepo.SignUp(user.email!, user.password!);
    print("test status = $status");
    if (status == true) await _authentificationRepo.createUser(user);
    return status;
  }

  Future<bool?> loginUserController(UserModel user) async {
    return _authentificationRepo.SignIn(user.email!, user.password!);
  }

  Future<bool?> forguetPasswordController(String email) async {
    return _authentificationRepo.ForguetPassword(email);
  }

  Future<void> logoutController() async {
    _authentificationRepo.logout();
  }

  getUserDetailsController() async {
    final email = _authentificationRepo.firebaseUser.value?.email;
    if (email != null) {
      return _authentificationRepo.getUserDetails(email);
    }
  }

  updateUserController(UserModel user) async {
    _authentificationRepo.updateUserRecord(user);
  }

  Future<bool?> isConnectedController() async {
    print("helooooooooooooo ${await _authentificationRepo.firebaseUser}");
    if (_authentificationRepo.firebaseUser == null) {
      return false;
    } else {
      return true;
    }

    /* print("hellllllllllllo ${_authentificationRepo.firebaseUser}");
    return _authentificationRepo.firebaseUser;*/
  }
}
