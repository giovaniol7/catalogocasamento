import 'package:flutter/material.dart';

class AppEstilo {
  /*double screenWidth = constraints.maxWidth;
  double fontSizeTitle = constraints.maxWidth < 600
      ? MediaQuery.of(context).size.height * 0.03
      : screenWidth * 0.10;
  double fontSizeNormal = constraints.maxWidth < 600
      ? MediaQuery.of(context).size.height * 0.02
      : screenWidth * 0.018;
  double imageSizeWidth = screenWidth * 0.4;
  double imageSizeHeight = MediaQuery.of(context).size.height * 0.35;*/

  // Tamanhos de fontes
  double fontSizeGlobalSmall = 14.0;
  double fontSizeGlobalNormal = 18.0;
  double fontSizeGlobalLarge = 22.0;
  double fontSizeGlobalTitle = 40.0;
  static const double fontSizeTitle = 40.0;
  static const double fontSizeLarge = 20.0;
  static const double fontSizeLNormal = 16.0;
  static const double fontSizeSmall = 12.0;

  // Cores
  static const Color gradienteColor1 = Color(0xFFE9E6DD);
  static const Color gradienteColor2 = Color(0xFFECDBB6);
  static const Color gradienteBotaoColor1 = Color(0xFFFFDAB9);
  static const Color gradienteBotaoColor2 = Color(0xFF9583B6);
  static const Color textFormField = Color(0xCC000000);
  static const Color corTextPadrao = Color(0xCC000000);
  static const Color colorBotaoNormal = Color(0xFFC0ADE3);
  Color colorCursor = const Color(0xCC000000);
  Color colorEnabledBorder = const Color(0xFF9E9E9E);
  Color colorFocusedBorder = const Color(0xFF6537BB);
  Color colorErrorBorder = const Color(0xFFF44336);
  Color colorFocusedErrorBorder = const Color(0xFF6537BB);
  Color colorTextPadrao = const Color(0xCC000000);
  Color colorIconPadrao = const Color(0xCC000000);
  Color colorAppBar = const Color(0xFFFFE8D5);
  Color colorIconImage = const Color(0xFF605575);
  Color colorBackgroundImage = const Color(0xFFECDBB6);
  Color colorBackgroundIcon = const Color(0xFFEBE3F1);
  Color colorRadioListTile = const Color(0xCC000000);
  Color colorCard = const Color(0xFFEBE3F1);

  //BoxDecoration
  final BoxDecoration decoracaoContainerCard = BoxDecoration(
    border: Border.all(width: 2, color: Colors.deepPurple),
    color: const Color(0xFFEBE3F1),
    borderRadius: BorderRadius.circular(15),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 2,
        blurRadius: 5,
        offset: const Offset(0, 3),
      ),
    ],
  );

  final BoxDecoration decoracaoContainerCardProdutos = BoxDecoration(
    color: const Color(0xFFEBE3F1),
    borderRadius: BorderRadius.circular(15),
  );

  final BoxDecoration decoracaoContainerTituloCard =
      BoxDecoration(color: Colors.purple.withOpacity(0.5), borderRadius: BorderRadius.circular(15));

  final BoxDecoration decoracaoContainerGradiente = const BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.3, 1],
          colors: [gradienteColor1, gradienteColor2]));

  final BoxDecoration decoracaoBotaoGradiente = const BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        stops: [0.3, 1],
        colors: [gradienteBotaoColor1, gradienteBotaoColor2]),
    borderRadius: BorderRadius.all(Radius.circular(5)),
  );

  final BoxDecoration decoracaoBotaoNormal = const BoxDecoration(
    color: colorBotaoNormal,
    borderRadius: BorderRadius.all(Radius.circular(10)),
  );

  //TextStyle
  final TextStyle estiloTextoBotaoGradiente =
      const TextStyle(color: corTextPadrao, fontSize: fontSizeLarge, fontWeight: FontWeight.bold);

  final TextStyle estiloTituloFormField =
      const TextStyle(color: textFormField, fontWeight: FontWeight.w400, fontSize: 20);

  final TextStyle estiloTextFormField = const TextStyle(color: textFormField, fontSize: 20);

  final TextStyle estiloTituloItalico = const TextStyle(
      color: corTextPadrao,
      fontSize: fontSizeTitle,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic);

  final TextStyle estiloTituloNormal =
      const TextStyle(color: corTextPadrao, fontSize: fontSizeTitle, fontWeight: FontWeight.bold);

  final TextStyle estiloTextoPadrao =
      const TextStyle(color: textFormField, fontSize: fontSizeLNormal);

  final TextStyle estiloTextoMenor = const TextStyle(color: textFormField, fontSize: fontSizeSmall);

  final TextStyle estiloTextoSublimado = const TextStyle(
      color: corTextPadrao,
      fontSize: fontSizeLNormal,
      decoration: TextDecoration.underline,
      decorationColor: corTextPadrao);

  final TextStyle estiloTextoNegrito =
      const TextStyle(fontWeight: FontWeight.bold, color: corTextPadrao, fontSize: fontSizeLNormal);

  final TextStyle estiloTextoGrandeNegrito =
      const TextStyle(fontWeight: FontWeight.bold, color: corTextPadrao, fontSize: fontSizeLarge);

  final TextStyle estiloTextoNegritoSublimado = const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.underline,
      decorationColor: Colors.black54,
      fontWeight: FontWeight.bold,
      fontSize: fontSizeLNormal);

  final TextStyle estiloCardTitulo =
      const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 26);

  final TextStyle estiloCardSubtitulo = const TextStyle(color: Colors.black54, fontSize: 18);

  final TextStyle estiloCardTituloProduto =
      const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20);
}
