import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImageController {
  final storage = FirebaseStorage.instance;
  final folder = FirebaseFirestore.instance.collection('folder');
  Stream folderStream =
      FirebaseFirestore.instance.collection('folder').snapshots();

  Stream imagesStream(String id) =>
      FirebaseFirestore.instance.collection('folder').doc(id).snapshots();
  Stream images = FirebaseFirestore.instance.collection('images').snapshots();

  bool isAddingFolder = false;
  bool isAddingImage = false;

  Future createFolder(Map<String, dynamic> map) async {
    folder.add(map).then((value) {
      isAddingFolder = false;
    });
  }

  Future addImage(
      File imageFile, DocumentSnapshot data, String title, description) async {
    String imagePath = 'images/${DateTime.now().millisecondsSinceEpoch}.png';
    UploadTask uploadTask =
        FirebaseStorage.instance.ref().child(imagePath).putFile(imageFile);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    final imageData = {
      "title": title,
      "description": description,
      "image": downloadUrl
    };
    await folder.doc(data.reference.id).update({
      "images": FieldValue.arrayUnion([imageData]),
    });
    isAddingImage = false;
  }
}
