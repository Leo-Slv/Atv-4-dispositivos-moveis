import 'package:flutter/material.dart';

import '../models/pedido.dart';
import 'tela_finalizacao.dart';

const List<String> formasPagamento = [
  'Pix',
  'Cartão de crédito',
  'Cartão de débito',
  'Dinheiro',
];

class TelaPagamento extends StatefulWidget {
  final Pedido pedido;

  const TelaPagamento({super.key, required this.pedido});

  @override
  State<TelaPagamento> createState() => _TelaPagamentoState();
}

class _TelaPagamentoState extends State<TelaPagamento> {
  Pedido get pedido => widget.pedido;

  void avancar() {
    if (pedido.pagamento == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TelaFinalizacao(pedido: pedido)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('4. Forma de pagamento')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Escolha a forma de pagamento:'),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: [
                  for (final forma in formasPagamento)
                    ListTile(
                      selected: pedido.pagamento == forma,
                      leading: Icon(
                        pedido.pagamento == forma
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked,
                      ),
                      title: Text(forma),
                      onTap: () => setState(() => pedido.pagamento = forma),
                    ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: pedido.pagamento == null ? null : avancar,
                child: const Text('Avançar'),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Voltar'),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () =>
                    Navigator.popUntil(context, (rota) => rota.isFirst),
                child: const Text('Voltar ao início'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
