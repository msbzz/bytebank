
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/editor.dart';
import '../../models/transferencia.dart';

const _titualoAppBar ='Criando Transferencias';
const _rotuloConta = 'Numero da Conta';
const _dicaConta = '00000';
const _rotuloValor = 'valor';
const _dicaValor = '0.00';
const _textoBtnConfirma ='Confirmar';

class FormularioTransferencia extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  final TextEditingController _controllerConta = TextEditingController();
  final TextEditingController _controllerValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ;
    return Scaffold(
        appBar: AppBar(
          title: const Text(_titualoAppBar),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Editor(
                  controlador: _controllerConta,
                  rotulo: _rotuloConta,
                  dica: _dicaConta),
              Editor(
                  controlador: _controllerValor,
                  rotulo: _rotuloValor,
                  dica: _dicaValor,
                  icone: Icons.monetization_on),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
                  // Cor de fundo
                  foregroundColor:
                  MaterialStateProperty.all(Colors.white), // Cor do texto
                ),
                onPressed: () {
                  _criaTransferencia(context);
                },
                child: const Text(_textoBtnConfirma),
              ),
            ],
          ),
        ));
  }

  void _criaTransferencia(BuildContext context) {

    final int numConta = int.parse(_controllerConta.text);
    final double valorConta = double.parse(_controllerValor.text);

    if (numConta != null && valorConta != null) {
      final transferenciaCriada = Transferencia(numConta, valorConta);
      debugPrint('$transferenciaCriada');
      Navigator.pop(context, transferenciaCriada);
    }
  }
}
