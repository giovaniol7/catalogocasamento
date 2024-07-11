import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

Future<XFile?> pickedImageProdutos() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  return pickedFile;
}

Future<String?> uploadImageProdutos(XFile? pickedFile, String colecao) async {
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

    final snapshot = await uploadTask.whenComplete(() => null);
    final url = await snapshot.ref.getDownloadURL();

    return url;
  }
  return null;
}


Future<void> deletarImagemProdutosStorage(String caminho) async {
  try {
    Reference referencia = FirebaseStorage.instance.refFromURL(caminho);

    await referencia.delete();
  } catch (e) {
    print('Erro ao deletar imagem do Firebase Storage: $e');
  }
}