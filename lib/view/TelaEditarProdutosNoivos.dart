import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:intl/intl.dart';

import '../connections/fireCloudNoivos.dart';
import '../connections/fireCloudProdutosNoivos.dart';
import '../controllers/estilos.dart';
import '../controllers/uploadImageProdutos.dart';
import '../controllers/variaveis.dart';
import '../widgets/TextFormField.dart';

class TelaEditarProdutosNoivos extends StatefulWidget {
  const TelaEditarProdutosNoivos({super.key});

  @override
  State<TelaEditarProdutosNoivos> createState() => _TelaEditarProdutosNoivosState();
}

class _TelaEditarProdutosNoivosState extends State<TelaEditarProdutosNoivos> {
  final _formKey = GlobalKey<FormState>();
  int value = 1;

  bool validarCampos() {
    return _formKey.currentState!.validate();
  }

  @override
  void initState() {
    super.initState();
    carregarDados(AppVariaveis().uidProdutoNoivos);
  }

  carregarDados(uidProdutoNoivos) async {
    var produtoNoivos = await listarProdutosNoivos(uidProdutoNoivos);
    setState(() {
      AppVariaveis().uidProdutoNoivos = produtoNoivos['uidProdutoNoivos']!;
      AppVariaveis().UIDNoivos = produtoNoivos['uidNoivos']!;
      AppVariaveis().urlImageProduto = produtoNoivos['urlImageProduto']!;
      AppVariaveis().urlImageProdutoTemp = produtoNoivos['urlImageProduto']!;
      AppVariaveis().txtNomeProduto.text = produtoNoivos['nomeProduto']!;
      AppVariaveis().txtPrecoProduto.text = produtoNoivos['precoProduto']!;
      AppVariaveis().txtMarcaProduto.text = produtoNoivos['marcaProduto']!;
      AppVariaveis().txtLojaSiteProduto.text = produtoNoivos['lojaSiteProduto']!;
      AppVariaveis().txtDescricaoProduto.text = produtoNoivos['descricaoProduto']!;
      AppVariaveis().qtdCotaProduto = int.parse(produtoNoivos['qtdCotaProduto']!);
      value = int.parse(produtoNoivos['qtdCotaProduto']!);
      AppVariaveis().valorCotaProduto = produtoNoivos['valorCotaProduto']!;
      AppVariaveis().varAtivoProduto = produtoNoivos['varAtivoProduto'];
    });
  }

  calcularCota(preco, qtdCotaProduto) {
    if (preco.isNotEmpty) {
      preco = preco.replaceAll('.', '');
      preco = preco.replaceAll(',', '.');
      double a = double.parse(preco);
      double resultado = a / qtdCotaProduto;

      final NumberFormat formatador =
          NumberFormat.currency(locale: 'pt_BR', symbol: '', decimalDigits: 2);
      AppVariaveis().valorCotaProduto = formatador.format(resultado);

      return AppVariaveis().valorCotaProduto;
    } else {
      return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppEstilo().colorAppBar,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: AppEstilo().colorIconPadrao,
          onPressed: () {
            AppVariaveis().reset();
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.delete,
                color: AppEstilo().colorIconPadrao,
              ),
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Confirmar exclusão'),
                        content: const Text('Tem certeza de que deseja apagar este Prontuário?'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text(
                              'Cancelar',
                              style: TextStyle(color: Colors.blue),
                            ),
                            onPressed: () {
                              AppVariaveis().reset();
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text(
                              'Apagar',
                              style: TextStyle(color: Colors.red),
                            ),
                            onPressed: () async {
                              await apagarProdutoNoivos(context, AppVariaveis().uidProdutoNoivos);
                              AppVariaveis().reset();
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
              })
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 40, right: 40),
        decoration: AppEstilo().decoracaoContainerGradiente,
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      width: 200.0,
                      height: 200.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppEstilo().colorBackgroundImage,
                      ),
                      child: AppVariaveis().urlImageProduto.isEmpty
                          ? InkWell(
                              onTap: () async {
                                var image = await pickedImageProdutos();
                                setState(() {
                                  AppVariaveis().fileImageProduto = image!;
                                });
                              },
                              child: AppVariaveis().fileImageProduto == null
                                  ? Icon(Icons.photo, color: AppEstilo().colorIconImage, size: 80.0)
                                  : Stack(children: [
                                      CircleAvatar(
                                        radius: 100,
                                        backgroundImage: kIsWeb
                                            ? NetworkImage(AppVariaveis().fileImageProduto.path)
                                            : FileImage(
                                                File((AppVariaveis().fileImageProduto).path)),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.5),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              color: AppEstilo().colorIconImage,
                                              size: 40,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                AppVariaveis().boolApagarImagem = true;
                                                AppVariaveis().urlImageProduto = '';
                                                AppVariaveis().fileImageProduto = null;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ]),
                            )
                          : Stack(children: [
                              CircleAvatar(
                                radius: 100,
                                backgroundImage: NetworkImage('${AppVariaveis().urlImageProduto}'),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.8),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: AppEstilo().colorIconImage,
                                      size: 40,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        AppVariaveis().boolApagarImagem = true;
                                        AppVariaveis().urlImageProduto = '';
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ]),
                    ),
                  ),
                  const SizedBox(height: 20),
                  FlutterSwitch(
                    activeText: "Cotar Produto",
                    activeTextColor: AppEstilo().colorSwitchAtivoText,
                    activeColor: AppEstilo().colorSwitchAtivo,
                    inactiveText: "Não Cotar Produto",
                    inactiveTextColor: AppEstilo().colorSwitchInativoText,
                    inactiveColor: AppEstilo().colorSwitchInativo,
                    value: AppVariaveis().switchValue,
                    valueFontSize: 10.0,
                    width: 110,
                    borderRadius: 30.0,
                    showOnOff: true,
                    onToggle: (value) {
                      setState(() {
                        AppVariaveis().switchValue = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: Column(
                        children: [
                          textFormField(
                            'Nome do Produto',
                            AppVariaveis().txtNomeProduto,
                            key: AppVariaveis().keyNomeProduto,
                            validator: true,
                          ),
                          const SizedBox(height: 20),
                          textFormField(
                            'Preço do Produto',
                            AppVariaveis().txtPrecoProduto,
                            formato: CentavosInputFormatter(),
                            boardType: 'numeros',
                            key: AppVariaveis().keyPrecoProduto,
                            validator: true,
                          ),
                          AppVariaveis().switchValue == true
                              ? const SizedBox(height: 20)
                              : Container(),
                          AppVariaveis().switchValue == true
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    InputQty.int(
                                      minVal: 0,
                                      onQtyChanged: (val) {
                                        setState(() {
                                          AppVariaveis().qtdCotaProduto = val;
                                        });
                                      },
                                      decoration: const QtyDecorationProps(
                                          qtyStyle: QtyStyle.classic,
                                          width: 16,
                                          isBordered: false,
                                          borderShape: BorderShapeBtn.circle),
                                    ),
                                    Text(
                                      'Valor de cada Cota: R\$ ${calcularCota(AppVariaveis().txtPrecoProduto.text, AppVariaveis().qtdCotaProduto)}',
                                      style: AppEstilo().estiloTextoPadrao,
                                    ),
                                  ],
                                )
                              : Container(),
                          const SizedBox(height: 20),
                          textFormField(
                            'Marca do Produto',
                            AppVariaveis().txtMarcaProduto,
                          ),
                          const SizedBox(height: 20),
                          textFormField(
                            'Loja/Site do Produto',
                            AppVariaveis().txtLojaSiteProduto,
                            key: AppVariaveis().keyLojaSiteProduto,
                            validator: true,
                          ),
                          const SizedBox(height: 20),
                          textFormField('Descrição do Produto', AppVariaveis().txtDescricaoProduto,
                              key: AppVariaveis().keyDescricaoProduto,
                              maxPalavras: 5000,
                              maxLinhas: 5,
                              tamanho: 20.0,
                              boardType: 'multiLinhas'),
                          const SizedBox(height: 40),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 60,
                                width: 125,
                                alignment: Alignment.center,
                                decoration: AppEstilo().decoracaoBotaoNormal,
                                child: SizedBox.expand(
                                  child: TextButton(
                                    child: Text(
                                      "Atualizar",
                                      style: AppEstilo().estiloTextoBotaoGradiente,
                                    ),
                                    onPressed: () async {
                                      if (validarCampos()) {
                                        AppVariaveis().fileImageProduto != null
                                            ? AppVariaveis().urlImageProduto =
                                                (await uploadImageProdutos(
                                                    AppVariaveis().fileImageProduto,
                                                    await retornarProdutoNomeNoivos()))!
                                            : AppVariaveis().urlImageProduto =
                                                AppVariaveis().urlImageProduto;

                                        if (AppVariaveis().boolApagarImagem == true) {
                                          await deletarImagemProdutosStorage(
                                              AppVariaveis().urlImageProdutoTemp);
                                          AppVariaveis().urlImageNoivosTemp = '';
                                          AppVariaveis().fileImageNoivos = null;
                                        }

                                        AppVariaveis().varAtivoProduto = "1";

                                        setState(() {
                                          editarProdutosNoivos(
                                              context,
                                              AppVariaveis().uidProdutoNoivos,
                                              AppVariaveis().urlImageProduto,
                                              AppVariaveis().txtNomeProduto.text,
                                              AppVariaveis().txtPrecoProduto.text,
                                              AppVariaveis().txtMarcaProduto.text,
                                              AppVariaveis().txtLojaSiteProduto.text,
                                              AppVariaveis().txtDescricaoProduto.text,
                                              AppVariaveis().qtdCotaProduto,
                                              AppVariaveis().qtdCotaProdutoVenda,
                                              AppVariaveis().valorCotaProduto,
                                              AppVariaveis().varAtivoProduto);
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Container(
                                height: 60,
                                width: 125,
                                alignment: Alignment.center,
                                decoration: AppEstilo().decoracaoBotaoNormal,
                                child: SizedBox.expand(
                                  child: TextButton(
                                    child: Text(
                                      "Cancelar",
                                      style: AppEstilo().estiloTextoBotaoGradiente,
                                    ),
                                    onPressed: () {
                                      AppVariaveis().reset();
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
