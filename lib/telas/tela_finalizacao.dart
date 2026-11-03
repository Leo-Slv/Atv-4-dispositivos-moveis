import 'package:flutter/material.dart';

import '../models/pedido.dart';
import '../utils/formatar_valor.dart';
import 'tela_prato_principal.dart';

class TelaFinalizacao extends StatelessWidget {
  final Pedido pedido;

  const TelaFinalizacao({super.key, required this.pedido});

  void novoPedido(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const TelaPratoPrincipal()),
      (rota) => false,
    );
  }

  Widget linha(String titulo, String nome, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text('$titulo: $nome')),
          Text(valor),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final prato = pedido.prato!;
    final bebida = pedido.bebida!;
    final sobremesa = pedido.sobremesa!;

    // Sem retorno possivel: bloqueia o botao de voltar do sistema.
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('5. Finalização do pedido'),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              linha('Prato principal', prato.nome, formatarValor(prato.valor)),
              linha('Bebida', bebida.nome, formatarValor(bebida.valor)),
              linha(
                'Sobremesa',
                sobremesa.nome,
                formatarValor(sobremesa.valor),
              ),
              const Divider(),
              Text(
                'Total: ${formatarValor(pedido.total)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text('Pagamento: ${pedido.pagamento}'),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => novoPedido(context),
                  child: const Text('Novo pedido'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
