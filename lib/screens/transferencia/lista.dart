
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/transferencia.dart';
import 'formulario.dart';

const _tituloAppBar ='Criando Transferencias';

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
        title: const Text(_tituloAppBar),

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
        backgroundColor: Colors.blueAccent, // Cor de fundo do botão
        //foregroundColor: Colors.white, // Cor do ícone
        onPressed: () {
          final Future<Transferencia?> future = Navigator.push(
              context, MaterialPageRoute(builder: (context) {
            return FormularioTransferencia();
          }));

          future.then((transferenciaRecebida) => _atualiza(transferenciaRecebida));
        },
      ),
    );
  }

  void _atualiza(Transferencia? transferenciaRecebida) {
     if (transferenciaRecebida != null) {
      setState(() {
        widget._transferencias.add(transferenciaRecebida);
      });
    }
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
