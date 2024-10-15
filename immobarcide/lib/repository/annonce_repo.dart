import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/annonce_model.dart';

class AnnonceRepository extends GetxController {
  static AnnonceRepository get instace => Get.find();
  final _db = FirebaseFirestore.instance;

// Offers Annonce

  Future<List<Annonce>> getOffers() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await _db
          .collection("annonce")
          .where("offerOrNot", isEqualTo: true)
          .get();

      final List<Annonce> annonces = [];

      for (final document in snapshot.docs) {
        final valueImg = await _db
            .collection("annonce")
            .doc(document.id)
            .collection("images")
            .get();

        final imageUrls = valueImg.docs.map((e) => e.get("url")).toList();

        final annonce = Annonce.fromSnapshot(document, imageUrls);
        annonces.add(annonce);
      }

      return annonces;
    } catch (error) {
      print("Error retrieving annonces: $error");
      return [];
    }
  }

//filter Annonce

  Future<List<Annonce>> getAllAnnoncesWithFilter(
      String category, String location, String type) async {
    try {
      print(
          "Category repo $category\n Location repo $location\n Type repo $type");

      Query<Map<String, dynamic>> query = _db.collection("annonce");

      if (category.isNotEmpty) {
        query = query.where("categorie", isEqualTo: category);
      }

      if (location.isNotEmpty) {
        query = query.where("ville", isEqualTo: location);
      }

      query = query.where("buyOrRent", isEqualTo: type);

      QuerySnapshot<Map<String, dynamic>> snapshot =
          await _db.collection("annonce").get();

      snapshot = await query.get();

      final List<Annonce> annonces = [];

      for (final document in snapshot.docs) {
        final valueImg = await _db
            .collection("annonce")
            .doc(document.id)
            .collection("images")
            .get();

        final imageUrls = valueImg.docs.map((e) => e.get("url")).toList();

        final annonce = Annonce.fromSnapshot(document, imageUrls);
        annonces.add(annonce);
      }

      return annonces;
    } catch (error) {
      print("Error retrieving annonces: $error");
      return [];
    }
  }

// Delete Annonce
  void deleteAnnonce(id) {
    _db.collection("annonce").doc(id).delete();
  }
}
