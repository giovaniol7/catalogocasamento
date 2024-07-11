import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../controllers/variaveis.dart';
import '../widgets/mensagem.dart';
import 'fireAuth.dart';

String nomeColecao = 'noivos';

Future<String> retornarIDNoivos() async {
  String id = '';

  await FirebaseFirestore.instance
      .collection(nomeColecao)
      .where('uidNoivos', isEqualTo: idNoivos())
      .get()
      .then((q) {
    if (q.docs.isNotEmpty) {
      id = q.docs[0].id;
    }
  });

  return id;
}

Future<String> retornarIDNoivosPorNome(nomeNoivos) async {
  String uidNoivosNoivos = '';

  await FirebaseFirestore.instance
      .collection(nomeColecao)
      .where('nomeNoivos', isEqualTo: nomeNoivos)
      .get()
      .then((q) {
    if (q.docs.isNotEmpty) {
      uidNoivosNoivos = q.docs[0].data()['uidNoivos'];
    }
  });

  return uidNoivosNoivos;
}

Future<String> retornarNomeNoivosPorID(idNoivos) async {
  String nomeNoivos = '';

  await FirebaseFirestore.instance
      .collection(nomeColecao)
      .where('uidNoivos', isEqualTo: idNoivos)
      .get()
      .then((q) {
    if (q.docs.isNotEmpty) {
      nomeNoivos = q.docs[0].data()['nomeNoivos'];
    }
  });

  return nomeNoivos;
}

Future<String> retornarProdutoNomeNoivos() async {
  String nomeNoivos = '';
  String nomeNoiva = '';
  String nomeNoivo = '';
  await FirebaseFirestore.instance
      .collection(nomeColecao)
      .where('uidNoivos', isEqualTo: idNoivos())
      .get()
      .then((q) {
    if (q.docs.isNotEmpty) {
      nomeNoiva = q.docs[0].data()['nomeNoiva'];
      nomeNoivo = q.docs[0].data()['nomeNoivo'];
    }
  });

  String nomeNoivaSemEspacos = nomeNoiva.replaceAll(" ", "");
  String nomeNoivoSemEspacos = nomeNoivo.replaceAll(" ", "");
  nomeNoivos = 'produtos${nomeNoivaSemEspacos}${nomeNoivoSemEspacos}';

  return nomeNoivos;
}

adicionarNoivos(context, res, urlImageNoivos, nomeNoiva, nomeNoivo, dtCasamento, email, telefone,
    senha, varAtivoNoivos) {
  try {
    String nomeNoivaSemEspacos = nomeNoiva.replaceAll(" ", "");
    String nomeNoivoSemEspacos = nomeNoivo.replaceAll(" ", "");
    String nomeNoivos = '${nomeNoivaSemEspacos}${nomeNoivoSemEspacos}';

    FirebaseFirestore.instance.collection(nomeColecao).add({
      'uidNoivos': res,
      'urlImageNoivos': urlImageNoivos,
      'nomeNoiva': nomeNoiva,
      'nomeNoivo': nomeNoivo,
      'nomeNoivos': nomeNoivos,
      'dtCasamento': dtCasamento,
      'email': email,
      'telefone': telefone,
      'varAtivoNoivos': varAtivoNoivos
    });
  } catch (e) {
    erro(context, 'Erro ao Cadastrar.');
  }
}

editarNoivos(context, uidNoivos, urlImageNoivos, nomeNoiva, nomeNoivo, dtCasamento, email, telefone,
    senha, varAtivoNoivos) async {
  if (senha.isNotEmpty) {
    FirebaseAuth.instance.currentUser!.updatePassword(senha);
  }
  Map<String, dynamic> data = {
    'uidNoivos': uidNoivos,
    'urlImageNoivos': urlImageNoivos,
    'nomeNoiva': nomeNoiva,
    'nomeNoivo': nomeNoivo,
    'dtCasamento': dtCasamento,
    'email': email,
    'telefone': telefone,
    'varAtivoNoivos': varAtivoNoivos
  };
  String id = await retornarIDNoivos();
  await FirebaseFirestore.instance.collection(nomeColecao).doc(id).update(data);
  sucesso(context, 'O cadastro foi editado com sucesso!');
  AppVariaveis().reset();
  Navigator.pop(context);
}

Future<Map<String, String>> listarNoivos() async {
  String id = '';
  String uidNoivos = '';
  String urlImageNoivos = '';
  String nomeNoiva = '';
  String nomeNoivo = '';
  String nomeNoivos = '';
  String dtCasamento = '';
  String email = '';
  String telefone = '';
  String varAtivoNoivos = '';
  Map<String, String> noivos = {};

  await FirebaseFirestore.instance
      .collection(nomeColecao)
      .where('uidNoivos', isEqualTo: idNoivos())
      .get()
      .then((q) {
    if (q.docs.isNotEmpty) {
      id = q.docs[0].id;
      uidNoivos = q.docs[0].data()['uidNoivos'];
      urlImageNoivos = q.docs[0].data()['urlImageNoivos'];
      nomeNoiva = q.docs[0].data()['nomeNoiva'];
      nomeNoivo = q.docs[0].data()['nomeNoivo'];
      nomeNoivos = q.docs[0].data()['nomeNoivos'];
      dtCasamento = q.docs[0].data()['dtCasamento'];
      email = q.docs[0].data()['email'];
      telefone = q.docs[0].data()['telefone'];
      varAtivoNoivos = q.docs[0].data()['varAtivoNoivos'];
    }
  });

  noivos = {
    'id': id,
    'uidNoivos': uidNoivos,
    'urlImageNoivos': urlImageNoivos,
    'nomeNoiva': nomeNoiva,
    'nomeNoivo': nomeNoivo,
    'nomeNoivos': nomeNoivos,
    'dtCasamento': dtCasamento,
    'email': email,
    'telefone': telefone,
    'varAtivoNoivos': varAtivoNoivos
  };

  return noivos;
}
