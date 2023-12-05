import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(ByteBankApp());
}

class ByteBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          body: ListaTransferencia(),
        ));
  }

}


class FormularioTransferencia extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia>{

final TextEditingController _controllerConta = TextEditingController();
final TextEditingController _controllerValor = TextEditingController();


@override
Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        title: const Text('Criando Transferencias'),
        backgroundColor: Colors.blue, // Cor do AppBar
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Editor(controlador: _controllerConta,
                rotulo: 'Numero da Conta',
                dica: '00000-0'),
            Editor(controlador: _controllerValor,
                rotulo: 'valor',
                dica: '0.00',
                icone: Icons.monetization_on),

            ElevatedButton(
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

class Editor extends StatelessWidget {

  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData? icone;

  Editor(
      {required this.controlador, required this.rotulo, required this.dica, this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controlador,
        style: TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
          icon: icone != null ? Icon(icone) : null,
          labelText: rotulo,
          hintText: dica,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class ListaTransferencia extends StatefulWidget {

  final List<Transferencia> _transferencias = [];

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciaState();
  }
}


class ListaTransferenciaState extends State<ListaTransferencia> {
  @override
  Widget build(BuildContext context) {
    //widget._transferencias.add(Transferencia(321, 30000.29));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criando Transferencias'),
        backgroundColor: Colors.blue, // Cor do AppBar
      ),
      body: ListView.builder(
        itemCount: widget._transferencias.length,
        itemBuilder: (context, indice) {
          final transferencia = widget._transferencias[indice];
          return ItemTransferencia(transferencia);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),

        onPressed: () {
          final Future<Transferencia?> future = Navigator.push(
              context, MaterialPageRoute(builder: (context) {
            return FormularioTransferencia();
          }));

          future.then((transferenciaRecebida) {
            if (transferenciaRecebida != null) {
              setState(() {
                widget._transferencias.add(transferenciaRecebida);
              });
            }
          });
        },
      ),
    );
  }
}


class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
          leading: Icon(Icons.monetization_on),
          title: Text('Us ' + _transferencia.valor.toString()),
          subtitle: Text(_transferencia.conta.toString()),
        ));
  }
}

class Transferencia {
  final double valor;
  final int conta;

  Transferencia(this.conta, this.valor);

  @override
  String toString() {
    return 'Transferencia{valor: $valor, conta: $conta}';
  }
}
