# Pedidos de restaurante (Aula 4 – Navegação entre telas)

App Flutter de 5 telas (prato, bebida, sobremesa, pagamento, finalização). Veja `docs/SPEC.md`.
O estado do pedido (`models/pedido.dart`) é passado pelos construtores; navegação com `Navigator`/`MaterialPageRoute`.

## Rodar sem instalar Flutter (Docker)
```bash
docker run --rm -v "$PWD:/w" -w /w ghcr.io/cirruslabs/flutter:stable sh -c "flutter pub get && flutter analyze && flutter test"
docker run --rm -p 8080:8080 -v "$PWD:/w" -w /w ghcr.io/cirruslabs/flutter:stable sh -c "flutter pub get && flutter run -d web-server --web-hostname 0.0.0.0 --web-port 8080"
```
Depois abra http://localhost:8080.
