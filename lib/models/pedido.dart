import 'item_cardapio.dart';

/// Escolhas do usuario ao longo do fluxo. E criado na primeira tela e
/// repassado as demais pelo construtor de cada tela.
class Pedido {
  ItemCardapio? prato;
  ItemCardapio? bebida;
  ItemCardapio? sobremesa;
  String? pagamento;

  double get total =>
      (prato?.valor ?? 0) + (bebida?.valor ?? 0) + (sobremesa?.valor ?? 0);
}
