import 'package:catalogocasamento/controllers/estilos.dart';
import 'package:flutter/material.dart';

import '../controllers/variaveis.dart';
import '../widgets/TextFormField.dart';

class TelaResetSenha extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppEstilo().colorAppBar,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: AppEstilo().colorIconPadrao,
          onPressed: () {
            AppVariaveis().reset();
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
          padding: const EdgeInsets.only(top: 20, left: 40, right: 40),
          decoration: AppEstilo().decoracaoContainerGradiente,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: Image.asset("lib/assets/icon/resetpassword.png"),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Esqueceu sua senha?",
                    style: AppEstilo().estiloTituloNormal,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Por favor, informe o e-mail associado a sua conta que enviaremos um link para o mesmo com as intruções para a restauração de sua senha.",
                    style: AppEstilo().estiloTextoPadrao,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  textFormField("E-mail", AppVariaveis().txtEmail,
                      boardType: TextInputType.emailAddress),
                  const SizedBox(height: 20),
                  Container(
                    height: 60,
                    alignment: Alignment.centerLeft,
                    decoration: AppEstilo().decoracaoBotaoGradiente,
                    child: SizedBox.expand(
                      child: TextButton(
                        child: Text(
                          "Enviar",
                          style: AppEstilo().estiloTextoBotaoGradiente,
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          AppVariaveis().reset();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          )),
    );
  }
}
