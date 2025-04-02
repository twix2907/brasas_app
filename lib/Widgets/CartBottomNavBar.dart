import 'package:app_pedidos/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/carrito_provider.dart';

class CartBottomNavBar extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final listcar = context.watch<carritoProvider>().listaCarrito;
    final totalv = context.read<carritoProvider>().calcularTotal().toString();
    final limpiarcarro = context.read<carritoProvider>();
    return 
      BottomAppBar(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Total",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "${context.watch<carritoProvider>().calcularTotal()}",
                    style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  registrarVenta(DateTime.now().toString(),listcar , totalv);
                  limpiarcarro.limpiarCarrito();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                child: Text("Ordenar ahora", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
              ),
            ],
          ),
        ),
      );
    
  }
}
