import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jogingu_advanced/domain/common/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class AvatarPicker {
  static Future<File?> pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return null;
      return saveImage(image.path);
    } on PlatformException catch (e) {
      Logger.error(message: e.toString());
    }
  }

  static Future<File> saveImage(String path) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(path);
    final image = File('${directory.path}/$name');
    return File(path).copy(image.path);
  }
}
