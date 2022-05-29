import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageService {
  late final ImagePicker _imagePicker;
  Future<String?> Function(File image)? uploadImage;
  Future<void> Function(File image)? storeImage;
  bool compress = false;

  ImageService() {
    _imagePicker = ImagePicker();
  }

  ///
  /// pick image with specific source [ImageSource.camera] or [ImageSource.gallery]
  /// [uploadImage] return url image after upload success and null if failed.
  /// [storeImage] return path image if store success and null if failed
  ///

  Future<File?> pickImage(
    ImageSource source, {
    Future<String?> Function(File image)? storeImage,
  }) async {
    this.storeImage = storeImage;

    final pickImage = await _imagePicker.pickImage(source: source);

    if (pickImage == null) {
      return null;
    }

    File? image;

    image = File(pickImage.path);

    if (storeImage != null) {
      storeImage(image);
    }

    return image;
  }
}
