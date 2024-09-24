import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class CloudStorageService {
  // Singleton pattern
  static final CloudStorageService instance = CloudStorageService._();

  // Firebase storage instance and reference
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final String profileImagesPath = 'profile_images';

  // Private constructor
  CloudStorageService._();

  // Upload user image to Firebase Storage
  Future<TaskSnapshot?> uploadUserImage(String uid, File image) async {
    try {
      // Reference to the location where the image will be stored
      Reference storageRef = _storage.ref().child(profileImagesPath).child(uid);

      // Uploading the image
      UploadTask uploadTask = storageRef.putFile(image);

      // Await the task completion and return the snapshot
      TaskSnapshot snapshot = await uploadTask;
      return snapshot;
    } catch (e) {
      log('Error uploading image: $e');
      return null;
    }
  }

  // Optional: method to get the download URL after upload
  Future<String?> getDownloadURL(String uid) async {
    try {
      Reference storageRef = _storage.ref().child(profileImagesPath).child(uid);
      String downloadURL = await storageRef.getDownloadURL();
      return downloadURL;
    } catch (e) {
      log('Error getting download URL: $e');
      return null;
    }
  }
}

//  // usage example
// void uploadProfileImage(File image, String uid) async {
//   CloudStorageService storageService = CloudStorageService.instance;

//   TaskSnapshot? snapshot = await storageService.uploadUserImage(uid, image);

//   if (snapshot != null) {
//     String? downloadURL = await storageService.getDownloadURL(uid);
//     if (downloadURL != null) {
//       print('Image uploaded successfully. Download URL: $downloadURL');
//     }
//   } else {
//     print('Image upload failed.');
//   }
// }
