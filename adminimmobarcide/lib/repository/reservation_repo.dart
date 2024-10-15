import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/annonce_model.dart';
import '../models/reservation_model.dart';

class ReservationRepo extends GetxController {
  static ReservationRepo get instance => Get.find();
  final _db = FirebaseFirestore.instance;

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

// Get reservation
  Future<List<ReservationModel>> getReservationsOnHolding() async {
    try {
      final snapshot = await _db
          .collection("reservation")
          .where("status", isEqualTo: "0")
          .get();

      final List<ReservationModel> reservations =
          snapshot.docs.map((e) => ReservationModel.fromSnapshot(e)).toList();

      return reservations;
    } catch (error) {
      print("Error retrieving reservations by ID user: $error");
      return [];
    }
  }

  Future<List<ReservationModel>> getReservationsConfirm() async {
    try {
      final snapshot = await _db
          .collection("reservation")
          .where("status", isEqualTo: "1")
          .get();

      final List<ReservationModel> reservations =
          snapshot.docs.map((e) => ReservationModel.fromSnapshot(e)).toList();

      return reservations;
    } catch (error) {
      print("Error retrieving reservations by ID user: $error");
      return [];
    }
  }

  Future<List<ReservationModel>> getReservationsRefused() async {
    try {
      final snapshot = await _db
          .collection("reservation")
          .where("status", whereIn: ["2", "3", "4"]).get();

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

  Future<bool?> updateReservation(String status, String id) async {
    try {
      await _db.collection("reservation").doc(id).update({"status": status});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool?> updateReservationNotAvailble(String id) async {
    try {
      await _db.collection("reservation").doc(id).update({"status": "3"});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool?> updateReservationOnHolding(String id) async {
    try {
      await _db.collection("reservation").doc(id).update({"status": "0"});
      return true;
    } catch (e) {
      return false;
    }
  }
}
