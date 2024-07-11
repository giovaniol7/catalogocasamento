import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../controllers/variaveis.dart';
import '../widgets/mensagem.dart';
import 'fireAuth.dart';
import 'fireCloudNoivos.dart';
import 'fireCloudProdutosNoivos.dart';

Future<String> retornarIDConvidados() async {
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
}

adicionarConvidados(context, nomeConvidado, telefoneConvidado, nomeNoivos, uidProdutoNoivos) async {
  try {
    String uidNoivos = await retornarIDNoivosPorNome(nomeNoivos);
    String uidConvidado = '';
    String nomeColecaoConvidadosNoivos = 'convidados$nomeNoivos';
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

    var varAtivoProduto = 0;
    await editarConvidadosProdutosNoivos(context, uidProdutoNoivos, varAtivoProduto);

    sucesso(context, 'O Produto reservado com sucesso!');
    AppVariaveis().reset();
    Navigator.pop(context);
  } catch (e) {
    print('Erro ao reservar produto.');
    erro(context, 'Erro ao reservar produto. Tente novamente.');
  }
}

editarConvidados(context, urlImageProduto, nomeProduto, precoProduto, marcaProduto, lojaSiteProduto,
    descricaoProduto, varAtivoProduto) async {
  String nomeColecaoNoivos = await retornarProdutoNomeNoivos();

  Map<String, dynamic> data = {
    'uidNoivos': idNoivos(),
    'urlImageProduto': urlImageProduto,
    'nomeProduto': nomeProduto,
    'precoProduto': precoProduto,
    'marcaProduto': marcaProduto,
    'lojaSiteProduto': lojaSiteProduto,
    'descricaoProduto': descricaoProduto,
    'varAtivoProduto': varAtivoProduto
  };
  String id = await retornarIDConvidados();
  await FirebaseFirestore.instance.collection(nomeColecaoNoivos).doc(id).update(data);
  sucesso(context, 'O produto foi editado com sucesso.');
  AppVariaveis().reset();
  Navigator.pop(context);
}

Future<Map<String, String>> listarConvidados() async {
  String id = '';
  String uidNoivos = '';
  String urlImageProduto = '';
  String nomeProduto = '';
  String precoProduto = '';
  String marcaProduto = '';
  String lojaSiteProduto = '';
  String descricaoProduto = '';
  String varAtivoProduto = '';
  Map<String, String> produtoNoivos = {};
  String nomeColecaoNoivos = await retornarProdutoNomeNoivos();

  await FirebaseFirestore.instance
      .collection(nomeColecaoNoivos)
      .where('uid', isEqualTo: idNoivos())
      .get()
      .then((q) {
    if (q.docs.isNotEmpty) {
      id = q.docs[0].id;
      uidNoivos = q.docs[0].data()['uidNoivos'];
      urlImageProduto = q.docs[0].data()['urlImageProduto'];
      nomeProduto = q.docs[0].data()['nomeProduto'];
      precoProduto = q.docs[0].data()['precoProduto'];
      marcaProduto = q.docs[0].data()['marcaProduto'];
      lojaSiteProduto = q.docs[0].data()['lojaSiteProduto'];
      descricaoProduto = q.docs[0].data()['descricaoProduto'];
      varAtivoProduto = q.docs[0].data()['varAtivoProduto'];
    }
  });

  produtoNoivos = {
    'id': id,
    'uid': uidNoivos,
    'urlImageProduto': urlImageProduto,
    'nomeProduto': nomeProduto,
    'precoProduto': precoProduto,
    'marcaProduto': marcaProduto,
    'lojaSiteProduto': lojaSiteProduto,
    'descricaoProduto': descricaoProduto,
    'varAtivoProduto': varAtivoProduto
  };
  return produtoNoivos;
}

recuperarPorIDConvidados() async {
  String id = '';
  String uidNoivos = '';
  String urlImageProduto = '';
  String nomeProduto = '';
  String precoProduto = '';
  String marcaProduto = '';
  String lojaSiteProduto = '';
  String descricaoProduto = '';
  String varAtivoProduto = '';
  Map<String, String> produtoNoivos = {};
  String nomeColecaoNoivos = await retornarProdutoNomeNoivos();

  await FirebaseFirestore.instance
      .collection(nomeColecaoNoivos)
      .where('uid', isEqualTo: idNoivos())
      .get()
      .then((q) {
    if (q.docs.isNotEmpty) {
      id = q.docs[0].id;
      uidNoivos = q.docs[0].data()['uidNoivos'];
      urlImageProduto = q.docs[0].data()['urlImageProduto'];
      nomeProduto = q.docs[0].data()['nomeProduto'];
      precoProduto = q.docs[0].data()['precoProduto'];
      marcaProduto = q.docs[0].data()['marcaProduto'];
      lojaSiteProduto = q.docs[0].data()['lojaSiteProduto'];
      descricaoProduto = q.docs[0].data()['descricaoProduto'];
      varAtivoProduto = q.docs[0].data()['varAtivoProduto'];
    }
  });

  produtoNoivos = {
    'id': id,
    'uid': uidNoivos,
    'urlImageProduto': urlImageProduto,
    'nomeProduto': nomeProduto,
    'precoProduto': precoProduto,
    'marcaProduto': marcaProduto,
    'lojaSiteProduto': lojaSiteProduto,
    'descricaoProduto': descricaoProduto,
    'varAtivoProduto': varAtivoProduto
  };

  return produtoNoivos;
}

editarConvidadosProdutosNoivos(context, uidProdutoNoivos, varAtivoProduto) async {
  String nomeColecaoNoivos = await retornarProdutoNomeNoivos();

  Map<String, dynamic> data = {'varAtivoProduto': varAtivoProduto};
  String id = await retornarIDProdutosNoivos(uidProdutoNoivos);
  await FirebaseFirestore.instance.collection(nomeColecaoNoivos).doc(id).update(data);
}
