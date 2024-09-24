import 'dart:io';
import 'package:image_picker/image_picker.dart';

class MediaService {
  // Singleton pattern
  static final MediaService instance = MediaService._();

  final ImagePicker _picker = ImagePicker();

  MediaService._(); // Private constructor for singleton

  Future<File?> getImageFromFile() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return File(image.path);
    }
    return null;
  }
}
