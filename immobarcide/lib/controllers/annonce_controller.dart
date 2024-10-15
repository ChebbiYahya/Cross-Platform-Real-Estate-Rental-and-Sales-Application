import 'package:get/get.dart';
import '../models/annonce_model.dart';
import '../repository/annonce_repo.dart';

class AnnonceController extends GetxController {
  static AnnonceController get instance => Get.find();
  final _annonceRepository = Get.put(AnnonceRepository());

  Future<List<Annonce>> getAnnonceWithFilter(
      String category, String location, String type) async {
    return await _annonceRepository.getAllAnnoncesWithFilter(
        category, location, type);
  }

  Future<List<Annonce>> getAllOffersInfo() async {
    return await _annonceRepository.getOffers();
  }
}
