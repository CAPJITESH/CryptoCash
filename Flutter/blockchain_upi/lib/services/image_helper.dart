import 'dart:io';

import 'package:blockchain_upi/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class ImageHelper {
  final ImagePicker imagePicker = ImagePicker();
  final ImageCropper imageCroper = ImageCropper();

  Future<XFile?> getImage() async {
    try {
      return await imagePicker.pickImage(
          source: ImageSource.gallery, imageQuality: 100);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<File?> crop(XFile file, CropStyle style) async {
    var result = await imageCroper.cropImage(
        sourcePath: file.path,
        compressQuality: 100,
        cropStyle: style,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.black,
            backgroundColor: bg1,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ]);

    return result == null ? null : File(result.path);
  }
}
