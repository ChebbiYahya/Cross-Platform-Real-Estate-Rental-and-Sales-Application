import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationModel {
  final String? fullname;
  final String? phone;
  final String? idUser;
  final String? idAnnonce;
  final String? idReservation;
  final String? time;
  final String? note;
  final String? status;

  const ReservationModel({
    this.fullname,
    this.idAnnonce,
    this.idUser,
    this.idReservation,
    this.phone,
    this.time,
    this.note,
    this.status,
  });

  toJson() {
    return {
      "fullname": fullname,
      "idAnnonce": idAnnonce,
      "idUser": idUser,
      "idReservation": idReservation,
      "phone": phone,
      "time": time,
      "note": note,
      "status": status,
    };
  }

  ReservationModel setId(String IdReser) {
    return ReservationModel(
      idReservation: IdReser,
      fullname: this.fullname,
      idAnnonce: this.idAnnonce,
      idUser: this.idUser,
      phone: this.phone,
      time: this.time,
      note: this.note,
      status: this.status,
    );
  }

  factory ReservationModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return ReservationModel(
      fullname: data["fullname"],
      idAnnonce: data["idAnnonce"],
      idUser: data["idUser"],
      idReservation: data["idReservation"],
      phone: data["phone"],
      time: data["time"],
      note: data["note"],
      status: data["status"],
    );
  }
}
