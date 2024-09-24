import 'package:cloud_firestore/cloud_firestore.dart';

class DBService {
  // Singleton pattern
  static final DBService instance = DBService._();

  // Firestore instance
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final String usersCollection = "users";

  // Private constructor
  DBService._();

  // Method to create or update user in Firestore

  Future<void> createUserInDB(
      {required String uid,
      required String email,
      required String imageUrl}) async {
    try {
      await _db.collection(usersCollection).doc(uid).set({
        'email': email,
        'imageUrl': imageUrl,
      });
      print('User added/updated successfully.');
    } catch (e) {
      print('Error adding/updating user: $e');
    }
  }
}
