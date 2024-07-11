import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';

import '../controllers/variaveis.dart';
import '../controllers/estilos.dart';
import '../connections/fireAuth.dart';
import '../connections/fireCloudConvidados.dart';
import '../connections/sharedPreference.dart';
import '../widgets/TextFormField.dart';

class TelaProdutoDetalhe extends StatefulWidget {
  const TelaProdutoDetalhe({Key? key}) : super(key: key);

  @override
  State<TelaProdutoDetalhe> createState() => _TelaProdutoDetalheState();
}

class _TelaProdutoDetalheState extends State<TelaProdutoDetalhe> {
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
    final Map<String, dynamic> product =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height * 0.6,
                elevation: 0,
                snap: true,
                floating: true,
                stretch: true,
                backgroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: const [StretchMode.zoomBackground],
                  background: product['urlImageProduto'].toString().isNotEmpty
                      ? Image.network(
                          product['urlImageProduto'],
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
                      : Image.asset('lib/assets/icon/present.png'),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(45),
                  child: Transform.translate(
                    offset: const Offset(0, 1),
                    child: Container(
                      height: 45,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE9E6DD),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Center(
                        child: Container(
                          width: 50,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade800,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    height: MediaQuery.of(context).size.height * 0.55,
                    decoration: AppEstilo().decoracaoContainerGradiente,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              product['nomeProduto'],
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "R\$ ${product['precoProduto']}",
                              style: TextStyle(color: Colors.orange.shade800, fontSize: 22),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Marca/Modelo",
                          style: TextStyle(
                              height: 1.5,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        Text(
                          product['marcaProduto'],
                          style: TextStyle(height: 1.5, color: Colors.grey.shade800, fontSize: 15),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Loja/Site",
                          style: TextStyle(
                              height: 1.5,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        Text(
                          "${product['lojaSiteProduto']}",
                          style: TextStyle(height: 1.5, color: Colors.grey.shade800, fontSize: 15),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Descrição",
                          style: TextStyle(
                              height: 1.5,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        Text(
                          "${product['descricaoProduto']}",
                          style: TextStyle(height: 1.5, color: Colors.grey.shade800, fontSize: 15),
                        ),
                        const SizedBox(height: 20),
                        MaterialButton(
                          onPressed: () {
                            if (product['varAtivoProduto'].toString() == '1') {
                              showConvidadoDialog(context, product);
                            }
                          },
                          height: 50,
                          elevation: 0,
                          splashColor: product['varAtivoProduto'].toString() == '1'
                              ? Colors.yellow[700]
                              : Colors.black38,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          color: product['varAtivoProduto'].toString() == '1'
                              ? Colors.yellow[800]
                              : Colors.black12,
                          child: Center(
                            child: product['varAtivoProduto'].toString() == '1'
                                ? const Text(
                                    "Reservar Produto",
                                    style: TextStyle(color: Colors.white, fontSize: 18),
                                  )
                                : const Text(
                                    "Indisponível",
                                    style: TextStyle(color: Colors.white, fontSize: 18),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 8.0,
            left: 8.0,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.grey),
              onPressed: () {
                AppVariaveis().reset();
                Navigator.of(context).pop();
              },
            ),
          ),
          if (token.isNotEmpty && token == uidNoivos)
            Positioned(
              top: MediaQuery.of(context).padding.top + 8.0,
              right: 8.0,
              child: IconButton(
                icon: const Icon(Icons.edit, color: Colors.grey),
                onPressed: () {
                  AppVariaveis().uidProdutoNoivos = product['uidProdutoNoivos'];
                  Navigator.pushNamed(context, '/editarProdutosNoivos');
                },
              ),
            ),
        ],
      ),
    );
  }

  void showConvidadoDialog(context, product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final _formKey = GlobalKey<FormState>();

        bool validarCampos() {
          return _formKey.currentState!.validate();
        }

        return AlertDialog(
          title: const Text('Informações do Convidado'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                textFormField(
                  'Nome',
                  AppVariaveis().txtNomeConvidado,
                  icone: Icons.person,
                  key: AppVariaveis().keyNomeConvidado,
                  validator: true,
                ),
                const SizedBox(height: 10),
                textFormField(
                  'Telefone',
                  AppVariaveis().txtTelefoneConvidado,
                  icone: Icons.phone,
                  formato: TelefoneInputFormatter(),
                  boardType: 'numeros',
                  key: AppVariaveis().keyTelefoneConvidado,
                  validator: true,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar', style: AppEstilo().estiloTextoPadrao),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(Colors.white70),
              ),
              onPressed: () {
                if (validarCampos()) {
                  setState(() async {
                    await adicionarConvidados(
                        context,
                        AppVariaveis().txtNomeConvidado.text.trim(),
                        AppVariaveis().txtTelefoneConvidado.text.trim(),
                        product['nomeNoivos'],
                        product['uidProdutoNoivos']);
                  });
                  AppVariaveis().reset();
                  Navigator.pop(context);
                }
              },
              child: Text('Salvar', style: AppEstilo().estiloTextoPadrao),
            ),
          ],
        );
      },
    );
  }
}
