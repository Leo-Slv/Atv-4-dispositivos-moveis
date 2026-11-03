import 'package:flutter/material.dart';

import '../models/item_cardapio.dart';
import '../models/pedido.dart';
import '../utils/formatar_valor.dart';
import 'tela_bebida.dart';

const List<ItemCardapio> pratosPrincipais = [
  ItemCardapio('Filé à parmegiana', 42.90),
  ItemCardapio('Risoto de cogumelos', 38.50),
  ItemCardapio('Salmão grelhado', 56.00),
  ItemCardapio('Lasanha à bolonhesa', 36.90),
];

class TelaPratoPrincipal extends StatefulWidget {
  final Pedido? pedido;

  const TelaPratoPrincipal({super.key, this.pedido});

  @override
  State<TelaPratoPrincipal> createState() => _TelaPratoPrincipalState();
}

class _TelaPratoPrincipalState extends State<TelaPratoPrincipal> {
  late final Pedido pedido = widget.pedido ?? Pedido();

  void avancar() {
    if (pedido.prato == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TelaBebida(pedido: pedido)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('1. Prato principal')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Escolha o prato principal:'),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: [
                  for (final item in pratosPrincipais)
                    ListTile(
                      selected: pedido.prato == item,
                      leading: Icon(
                        pedido.prato == item
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked,
                      ),
                      title: Text(item.nome),
                      trailing: Text(formatarValor(item.valor)),
                      onTap: () => setState(() => pedido.prato = item),
                    ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: pedido.prato == null ? null : avancar,
                child: const Text('Avançar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
