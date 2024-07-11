import 'dart:io';

import 'package:flutter/material.dart';

class AppVariaveis extends ChangeNotifier {
  static final AppVariaveis _instance = AppVariaveis._internal();

  factory AppVariaveis() {
    return _instance;
  }

  AppVariaveis._internal();

  //Noivos
  TextEditingController txtNomeNoiva = TextEditingController();
  TextEditingController txtNomeNoivo = TextEditingController();
  TextEditingController txtDtCasamento = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtTelefone = TextEditingController();
  TextEditingController txtSenha = TextEditingController();
  TextEditingController txtSenhaCofirmar = TextEditingController();
  GlobalKey<FormState> keyNomeNoiva = GlobalKey<FormState>();
  GlobalKey<FormState> keyNomeNoivo = GlobalKey<FormState>();
  GlobalKey<FormState> keyDtCasamento = GlobalKey<FormState>();
  GlobalKey<FormState> keyEmail = GlobalKey<FormState>();
  GlobalKey<FormState> keyTelefone = GlobalKey<FormState>();
  GlobalKey<FormState> keySenha = GlobalKey<FormState>();
  GlobalKey<FormState> keySenhaConfirmar = GlobalKey<FormState>();
  String urlImageNoivos = '';
  String urlImageNoivosTemp = '';
  String UIDNoivos = '';
  String IDNoivos = '';
  String nomeNOIVOS = '';
  var fileImageNoivos;
  var varAtivoNoivos;

  //Produtos
  TextEditingController txtNomeProduto = TextEditingController();
  TextEditingController txtPrecoProduto = TextEditingController();
  TextEditingController txtMarcaProduto = TextEditingController();
  TextEditingController txtLojaSiteProduto = TextEditingController();
  TextEditingController txtDescricaoProduto = TextEditingController();
  GlobalKey<FormState> keyNomeProduto = GlobalKey<FormState>();
  GlobalKey<FormState> keyPrecoProduto = GlobalKey<FormState>();
  GlobalKey<FormState> keyMarcaProduto = GlobalKey<FormState>();
  GlobalKey<FormState> keyLojaSiteProduto = GlobalKey<FormState>();
  GlobalKey<FormState> keyDescricaoProduto = GlobalKey<FormState>();
  String urlImageProduto = '';
  String urlImageProdutoTemp = '';
  String uidProdutoNoivos = '';
  var fileImageProduto;
  var varAtivoProduto;

  //Convidados
  TextEditingController txtNomeConvidado = TextEditingController();
  TextEditingController txtTelefoneConvidado = TextEditingController();
  GlobalKey<FormState> keyNomeConvidado = GlobalKey<FormState>();
  GlobalKey<FormState> keyTelefoneConvidado = GlobalKey<FormState>();

  // Outras variáveis
  bool boolApagarImagem = false;
  bool obscureText = true;
  bool obscureText2 = true;

  //Função
  void toggleObscureText() {
    obscureText = !obscureText;
    notifyListeners();
  }

  void toggleObscureText2() {
    obscureText2 = !obscureText2;
    notifyListeners();
  }

  /* void adicionarImagem(File imagem) {
    listaImagensProduto.add(imagem);
    notifyListeners();
  }

  void removerImagem(int indice) {
    listaImagensProduto.removeAt(indice);
    notifyListeners();
  }*/

  //Reset
  void reset() {
    //Noivos
    txtEmail.clear();
    txtSenha.clear();
    txtNomeNoiva.clear();
    txtNomeNoivo.clear();
    txtDtCasamento.clear();
    txtTelefone.clear();
    txtSenhaCofirmar.clear();
    varAtivoNoivos = 1;
    urlImageNoivos = '';
    fileImageNoivos = null;
    //Produto
    txtNomeProduto.clear();
    txtPrecoProduto.clear();
    txtMarcaProduto.clear();
    txtLojaSiteProduto.clear();
    txtDescricaoProduto.clear();
    varAtivoProduto = 1;
    urlImageProduto = '';
    fileImageProduto = null;

    boolApagarImagem = false;
    obscureText = true;
    obscureText2 = true;
    notifyListeners();
  }
}

double calcularEscala (context){
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  if (screenWidth < 700) {
    double width = screenWidth;
    double height = screenHeight / 8;
    return width / height;
  } else {
    double width = screenWidth;
    double height = screenHeight / 5;
    return width / height;
  }
}
