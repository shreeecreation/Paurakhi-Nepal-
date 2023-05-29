import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class MultipleImageChooser {
    static List<File> images = [];
  
  static Future<List<File>> pickImages(length) async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();

    for (var file in pickedFiles) {
      final img = await cropImage(imageFile: File(file.path));
      images.add(img!);
    }
    length = images.length;
    return images;
  }

  static Future<File?> cropImage({required File imageFile}) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }
}
