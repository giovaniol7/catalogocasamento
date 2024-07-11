import 'package:flutter/material.dart';
import '../controllers/estilos.dart';

Widget cardProdutos(context, doc, nomeNoivos) {
  return Card(
    color: const Color(0xFFEBE3F1),
    elevation: 2,
    child: Container(
      decoration: AppEstilo().decoracaoContainerCardProdutos,
      margin: const EdgeInsets.all(15),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: doc.data()['urlImageProduto'].toString().isNotEmpty
                      ? Image.network(
                          fit: BoxFit.cover,
                          doc.data()['urlImageProduto'],
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 5,
                          alignment: Alignment.center,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              alignment: Alignment.center,
                              child: const Icon(Icons.error, size: 48.0, color: Colors.red),
                            );
                          },
                        )
                      : Image.asset('lib/assets/icon/present.png',
                          alignment: Alignment.topCenter,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 5)),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: AppEstilo().decoracaoContainerTituloCard,
                child: Text(
                  "${doc.data()['nomeProduto']}",
                  style: AppEstilo().estiloCardTituloProduto,
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            alignment: Alignment.topLeft,
            child: MaterialButton(
              onPressed: () {
                if (doc.data()['varAtivoProduto'].toString() == '1') {
                  Navigator.pushNamed(context, '/produtoDetalhe', arguments: {
                    'uidProdutoNoivos': doc.data()['uidProdutoNoivos'],
                    'urlImageProduto': doc.data()['urlImageProduto'],
                    'nomeProduto': doc.data()['nomeProduto'],
                    'marcaProduto': doc.data()['marcaProduto'],
                    'lojaSiteProduto': doc.data()['lojaSiteProduto'],
                    'precoProduto': doc.data()['precoProduto'],
                    'descricaoProduto': doc.data()['descricaoProduto'],
                    'varAtivoProduto': doc.data()['varAtivoProduto'],
                    'nomeNoivos': nomeNoivos
                  });
                }
              },
              height: 50,
              elevation: 0,
              splashColor: doc.data()['varAtivoProduto'].toString() == '1'
                  ? Colors.yellow[400]
                  : Colors.black38,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              color: doc.data()['varAtivoProduto'].toString() == '1'
                  ? Colors.yellow[800]
                  : Colors.black12,
              child: Center(
                child: doc.data()['varAtivoProduto'].toString() == '1'
                    ? const Text("Reservar", style: TextStyle(color: Colors.white, fontSize: 18))
                    : const Text("Indisponível",
                        style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
