import 'package:get/get.dart';
import '../models/user_model.dart';
import '../repository/authentification_repo.dart';

class AuthentificationController extends GetxController {
  static AuthentificationController get instance => Get.find();
  final _authentificationRepo = Get.put(AuthentificationRepository());
//sign in
  Future<bool?> loginUserController(String email, String password) async {
    return _authentificationRepo.signIn(email, password);
  }

//sign up
  Future<bool?> createUserController(UserModel user) async {
    final status = _authentificationRepo.SignUp(user.email, user.password!);
    if (await status == true) {
      await _authentificationRepo.createUser(user);
    }
    return status;
  }

//Logout
  Future<void> logoutController() async {
    _authentificationRepo.logout();
  }

// status Login
  isConnectedController() async {
    return _authentificationRepo.firebaseUser;
  }
}
