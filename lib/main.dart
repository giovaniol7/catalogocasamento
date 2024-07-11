import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import '../controllers/variaveis.dart';
import '../view/TelaLogin.dart';
import '../view/TelaCadastro.dart';
import '../view/TelaEditarPerfil.dart';
import '../view/TelaResetSenha.dart';
import '../view/TelaInicial.dart';
import '../view/TelaProdutosNoivos.dart';
import '../view/TelaAdicionarProdutosNoivos.dart';
import '../view/TelaEditarProdutosNoivos.dart';
import '../view/TelaProdutoDetalhe.dart';

void main() async {
  String? token;

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final tokenSave = await SharedPreferences.getInstance();
  token = tokenSave.getString('token');

  runApp(ChangeNotifierProvider(
    create: (context) => AppVariaveis(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Catalogo de Casamanto',
      initialRoute: '/home',
      routes: {
        '/login': (context) => const TelaLogin(),
        '/cadastroPerfil': (context) => const TelaCadastro(),
        '/editarPerfil': (context) => const TelaEditarPerfil(),
        '/resetSenha': (context) => TelaResetSenha(),
        '/home': (context) => TelaInicial(),
        '/produtosNoivos': (context) => const TelaProdutosNoivos(),
        '/adicionarProdutosNoivos': (context) => const TelaAdicionarProdutosNoivos(),
        '/editarProdutosNoivos': (context) => const TelaEditarProdutosNoivos(),
        '/produtoDetalhe': (context) => const TelaProdutoDetalhe(),
      },
    )),
  );
}
