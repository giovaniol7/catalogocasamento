import 'package:flutter/material.dart';
import '../connections/fireCloudConvidados.dart';
import '../controllers/estilos.dart';
import '../controllers/variaveis.dart';

Widget cardReservas(context, doc, nomeNoivos) {
  recuperarConvidadosPorIdProduto(doc.data()['uidProdutoNoivos']).then((convidadoNoivos) {
    if (convidadoNoivos != null) {
      AppVariaveis().nomeConvidado = convidadoNoivos['nomeConvidado'] ?? '';
    }
  }).catchError((error) {
    print("Erro ao recuperar convidados: $error");
  });

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
                          doc.data()['urlImageProduto'],
                          fit: BoxFit.cover,
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
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              alignment: Alignment.topCenter,
              child: Text(
                AppVariaveis().nomeConvidado,
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
