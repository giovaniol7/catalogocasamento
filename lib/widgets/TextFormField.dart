import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../controllers/estilos.dart';

textFormField(texto, controller,
    {key,
    icone,
    senha,
    sufIcon,
    boardType,
    formato,
    maxPalavras,
    maxLinhas,
    tamanho,
    validator,
    onchaged,
    iconPressed}) {
  return TextFormField(
    key: key,
    cursorColor: AppEstilo().colorCursor,
    controller: controller,
    obscureText: senha == true,
    style: AppEstilo().estiloTextFormField,
    decoration: InputDecoration(
      labelText: texto,
      labelStyle: AppEstilo().estiloTituloFormField,
      suffixIcon: sufIcon,
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppEstilo().colorEnabledBorder),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppEstilo().colorFocusedBorder, width: 2),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppEstilo().colorErrorBorder, width: 2),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppEstilo().colorFocusedErrorBorder, width: 2),
      ),
    ),
    keyboardType: boardType == 'numeros'
        ? TextInputType.number
        : (boardType == 'multiLinhas' ? TextInputType.multiline : TextInputType.text),
    textInputAction: TextInputAction.newline,
    inputFormatters: formato != null
        ? [
            FilteringTextInputFormatter.digitsOnly,
            formato,
          ]
        : [],
    maxLength: maxPalavras,
    maxLines: maxLinhas ?? 1,
    validator: validator == true
        ? (value) {
            if (value == null || value.isEmpty) {
              return 'Este campo é obrigatório.';
            }
            return null;
          }
        : null,
    onSaved: (val) => controller.text = val ?? '',
    onChanged: onchaged,
  );
}
