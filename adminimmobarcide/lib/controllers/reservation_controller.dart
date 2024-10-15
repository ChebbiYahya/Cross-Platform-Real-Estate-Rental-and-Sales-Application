import 'package:get/get.dart';
import '../models/reservation_model.dart';
import '../repository/reservation_repo.dart';

class ReservationController extends GetxController {
  static ReservationController get instance => Get.find();

  //Repository
  final _reservationRepo = Get.put(ReservationRepo());

  Future<List<ReservationModel>> getReservationOnHolding() async {
    return _reservationRepo.getReservationsOnHolding();
  }

  Future<List<ReservationModel>> getReservationConfirm() async {
    return _reservationRepo.getReservationsConfirm();
  }

  Future<List<ReservationModel>> getReservationRefused() async {
    return _reservationRepo.getReservationsRefused();
  }

  getAnnonce(String idAnnonce) {
    return _reservationRepo.getAnnonceById(idAnnonce);
  }

  Future<bool?> deletReservation(String idAnnonce) async {
    return _reservationRepo.deleteReservation(idAnnonce);
  }

  Future<bool?> updateReservation(String status, String id) async {
    return _reservationRepo.updateReservation(status, id);
  }

  Future<bool?> updateReservationNotAvailable(String id) async {
    return _reservationRepo.updateReservationNotAvailble(id);
  }

  Future<bool?> updateReservationOnHolding(String id) async {
    return _reservationRepo.updateReservationOnHolding(id);
  }
}
