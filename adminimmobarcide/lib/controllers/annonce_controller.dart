import 'dart:typed_data';
import 'package:adminimmobarcide/models/annonce_model.dart';
import 'package:get/get.dart';
import '../repository/annonce_repo.dart';

class AnnonceController extends GetxController {
  static AnnonceController get instance => Get.find();
  final _annonceRepository = Get.put(AnnonceRepository());

  Future<void> createAnnonce(Annonce annonce, List<Uint8List> images) async {
    await _annonceRepository.createAnnonce(annonce, images);
  }

  Future<List<Annonce>> getAllAnnonceInfo() async {
    return await _annonceRepository.getAllAnnonces();
  }

  Future<List<Annonce>> getAnnonceWithFilter(
      String category, String location, String type) async {
    return await _annonceRepository.getAllAnnoncesWithFilter(
        category, location, type);
  }

  Future<void> deleteAnnonce(id) async {
    _annonceRepository.deleteAnnonce(id);
    _annonceRepository.deleteReservation(id);
  }
}
