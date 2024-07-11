import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../connections/fireCloudNoivos.dart';
import '../connections/sharedPreference.dart';
import '../controllers/estilos.dart';
import '../connections/fireAuth.dart';
import '../widgets/cardNoivos.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({Key? key}) : super(key: key);

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  String token = '';

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  Future<void> carregarDados() async {
    try {
      String tokenValue = await recuperarValor();
      if (tokenValue.isNotEmpty) {
        setState(() {
          token = tokenValue;
        });
      }
    } catch (e) {
      print('Erro buscar Token.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppEstilo().colorIconPadrao),
        title: Text(
          "Catálogo de Casamento",
          style: AppEstilo().estiloTextoNegrito,
        ),
        backgroundColor: AppEstilo().colorAppBar,
        actions: [
          if (token.isEmpty)
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, token.isEmpty ? '/login' : '/home');
              },
              icon: const Icon(Icons.person),
            ),
          if (token.isNotEmpty)
            PopupMenuButton<String>(
              onSelected: (String result) {
                if (result == 'opcao1') {
                  setState(() {
                    Navigator.pushNamed(context, '/reservasProdutosNoivos');
                  });
                }
                if (result == 'opcao2') {
                  setState(() {
                    Navigator.pushNamed(context, '/editarPerfil');
                  });
                }
                if (result == 'opcao3') {
                  setState(() {
                    signOutNoivos(context);
                  });
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'opcao1',
                  child: Text('Ver Reservas'),
                ),
                const PopupMenuItem<String>(
                  value: 'opcao2',
                  child: Text('Editar Perfil'),
                ),
                const PopupMenuItem<String>(
                  value: 'opcao3',
                  child: Text('Sair'),
                ),
              ],
            ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: AppEstilo().decoracaoContainerGradiente,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('noivos').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Erro ao carregar os dados.'),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final dados = snapshot.requireData;
              return ListView.separated(
                padding: const EdgeInsets.all(10),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => cardNoivos(context, dados.docs[index]),
                separatorBuilder: (context, _) => const SizedBox(height: 5),
                itemCount: dados.size,
              );
            },
          ),
        ),
      ),
    );
  }
}
