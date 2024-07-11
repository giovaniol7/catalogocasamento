import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

Future<XFile?> pickedImageNoivos() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  return pickedFile;
}

Future<String?> uploadImageNoivos(XFile? pickedFile, String colecao) async {
  if (pickedFile != null) {
    final ref = FirebaseStorage.instance.ref().child('$colecao/${DateTime.now().toString()}');
    UploadTask uploadTask;

    if (kIsWeb) {
      final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': pickedFile.path},
      );

      uploadTask = ref.putData(await pickedFile.readAsBytes(), metadata);
    } else {
      uploadTask = ref.putFile(File(pickedFile.path));
    }

    try {
      await uploadTask;

      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }
  return null;
}

Future<void> deletarImagemNoivosStorage(String caminho) async {
  try {
    Reference referencia = FirebaseStorage.instance.refFromURL(caminho);

    await referencia.delete();
  } catch (e) {
    print('Erro ao deletar imagem do Firebase Storage: $e');
  }
}