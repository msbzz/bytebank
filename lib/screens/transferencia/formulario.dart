
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/editor.dart';
import '../../models/transferencia.dart';

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
    return Scaffold(
        appBar: AppBar(
          title: const Text('Criando Transferencias'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Editor(
                  controlador: _controllerConta,
                  rotulo: 'Numero da Conta',
                  dica: '00000'),
              Editor(
                  controlador: _controllerValor,
                  rotulo: 'valor',
                  dica: '0.00',
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
                child: const Text('Confirmar'),
              ),
            ],
          ),
        ));
  }

  void _criaTransferencia(BuildContext context) {
    debugPrint('confirmou !!!');
    debugPrint('conta ' + _controllerConta.text);
    debugPrint('valor ' + _controllerValor.text);

    final int numConta = int.parse(_controllerConta.text);
    final double valorConta = double.parse(_controllerValor.text);

    if (numConta != null && valorConta != null) {
      final transferenciaCriada = Transferencia(numConta, valorConta);
      debugPrint('$transferenciaCriada');
      Navigator.pop(context, transferenciaCriada);
    }
  }
}
