import 'package:catalogocasamento/connections/fireAuth.dart';
import 'package:catalogocasamento/controllers/variaveis.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/estilos.dart';

import '../widgets/TextFormField.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({Key? key}) : super(key: key);

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
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
        decoration: AppEstilo().decoracaoContainerGradiente,
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Catálogo de Casamento",
                    style: AppEstilo().estiloTituloItalico,
                  ),
                ),
                const SizedBox(height: 20),
                textFormField("E-mail", AppVariaveis().txtEmail,
                    boardType: TextInputType.emailAddress),
                const SizedBox(height: 10),
                Consumer<AppVariaveis>(
                  builder: (context, appVariaveis, child) {
                    return textFormField(
                      "Senha",
                      appVariaveis.txtSenha,
                      sufIcon: IconButton(
                        icon: Icon(
                          appVariaveis.obscureText ? Icons.visibility_off : Icons.visibility,
                          color: AppEstilo().colorIconPadrao,
                        ),
                        onPressed: () {
                          appVariaveis.toggleObscureText();
                        },
                      ),
                      senha: appVariaveis.obscureText,
                    );
                  },
                ),
                Container(
                  height: 40,
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: Text(
                      "Recuperar Senha",
                      style: AppEstilo().estiloTextoSublimado,
                    ),
                    onPressed: () {
                      AppVariaveis().reset();
                      Navigator.pushNamed(context, '/resetSenha');
                    },
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  height: 60,
                  alignment: Alignment.centerLeft,
                  decoration: AppEstilo().decoracaoBotaoGradiente,
                  child: SizedBox.expand(
                    child: TextButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Login",
                            style: AppEstilo().estiloTextoBotaoGradiente,
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 28,
                            width: 28,
                            child: Icon(Icons.login, color: AppEstilo().colorIconPadrao),
                          ),
                        ],
                      ),
                      onPressed: () => {
                        autenticarContaNoivos(
                            context, AppVariaveis().txtEmail.text, AppVariaveis().txtSenha.text)
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Não possui Cadastro?", style: AppEstilo().estiloTextoPadrao),
                    TextButton(
                      child: Text(
                        "Cadastre-se",
                        textAlign: TextAlign.center,
                        style: AppEstilo().estiloTextoNegritoSublimado,
                      ),
                      onPressed: () {
                        AppVariaveis().reset();
                        Navigator.pushNamed(context, '/cadastroPerfil');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
