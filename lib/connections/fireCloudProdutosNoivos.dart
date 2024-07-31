import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../controllers/variaveis.dart';
import '../widgets/mensagem.dart';
import 'fireAuth.dart';
import 'fireCloudNoivos.dart';

Future<String> retornarIDProdutosNoivos(uidProdutoNoivos) async {
  String id = '';
  String nomeColecaoProdutosNoivos = await retornarProdutoNomeNoivos();

  await FirebaseFirestore.instance
      .collection(nomeColecaoProdutosNoivos)
      .where('uidProdutoNoivos', isEqualTo: uidProdutoNoivos)
      .get()
      .then((q) {
    if (q.docs.isNotEmpty) {
      id = q.docs[0].id;
    }
  });

  return id;
}

adicionarProdutosNoivos(context, urlImageProduto, nomeProduto, precoProduto, marcaProduto,
    lojaSiteProduto, descricaoProduto, qtdCotaProduto, qtdCotaProdutoVenda, valorCotaProduto, varAtivoProduto) async {
  try {
    String nomeColecaoProdutosNoivos = await retornarProdutoNomeNoivos();
    CollectionReference produtoNoivos = FirebaseFirestore.instance.collection(nomeColecaoProdutosNoivos);
    DocumentReference novoDocumento;
    String uidProdutoNoivos = '';
    Map<String, dynamic> data = {
      'uidNoivos': idNoivos(),
      'urlImageProduto': urlImageProduto,
      'nomeProduto': nomeProduto,
      'precoProduto': precoProduto,
      'marcaProduto': marcaProduto,
      'lojaSiteProduto': lojaSiteProduto,
      'descricaoProduto': descricaoProduto,
      'qtdCotaProduto': qtdCotaProduto,
      'qtdCotaProdutoVenda': qtdCotaProdutoVenda,
      'valorCotaProduto': valorCotaProduto,
      'varAtivoProduto': varAtivoProduto
    };

    novoDocumento = await produtoNoivos.add(data);
    await FirebaseFirestore.instance
        .collection(nomeColecaoProdutosNoivos)
        .where('nomeProduto', isEqualTo: nomeProduto)
        .get()
        .then((us) {
      uidProdutoNoivos = us.docs[0].id;
    });
    await novoDocumento.update({'uidProdutoNoivos': uidProdutoNoivos});
    sucesso(context, 'O produto foi adicionado com sucesso.');
    AppVariaveis().reset();
    Navigator.pop(context);
  } catch (e) {
    print('Erro ao adicionar produto.');
  }
}

editarProdutosNoivos(context, uidProdutoNoivos, urlImageProduto, nomeProduto, precoProduto, marcaProduto,
    lojaSiteProduto, descricaoProduto, qtdCotaProduto, qtdCotaProdutoVenda, valorCotaProduto, varAtivoProduto) async {
  String nomeColecaoProdutosNoivos = await retornarProdutoNomeNoivos();

  Map<String, dynamic> data = {
    'uidNoivos': idNoivos(),
    'urlImageProduto': urlImageProduto,
    'nomeProduto': nomeProduto,
    'precoProduto': precoProduto,
    'marcaProduto': marcaProduto,
    'lojaSiteProduto': lojaSiteProduto,
    'descricaoProduto': descricaoProduto,
    'qtdCotaProduto': qtdCotaProduto,
    'qtdCotaProdutoVenda': qtdCotaProdutoVenda,
    'valorCotaProduto': valorCotaProduto,
    'varAtivoProduto': varAtivoProduto
  };

  await FirebaseFirestore.instance.collection(nomeColecaoProdutosNoivos).doc(uidProdutoNoivos).update(data);
  sucesso(context, 'O produto foi editado com sucesso.');
  AppVariaveis().reset();
  Navigator.of(context).popUntil((route) => route.isFirst);
}

Future<Map<String, String>> listarProdutosNoivos(uidProdutoNoivos) async {
  String id = '';
  String uidNoivos = '';
  String urlImageProduto = '';
  String nomeProduto = '';
  String precoProduto = '';
  String marcaProduto = '';
  String lojaSiteProduto = '';
  String descricaoProduto = '';
  String qtdCotaProduto = '';
  String qtdCotaProdutoVenda = '';
  String valorCotaProduto = '';
  String varAtivoProduto = '';
  Map<String, String> produtoNoivos = {};
  String nomeColecaoProdutosNoivos = await retornarProdutoNomeNoivos();

  await FirebaseFirestore.instance
      .collection(nomeColecaoProdutosNoivos)
      .where('uidProdutoNoivos', isEqualTo: uidProdutoNoivos)
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
      qtdCotaProduto = q.docs[0].data()['qtdCotaProduto'];
      qtdCotaProdutoVenda = q.docs[0].data()['qtdCotaProdutoVenda'];
      valorCotaProduto = q.docs[0].data()['valorCotaProduto'];
      varAtivoProduto = q.docs[0].data()['varAtivoProduto'];
    }
  });

  produtoNoivos = {
    'uidProdutoNoivos': id,
    'uidNoivos': uidNoivos,
    'urlImageProduto': urlImageProduto,
    'nomeProduto': nomeProduto,
    'precoProduto': precoProduto,
    'marcaProduto': marcaProduto,
    'lojaSiteProduto': lojaSiteProduto,
    'descricaoProduto': descricaoProduto,
    'qtdCotaProduto': qtdCotaProduto,
    'qtdCotaProdutoVenda': qtdCotaProdutoVenda,
    'valorCotaProduto': valorCotaProduto,
    'varAtivoProduto': varAtivoProduto
  };

  return produtoNoivos;
}

recuperarPorIDProdutosNoivos() async {
  String id = '';
  String uidNoivos = '';
  String urlImageProduto = '';
  String nomeProduto = '';
  String precoProduto = '';
  String marcaProduto = '';
  String lojaSiteProduto = '';
  String descricaoProduto = '';
  String qtdCotaProduto = '';
  String qtdCotaProdutoVenda = '';
  String valorCotaProduto = '';
  String varAtivoProduto = '';
  Map<String, String> produtoNoivos = {};
  String nomeColecaoProdutosNoivos = await retornarProdutoNomeNoivos();

  await FirebaseFirestore.instance
      .collection(nomeColecaoProdutosNoivos)
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
      qtdCotaProduto = q.docs[0].data()['qtdCotaProduto'];
      qtdCotaProdutoVenda = q.docs[0].data()['qtdCotaProdutoVenda'];
      valorCotaProduto = q.docs[0].data()['valorCotaProduto'];
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
    'qtdCotaProduto': qtdCotaProduto,
    'qtdCotaProdutoVenda': qtdCotaProdutoVenda,
    'valorCotaProduto': valorCotaProduto,
    'varAtivoProduto': varAtivoProduto
  };

  return produtoNoivos;
}

recuperarProdutosNoivosEspecifico(context, nomeColecaoProdutosNoivos, uidProdutoNoivos) async {
  String id = '';
  String uidNoivos = '';
  String urlImageProduto = '';
  String nomeProduto = '';
  String precoProduto = '';
  String marcaProduto = '';
  String lojaSiteProduto = '';
  String descricaoProduto = '';
  String qtdCotaProduto = '';
  String qtdCotaProdutoVenda = '';
  String valorCotaProduto = '';
  String varAtivoProduto = '';
  Map<String, String> produtoNoivos = {};

  await FirebaseFirestore.instance
      .collection(nomeColecaoProdutosNoivos)
      .where('uidProdutoNoivos', isEqualTo: uidProdutoNoivos)
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
      qtdCotaProduto = q.docs[0].data()['qtdCotaProduto'];
      qtdCotaProdutoVenda = q.docs[0].data()['qtdCotaProdutoVenda'];
      valorCotaProduto = q.docs[0].data()['valorCotaProduto'];
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
    'qtdCotaProduto': qtdCotaProduto,
    'qtdCotaProdutoVenda': qtdCotaProdutoVenda,
    'valorCotaProduto': valorCotaProduto,
    'varAtivoProduto': varAtivoProduto
  };

  return produtoNoivos;
}

apagarProdutoNoivos(context, id) async {
  try {
    String nomeColecaoProdutosNoivos = await retornarProdutoNomeNoivos();

    await FirebaseFirestore.instance.collection(nomeColecaoProdutosNoivos).doc(id).delete();
    sucesso(context, 'Produto apagado com sucesso!');
    Navigator.of(context).pop();
  } catch (e) {
    erro(context, 'Erro ao remover a prontuário.');
  }
}