import 'package:catalogocasamento/widgets/mensagem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../connections/fireAuth.dart';
import '../connections/fireCloudNoivos.dart';
import '../controllers/estilos.dart';
import '../controllers/variaveis.dart';
import 'TextFormField.dart';

Widget cardNoivos(context, doc) {
  double escala = calcularEscala(context);

  return GestureDetector(
    onTap: () {
      if (idNoivos() == doc.data()['uidNoivos']) {
        Navigator.pushNamed(context, '/produtosNoivos', arguments: {
          'nomeNoiva': doc.data()['nomeNoiva'],
          'nomeNoivo': doc.data()['nomeNoivo'],
          'idNoivos': doc.data()['uidNoivos']
        });
      } else {
        showSenhaProduto(context, doc);
      }
    },
    child: Card(
        clipBehavior: Clip.antiAlias,
        color: AppEstilo().colorCard,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.all(5),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.only(right: 12.0),
              decoration: const BoxDecoration(
                  border: Border(right: BorderSide(width: 1.0, color: Colors.deepPurple))),
              child: doc.data()['urlImageNoivos'].toString().isNotEmpty
                  ? Image.network(doc.data()['urlImageNoivos'], scale: escala)
                  : Image.asset('lib/assets/icon/couple.png', scale: escala),
            ),
            Expanded(
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                title: Text(
                  "${doc.data()['nomeNoiva']} & ${doc.data()['nomeNoivo']}",
                  style: AppEstilo().estiloCardTitulo,
                ),
                subtitle: Text(
                  doc.data()['dtCasamento'],
                  style: AppEstilo().estiloCardSubtitulo,
                ),
              ),
            )
          ],
        )),
  );
}

void showSenhaProduto(context, doc) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final _formKey = GlobalKey<FormState>();
      bool validarCampos() {
        return _formKey.currentState!.validate();
      }

      return AlertDialog(
        title: const Text('Senha dos Noivos'),
        content: Form(
            key: _formKey,
            child: Consumer<AppVariaveis>(builder: (context, appVariaveis, child) {
              return textFormField(
                'Senha',
                AppVariaveis().txtSenhaProdutos,
                icone: Icons.lock,
                key: AppVariaveis().keySenhaProdutos,
                validator: true,
                sufIcon: IconButton(
                  icon: Icon(
                    AppVariaveis().obscureText3 ? Icons.visibility_off : Icons.visibility,
                    color: AppEstilo().colorIconPadrao,
                  ),
                  onPressed: () {
                    AppVariaveis().toggleObscureText3();
                  },
                ),
                senha: AppVariaveis().obscureText3,
              );
            })),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancelar', style: AppEstilo().estiloTextoPadrao),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(Colors.white70),
            ),
            onPressed: () async {
              if (validarCampos()) {
                var noivos = await listarNoivosPorID(doc.data()['uidNoivos']);
                var senhaProdutos = noivos['senhaProdutos']!;
                if (AppVariaveis().txtSenhaProdutos.text == senhaProdutos) {
                  AppVariaveis().reset();
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/produtosNoivos', arguments: {
                    'nomeNoiva': doc.data()['nomeNoiva'],
                    'nomeNoivo': doc.data()['nomeNoivo'],
                    'idNoivos': doc.data()['uidNoivos']
                  });
                } else {
                  erro(context, 'Senha incorreta!');
                  AppVariaveis().reset();
                }
              }
            },
            child: Text('Entrar', style: AppEstilo().estiloTextoPadrao),
          ),
        ],
      );
    },
  );
}
