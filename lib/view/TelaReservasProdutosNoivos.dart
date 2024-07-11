import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../connections/fireCloudNoivos.dart';
import '../connections/sharedPreference.dart';
import '../connections/fireAuth.dart';
import '../controllers/estilos.dart';
import '../widgets/cardReservas.dart';

class TelaReservasProdutosNoivos extends StatefulWidget {
  const TelaReservasProdutosNoivos({super.key});

  @override
  State<TelaReservasProdutosNoivos> createState() => _TelaReservasProdutosNoivosState();
}

class _TelaReservasProdutosNoivosState extends State<TelaReservasProdutosNoivos> {
  String token = '';
  String uidNoivos = '';
  String varAtivo = '0';
  String nomeNoivos = '';
  String nomeColecao = '';

  void superInitState() {
    super.initState();
    carregarDados();
  }

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
    uidNoivos = await idNoivos();
    nomeNoivos = await retornarNomeNoivosPorID(uidNoivos);
    setState(() {
      varAtivo = '0';
      nomeColecao = 'produtos$nomeNoivos';
      uidNoivos = uidNoivos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppEstilo().colorIconPadrao),
        title: Text(
          "Reserva de $nomeNoivos",
          style: AppEstilo().estiloTextoNegrito,
        ),
        backgroundColor: AppEstilo().colorAppBar,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: AppEstilo().decoracaoContainerGradiente,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: nomeColecao.isNotEmpty ? StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection(nomeColecao).where('varAtivoProduto', isEqualTo: varAtivo).snapshots(),
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
                              child: cardReservas(context, dados.docs[index], nomeNoivos),
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
                              child: cardReservas(context, dados.docs[index], nomeNoivos),
                            ),
                        itemCount: dados.size);
                  }
                },
              );
            },
          ) : null,
        ),
      ),
      floatingActionButton: token.isNotEmpty && token == uidNoivos
          ? FloatingActionButton(
              shape: const CircleBorder(),
              onPressed: () {
                String tipo = 'adicionar';
                Navigator.pushNamed(context, '/adicionarProdutosNoivos',
                    arguments: {'tipo': '$tipo'});
              },
              backgroundColor: AppEstilo().colorBackgroundIcon,
              child: Icon(Icons.add, color: AppEstilo().colorIconImage, size: 35),
            )
          : null,
    );
  }
}
