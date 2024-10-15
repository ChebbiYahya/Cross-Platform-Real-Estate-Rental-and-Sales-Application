import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:immobarcide/models/reservation_model.dart';
import '../models/annonce_model.dart';

class ReservationRepo extends GetxController {
  static ReservationRepo get instance => Get.find();
  final _db = FirebaseFirestore.instance;
// Create Reservation
  Future<bool?> createReservation(ReservationModel reservation) async {
    try {
      final docReservation = _db.collection("reservation").doc();
      reservation = reservation.setId(docReservation.id);
      await docReservation.set(reservation.toJson());
      return true;
    } catch (e) {
      print("erreur");
      return false;
    }
  }

// Get annonce with id
  Future<Annonce?> getAnnonceById(String id) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _db.collection("annonce").doc(id).get();

      if (snapshot.exists) {
        final valueImg =
            await _db.collection("annonce").doc(id).collection("images").get();

        final imageUrls = valueImg.docs.map((e) => e.get("url")).toList();

        return Annonce.fromSnapshot(snapshot, imageUrls);
      } else {
        return null;
      }
    } catch (error) {
      print("Error retrieving annonce by ID: $error");
      return null;
    }
  }
// Get user with id

  /* Future<UserModel> getUserByEmail(String email) async {
    final snapshot =
        await _db.collection("users").where("email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;

    return userData;
  }*/

// Get reservation
  Future<List<ReservationModel>> getReservationsByIdUser(String idUser) async {
    try {
      final snapshot = await _db
          .collection("reservation")
          .where("idUser", isEqualTo: idUser)
          .get();

      final List<ReservationModel> reservations =
          snapshot.docs.map((e) => ReservationModel.fromSnapshot(e)).toList();

      return reservations;
    } catch (error) {
      print("Error retrieving reservations by ID user: $error");
      return [];
    }
  }

  Future<bool?> deleteReservation(String id) async {
    try {
      await _db.collection("reservation").doc(id).delete();
      return true;
    } catch (e) {
      return false;
    }
  }
}
