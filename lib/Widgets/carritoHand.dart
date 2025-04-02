import 'package:app_pedidos/providers/carrito_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarritoHandler extends StatelessWidget {
  final Widget child;

  CarritoHandler({required this.child});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Provider.of<carritoProvider>(context),
      child: child,
    );
  }
}