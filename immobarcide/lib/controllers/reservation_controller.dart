import 'package:get/get.dart';
import 'package:immobarcide/models/reservation_model.dart';
import 'package:immobarcide/models/user_model.dart';
import 'package:immobarcide/repository/authentification_repo.dart';

import '../repository/reservation_repo.dart';

class ReservationController extends GetxController {
  static ReservationController get instance => Get.find();

  //Repository
  final _reservationRepo = Get.put(ReservationRepo());
  final _authentificationRepo = Get.put(AuthentificationRepository());

  createReservationController(ReservationModel reservation) async {
    return _reservationRepo.createReservation(reservation);
  }

  Future<List<ReservationModel>> getReservation() async {
    final email = _authentificationRepo.firebaseUser.value?.email;
    if (email != null) {
      UserModel? _user =
          await _authentificationRepo.getUserDetails(email) as UserModel;
      // Annonce? _annonce = await _reservationRepo.getAnnonceById(_user.id!);
      return _reservationRepo.getReservationsByIdUser(_user.id!);
    }
    return [];
  }

  getAnnonce(String idAnnonce) {
    return _reservationRepo.getAnnonceById(idAnnonce);
  }

  Future<bool?> deletAnnonce(String idAnnonce) async {
    return _reservationRepo.deleteReservation(idAnnonce);
  }
}
