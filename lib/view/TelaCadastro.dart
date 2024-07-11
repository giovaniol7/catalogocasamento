import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:provider/provider.dart';

import '../widgets/TextFormField.dart';
import '../widgets/mensagem.dart';
import '../connections/fireAuth.dart';
import '../controllers/variaveis.dart';
import '../controllers/uploadImageNoivos.dart';
import '../controllers/estilos.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({Key? key}) : super(key: key);

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final _formKey = GlobalKey<FormState>();

  bool validarCampos() {
    return _formKey.currentState!.validate();
  }

  void verificarSenhas() async {
    if (AppVariaveis().txtNomeNoiva.text.isNotEmpty &&
        AppVariaveis().txtNomeNoivo.text.isNotEmpty &&
        AppVariaveis().txtDtCasamento.text.isNotEmpty &&
        AppVariaveis().txtEmail.text.isNotEmpty &&
        AppVariaveis().txtTelefone.text.isNotEmpty &&
        AppVariaveis().txtSenha.text.isNotEmpty &&
        AppVariaveis().txtSenhaCofirmar.text.isNotEmpty) {
      if (AppVariaveis().txtEmail.text.contains('@')) {
        if (AppVariaveis().txtSenha.text != AppVariaveis().txtSenhaCofirmar.text) {
          erro(context, 'Senhas não coincidem.');
        } else if (AppVariaveis().txtSenha.text.length >= 6) {
          AppVariaveis().urlImageNoivos = (AppVariaveis().fileImageNoivos != null
              ? await uploadImageNoivos(AppVariaveis().fileImageNoivos!, 'noivos')
              : '')!;

          criarContaNoivos(
              context,
              AppVariaveis().urlImageNoivos,
              AppVariaveis().txtNomeNoiva.text,
              AppVariaveis().txtNomeNoivo.text,
              AppVariaveis().txtDtCasamento.text,
              AppVariaveis().txtEmail.text,
              AppVariaveis().txtTelefone.text,
              AppVariaveis().txtSenha.text,
              AppVariaveis().varAtivoNoivos);
        } else {
          erro(context, 'Senha deve possuir mais de 6 caracteres.');
        }
      } else {
        erro(context, 'Formato de e-mail inválido.');
      }
    } else {
      erro(context, 'Preencha corretamente todos os campos.');
    }
  }

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
        padding: const EdgeInsets.only(left: 40, right: 40),
        decoration: AppEstilo().decoracaoContainerGradiente,
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Center(
                    child: Container(
                      width: 200.0,
                      height: 200.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppEstilo().colorBackgroundImage,
                      ),
                      child: InkWell(
                        onTap: () async {
                          var image = await pickedImageNoivos();
                          setState(() {
                            AppVariaveis().fileImageNoivos = image!;
                          });
                        },
                        child: AppVariaveis().fileImageNoivos == null
                            ? Icon(Icons.photo, color: AppEstilo().colorIconImage, size: 80.0)
                            : Stack(children: [
                                CircleAvatar(
                                  radius: 100,
                                  backgroundImage: kIsWeb
                                      ? NetworkImage(AppVariaveis().fileImageNoivos.path)
                                      : FileImage(File((AppVariaveis().fileImageNoivos).path)),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.5),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: AppEstilo().colorIconImage,
                                        size: 40,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          AppVariaveis().urlImageNoivos = '';
                                          AppVariaveis().fileImageNoivos = null;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ]),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: textFormField(
                                  'Nome da Noiva',
                                  AppVariaveis().txtNomeNoiva,
                                  icone: Icons.person,
                                  key: AppVariaveis().keyNomeNoiva,
                                  validator: true,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: textFormField(
                                  'Nome do Noivo',
                                  AppVariaveis().txtNomeNoivo,
                                  icone: Icons.person,
                                  key: AppVariaveis().keyNomeNoivo,
                                  validator: true,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          textFormField(
                            'Data do Casamento',
                            AppVariaveis().txtDtCasamento,
                            icone: Icons.date_range,
                            formato: DataInputFormatter(),
                            boardType: 'numeros',
                            key: AppVariaveis().keyDtCasamento,
                            validator: true,
                          ),
                          const SizedBox(height: 20),
                          textFormField(
                            'Email',
                            AppVariaveis().txtEmail,
                            icone: Icons.email,
                            key: AppVariaveis().keyEmail,
                            validator: true,
                          ),
                          const SizedBox(height: 20),
                          textFormField(
                            'Telefone',
                            AppVariaveis().txtTelefone,
                            icone: Icons.phone,
                            formato: TelefoneInputFormatter(),
                            boardType: 'numeros',
                            key: AppVariaveis().keyTelefone,
                            validator: true,
                          ),
                          const SizedBox(height: 20),
                          Consumer<AppVariaveis>(
                            builder: (context, appVariaveis, child) {
                              return textFormField(
                                'Senha',
                                AppVariaveis().txtSenha,
                                icone: Icons.lock,
                                key: AppVariaveis().keySenha,
                                validator: true,
                                sufIcon: IconButton(
                                  icon: Icon(
                                    AppVariaveis().obscureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: AppEstilo().colorIconPadrao,
                                  ),
                                  onPressed: () {
                                    AppVariaveis().toggleObscureText();
                                  },
                                ),
                                senha: AppVariaveis().obscureText,
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          Consumer<AppVariaveis>(
                            builder: (context, appVariaveis, child) {
                              return textFormField(
                                'Confirmar Senha',
                                AppVariaveis().txtSenhaCofirmar,
                                icone: Icons.lock,
                                key: AppVariaveis().keySenhaConfirmar,
                                validator: true,
                                sufIcon: IconButton(
                                  icon: Icon(
                                    AppVariaveis().obscureText2
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: AppEstilo().colorIconPadrao,
                                  ),
                                  onPressed: () {
                                    AppVariaveis().toggleObscureText2();
                                  },
                                ),
                                senha: AppVariaveis().obscureText2,
                              );
                            },
                          ),
                          const SizedBox(height: 40),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 60,
                                width: 125,
                                alignment: Alignment.center,
                                decoration: AppEstilo().decoracaoBotaoNormal,
                                child: SizedBox.expand(
                                  child: TextButton(
                                    child: Text(
                                      "Criar",
                                      style: AppEstilo().estiloTextoBotaoGradiente,
                                    ),
                                    onPressed: () {
                                      if (validarCampos()) {
                                        verificarSenhas();
                                      }
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Container(
                                height: 60,
                                width: 125,
                                alignment: Alignment.center,
                                decoration: AppEstilo().decoracaoBotaoNormal,
                                child: SizedBox.expand(
                                  child: TextButton(
                                    child: Text(
                                      "Cancelar",
                                      style: AppEstilo().estiloTextoBotaoGradiente,
                                    ),
                                    onPressed: () {
                                      AppVariaveis().reset();
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
