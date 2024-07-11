import 'package:flutter/material.dart';
import '../controllers/estilos.dart';
import '../controllers/variaveis.dart';

Widget cardNoivos(context, doc) {
  double escala = calcularEscala(context);

  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, '/produtosNoivos',
          arguments: {'nomeNoiva': doc.data()['nomeNoiva'], 'nomeNoivo': doc.data()['nomeNoivo']});
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
