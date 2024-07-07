import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;

class StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  StorageService();

  Future<String?> uploadUserPfp({
    File? file,
    Uint8List? bytes,
    required String uid,
  }) async {
    if (file == null && bytes == null) {
      throw ArgumentError('File and bytes cannot both be null');
    }

    Reference fileRef = _firebaseStorage
      .ref('users/pfps')
      .child('$uid.jpg');

    UploadTask task;
    if (file != null) {
      task = fileRef.putFile(file);
    } else {
      task = fileRef.putData(bytes!);
    }

    TaskSnapshot snapshot = await task;
    if (snapshot.state == TaskState.success) {
      return fileRef.getDownloadURL();
    } else {
      return null;
    }
  }

//   Future<String?> uploadImageToChat({
//     required File file, required String chatID
//   }) async {
//     Reference fileRef = _firebaseStorage
//     .ref('chats/$chatID')
//     .child('${DateTime.now().toIso8601String()}${p.extension(file.path)}');
//   UploadTask task = fileRef.putFile(file);
//   }
 }
