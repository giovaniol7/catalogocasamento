import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../controllers/variaveis.dart';
import '../widgets/mensagem.dart';
import 'fireAuth.dart';
import 'fireCloudNoivos.dart';

/*Future<String> retornarIDConvidados() async {
  String id = '';
  String nomeColecaoNoivos = await retornarProdutoNomeNoivos();

  await FirebaseFirestore.instance
      .collection(nomeColecaoNoivos)
      .where('uid', isEqualTo: idNoivos())
      .get()
      .then((q) {
    if (q.docs.isNotEmpty) {
      id = q.docs[0].id;
    }
  });

  return id;
}*/

adicionarConvidados(context, nomeConvidado, telefoneConvidado, nomeNoivos, uidProdutoNoivos) async {
  try {
    String uidNoivos = await retornarIDNoivosPorNome(nomeNoivos);
    String uidConvidado = '';
    String nomeColecaoConvidadosNoivos = 'convidados$nomeNoivos';
    String nomeColecaoProdutosNoivos = 'produtos$nomeNoivos';
    CollectionReference convidadosNoivos =
        FirebaseFirestore.instance.collection(nomeColecaoConvidadosNoivos);

    Map<String, dynamic> data = {
      'uidNoivos': uidNoivos,
      'uidProdutoNoivos': uidProdutoNoivos,
      'nomeConvidado': nomeConvidado,
      'telefoneConvidado': telefoneConvidado
    };

    DocumentReference novoDocumento = await convidadosNoivos.add(data);
    print("Convidado adicionado com sucesso: ${novoDocumento.id}");
    await convidadosNoivos.where('nomeConvidado', isEqualTo: nomeConvidado).get().then((us) {
      if (us.docs.isNotEmpty) {
        uidConvidado = us.docs[0].id;
      } else {
        throw Exception('Convidado não encontrado após a adição.');
      }
    });

    await novoDocumento.update({'uidConvidado': uidConvidado});
    print("ID do convidado atualizado com sucesso: $uidConvidado");

    editarConvidadosProdutosNoivos(context, nomeColecaoProdutosNoivos, uidProdutoNoivos);

    sucesso(context, 'O Produto reservado com sucesso!');
    AppVariaveis().reset();
    Navigator.of(context).popUntil((route) => route.isFirst);
  } catch (e) {
    print('Erro ao reservar produto.');
    erro(context, 'Erro ao reservar produto. Tente novamente.');
  }
}

recuperarConvidadosPorIdProduto(idProduto) async {
  String uidConvidado = '';
  String uidNoivos = '';
  String uidProdutoNoivos = '';
  String nomeConvidado = '';
  String telefoneConvidado = '';
  Map<String, String> convidadoNoivos = {};
  String nomeNoivos = await retornarNomeNoivosPorID(idNoivos());
  String nomeColecaoNoivos = 'convidados$nomeNoivos';

  await FirebaseFirestore.instance
      .collection(nomeColecaoNoivos)
      .where('uidProdutoNoivos', isEqualTo: idProduto)
      .get()
      .then((q) {
    if (q.docs.isNotEmpty) {
      uidConvidado = q.docs[0].id;
      uidNoivos = q.docs[0].data()['uidNoivos'];
      uidProdutoNoivos = q.docs[0].data()['uidProdutoNoivos'];
      nomeConvidado = q.docs[0].data()['nomeConvidado'];
      telefoneConvidado = q.docs[0].data()['telefoneConvidado'];
    }
  });

  convidadoNoivos = {
    'uidConvidado': uidConvidado,
    'uidNoivos': uidNoivos,
    'uidProdutoNoivos': uidProdutoNoivos,
    'nomeConvidado': nomeConvidado,
    'telefoneConvidado': telefoneConvidado
  };

  return convidadoNoivos;
}

editarConvidadosProdutosNoivos(context, nomeColecaoProdutosNoivos, uidProdutoNoivos) async {
  var varAtivoProduto = "0";

  Map<String, dynamic> data = {'varAtivoProduto': varAtivoProduto};
  await FirebaseFirestore.instance
      .collection(nomeColecaoProdutosNoivos)
      .doc(uidProdutoNoivos)
      .update(data);
}
