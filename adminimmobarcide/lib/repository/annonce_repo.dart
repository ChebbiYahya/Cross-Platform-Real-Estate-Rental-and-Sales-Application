import 'dart:typed_data';
import 'package:adminimmobarcide/models/annonce_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class AnnonceRepository extends GetxController {
  static AnnonceRepository get instace => Get.find();
  late CollectionReference imgRef;
  late firebase_storage.Reference ref;
  final _db = FirebaseFirestore.instance;
  createAnnonce(Annonce annonce, List<Uint8List> images) async {
    await _db.collection("annonce").add(annonce.toJson()).then((value) async {
      int i = 1;
      await _db
          .collection("annonce")
          .doc(value.id)
          .update({"id": "${value.id}"});
      for (var img in images) {
        ref = firebase_storage.FirebaseStorage.instance
            .ref()
            .child("Image/${value.id}/$i.png");
        imgRef = _db.collection("annonce").doc(value.id).collection("images");
        await ref.putData(img).whenComplete(() async {
          await ref.getDownloadURL().then((value) {
            imgRef.add({'url': value});
          });
        });
        i++;
      }
    });
  }

  Future<List<Annonce>> getAllAnnonces() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await _db.collection("annonce").get();

      final List<Annonce> annonces = [];

      for (final document in snapshot.docs) {
        final data = document.data();

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

  void deleteAnnonce(id) {
    _db.collection("annonce").doc(id).delete();
  }

  void deleteReservation(id) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await _db
          .collection("reservation")
          .where("idAnnonce", isEqualTo: id)
          .get();

      // Loop through the documents that match the condition and delete them
      for (QueryDocumentSnapshot<Map<String, dynamic>> document
          in querySnapshot.docs) {
        await _db.collection("reservation").doc(document.id).delete();

        await deleteFolderContents("Image/${document.id}");
      }

      // The documents with "idAnnonce" equal to 'id' have been deleted
    } catch (error) {
      print("Error deleting documents: $error");
    }
  }

  Future<void> deleteFolderContents(String path) async {
    await FirebaseStorage.instance.ref(path).listAll().then((dir) {
      dir.items.forEach((fileRef) {
        this.deleteFile(fileRef.fullPath);
      });
    });
  }

  Future<void> deleteFile(String filePath) async {
    await FirebaseStorage.instance.ref(filePath).delete().then((_) {
      print('Successfully deleted $filePath');
    });
  }
}
