import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class StorageService {
  static Future<String> uploadPhoto(
      {required String uid, required XFile file}) async {
    final Reference storageReference = FirebaseStorage.instance.ref();
    final Reference photoReference =
        storageReference.child('$uid/${file.name}');

    try {
      if (kIsWeb) {
        Uint8List? fileAsBytes = await file.readAsBytes();
        await photoReference.putData(fileAsBytes);
      } else {
        await photoReference.putFile(File(file.path));
      }
    } on Exception catch (error) {
      debugPrint('Error Uploading Photo: $error');
    }

    String downloadURL = await photoReference.getDownloadURL();
    return downloadURL;
  }

  static Future<void> deletePhoto({required String photoPath}) async {
    final Reference storageReferenceFromUrl =
        FirebaseStorage.instance.refFromURL(photoPath);

    try {
      await storageReferenceFromUrl
          .delete()
          .then((success) => debugPrint('Success'))
          .onError((error, stackTrace) =>
              debugPrint('Deleting Photo Error: $error'));
    } on Exception catch (error) {
      debugPrint('Deleting Photo Error: $error');
    }
  }
}
