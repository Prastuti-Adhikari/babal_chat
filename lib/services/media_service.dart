import 'dart:io';
import 'dart:typed_data'; // Add this import
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart';

class MediaService {
  final ImagePicker _picker = ImagePicker();

  MediaService();

  Future<dynamic> getImageFromGallery() async {
    if (kIsWeb) {
      final Uint8List? bytes = await ImagePickerWeb.getImageAsBytes();
      if (bytes != null) {
        return bytes;
      }
    } else {
      final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        return File(file.path);
      }
    }
    return null;
  }
}
