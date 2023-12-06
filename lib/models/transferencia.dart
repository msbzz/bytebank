class Transferencia {
  final double valor;
  final int conta;

  Transferencia(this.conta, this.valor);

  @override
  String toString() {
    return 'Transferencia{valor: $valor, conta: $conta}';
  }
}