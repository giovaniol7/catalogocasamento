import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'sharedPreference.dart';
import 'fireCloudNoivos.dart';
import '../controllers/variaveis.dart';
import '../widgets/mensagem.dart';

idNoivos() {
  try {
    return FirebaseAuth.instance.currentUser?.uid;
  } catch (e) {
    print("Erro ao obter o ID do usuário: $e");
    return null;
  }
}

criarContaNoivos(context, urlImage, nomeNoiva, nomeNoivo, dtCasamento, email, telefone, senha, varAtivoNoivos) async {
  FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: senha).then((res) {
    adicionarNoivos(context, res.user!.uid.toString(), urlImage, nomeNoiva, nomeNoivo, dtCasamento,
        email, telefone, senha, varAtivoNoivos);
    sucesso(context, 'O cadastro foi criado com sucesso!');
    AppVariaveis().reset();
    Navigator.pop(context);
  }).catchError((e) {
    switch (e.code) {
      case 'email-already-in-use':
        erro(context, 'O email já foi cadastrado.');
        break;
      case 'invalid-email':
        erro(context, 'O formato do email é inválido.');
        break;
      default:
        erro(context, e.code.toString());
    }
  });
}

autenticarContaNoivos(context, email, senha) async {
  if (email.isNotEmpty && senha.isNotEmpty) {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: senha)
        .then((res) {
      sucesso(context, 'Usuário autenticado com sucesso!');
      saveValor();
      AppVariaveis().reset();
      Navigator.pushNamedAndRemoveUntil(context, '/home', (Route<dynamic> route) => false);
    }).catchError((e) {
      switch (e.code) {
        case 'invalid-email':
          erro(context, 'O formato do email é inválido.');
          break;
        case 'user-not-found':
          erro(context, 'Usuário não encontrado.');
          break;
        case 'wrong-password':
          erro(context, 'Senha incorreta.');
          break;
        default:
          print(e.code.toString());
          erro(context, e.code.toString());
      }
    });
  }
}

signOutNoivos(context) async {
  try {
    await FirebaseAuth.instance.signOut();
    deleteValor();
    sucesso(context, 'O usuário deslogado!');
    Navigator.pushNamedAndRemoveUntil(context, '/home', (Route<dynamic> route) => false);
  } catch (e) {
    print(e.toString());
    return null;
  }
}
