import 'dart:io';

import 'package:coffee_shop/data/models/universal_data.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

Future<UniversalData> imageUploader(XFile xFile) async {
  String downloadUrl = "";
  try {
    final storageRef = FirebaseStorage.instance.ref();
    var imageRef = storageRef.child("images/coffeeImages/${xFile.name}");
    await imageRef.putFile(File(xFile.path));
    downloadUrl = await imageRef.getDownloadURL();
    return UniversalData(data: downloadUrl);
  } catch (error) {
    return UniversalData(error: error.toString());
  }
}
