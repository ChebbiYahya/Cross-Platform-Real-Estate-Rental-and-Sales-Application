import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

class AuthentificationRepository extends GetxController {
  static AuthentificationRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  //Variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
  }

  createUser(UserModel user) async {
    try {
      final User? userId = await FirebaseAuth.instance.currentUser;
      final userID = userId!.uid;
      final docUser = _db.collection("usersAdmin").doc();
      user = user.setId(userID);
      await docUser.set(user.toJson());
    } catch (e) {
      print(e);
    }
  }

  //Sign Up
  Future<bool?> SignUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      print(e);
      return false;
    }
  }

  //Sign In

  Future<bool?> signIn(String email, String password) async {
    try {
      final newUser = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (newUser != null) {
        final User? user = await FirebaseAuth.instance.currentUser;
        final userID = user!.uid;
        print("id=$userID");

        final snapshot = await FirebaseFirestore.instance
            .collection("usersAdmin")
            .where("id", isEqualTo: userID)
            .get();
        print("doc= ${snapshot.docs}");

        if (snapshot.docs.isNotEmpty) {
          // Loop through the documents in the query result
          for (var doc in snapshot.docs) {
            final role = doc.data()["role"];
            if (role == "admin") {
              return true;
            }
          }
          // Handle the case when no document with the "admin" role is found
          print("No admin role found for this user.");
          return false;
        } else {
          // Handle the case when no document matches the query
          print("No matching document found.");
          return false;
        }
      }
    } on FirebaseAuthException catch (e) {
      print("Error: $e");
      return false;
    }
    // Handle any other potential error cases and return a value accordingly.
  }

  //Forguet Password
  Future<bool?> ForguetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);

      print("succes");
      return true;
    } on FirebaseAuthException catch (e) {
      print("erreur");
      return false;
    }
  }

  //Logout
  Future<void> logout() async => await _auth.signOut();
}
