import 'package:flutter/material.dart';

import '../models/item_cardapio.dart';
import '../models/pedido.dart';
import '../utils/formatar_valor.dart';
import 'tela_pagamento.dart';

const List<ItemCardapio> sobremesas = [
  ItemCardapio('Pudim', 12.50),
  ItemCardapio('Sorvete', 10.00),
  ItemCardapio('Mousse de chocolate', 13.90),
  ItemCardapio('Torta de limão', 14.00),
];

class TelaSobremesa extends StatefulWidget {
  final Pedido pedido;

  const TelaSobremesa({super.key, required this.pedido});

  @override
  State<TelaSobremesa> createState() => _TelaSobremesaState();
}

class _TelaSobremesaState extends State<TelaSobremesa> {
  Pedido get pedido => widget.pedido;

  void avancar() {
    if (pedido.sobremesa == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TelaPagamento(pedido: pedido)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('3. Sobremesa')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Escolha a sobremesa:'),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: [
                  for (final item in sobremesas)
                    ListTile(
                      selected: pedido.sobremesa == item,
                      leading: Icon(
                        pedido.sobremesa == item
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked,
                      ),
                      title: Text(item.nome),
                      trailing: Text(formatarValor(item.valor)),
                      onTap: () => setState(() => pedido.sobremesa = item),
                    ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: pedido.sobremesa == null ? null : avancar,
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
