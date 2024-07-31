import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

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
    Stream<QuerySnapshot> stream0 = FirebaseFirestore.instance
        .collection(nomeColecao)
        .where('qtdCotaProdutoVenda', isGreaterThan: '1')
        .snapshots();

    Stream<QuerySnapshot> streamNot0 = FirebaseFirestore.instance
        .collection(nomeColecao)
        .where('varAtivoProduto', isEqualTo: '0')
        .snapshots();

    Stream<List<QuerySnapshot>> combinedStream = Rx.combineLatest2(
      stream0,
      streamNot0,
          (snapshot0, snapshotNot0) {
        List<QuerySnapshot> combinedList = [];
        combinedList.add(snapshot0);
        combinedList.add(snapshotNot0);
        return combinedList;
      },
    );

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
          child: nomeColecao.isNotEmpty
              ? StreamBuilder<List<QuerySnapshot>>(
                  stream: combinedStream,
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
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text('Nenhum documento encontrado.'),
                      );
                    }
                    final allDocs = <QueryDocumentSnapshot>[];
                    for (var querySnapshot in snapshot.data!) {
                      allDocs.addAll(querySnapshot.docs);
                    }
                    return LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxWidth < 700) {
                          return GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  mainAxisExtent: (MediaQuery.of(context).size.height / 7) + 160,
                                  crossAxisCount: 1),
                              padding: const EdgeInsets.all(10),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) => AspectRatio(
                                    aspectRatio: 1,
                                    child: cardReservas(context, allDocs[index], nomeNoivos),
                                  ),
                              itemCount: allDocs.length);
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
                                    child: cardReservas(context, allDocs[index], nomeNoivos),
                                  ),
                              itemCount: allDocs.length);
                        }
                      },
                    );
                  },
                )
              : null,
        ),
      ),
    );
  }
}
