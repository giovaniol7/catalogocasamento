import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../connections/sharedPreference.dart';
import '../connections/fireAuth.dart';
import '../controllers/estilos.dart';
import '../widgets/cardProdutos.dart';

class TelaProdutosNoivos extends StatefulWidget {
  const TelaProdutosNoivos({super.key});

  @override
  State<TelaProdutosNoivos> createState() => _TelaProdutosNoivosState();
}

class _TelaProdutosNoivosState extends State<TelaProdutosNoivos> {
  String token = '';
  String uidNoivos = '';

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  Future<void> carregarDados() async {
    try {
      String tokenValue = await recuperarValor();
      uidNoivos = await idNoivos();
      if (tokenValue.isNotEmpty) {
        setState(() {
          token = tokenValue;
        });
      }
      setState(() {
        uidNoivos = uidNoivos;
      });
    } catch (e) {
      print('Erro buscar Token.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map?;
    final nomeNoiva = arguments?['nomeNoiva'] as String?;
    final nomeNoivo = arguments?['nomeNoivo'] as String?;
    String nomeNoivaSemEspacos = nomeNoiva!.replaceAll(" ", "");
    String nomeNoivoSemEspacos = nomeNoivo!.replaceAll(" ", "");
    String nomeNoivos = '$nomeNoivaSemEspacos$nomeNoivoSemEspacos';
    final nomeColecao = 'produtos$nomeNoivaSemEspacos$nomeNoivoSemEspacos';

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppEstilo().colorIconPadrao),
        title: Text(
          "Produtos de $nomeNoiva & $nomeNoivo",
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
            stream: FirebaseFirestore.instance.collection(nomeColecao).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print('Erro no stream: ${snapshot.error}');
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
              return LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < 700) {
                    return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            mainAxisExtent: (MediaQuery.of(context).size.height / 7) + 160,
                            crossAxisCount: 2),
                        padding: const EdgeInsets.all(10),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => AspectRatio(
                              aspectRatio: 1,
                              child: cardProdutos(context, dados.docs[index], nomeNoivos),
                            ),
                        itemCount: dados.size);
                  } else {
                    return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            mainAxisExtent: (MediaQuery.of(context).size.height / 7) + 160,
                            crossAxisCount: 4),
                        padding: const EdgeInsets.all(10),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) => AspectRatio(
                              aspectRatio: 1,
                              child: cardProdutos(context, dados.docs[index], nomeNoivos),
                            ),
                        itemCount: dados.size);
                  }
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: token.isNotEmpty && token == uidNoivos
          ? FloatingActionButton(
              shape: const CircleBorder(),
              onPressed: () {
                String tipo = 'adicionar';
                Navigator.pushNamed(context, '/adicionarProdutosNoivos');
              },
              backgroundColor: AppEstilo().colorBackgroundIcon,
              child: Icon(Icons.add, color: AppEstilo().colorIconImage, size: 35),
            )
          : null,
    );
  }
}
