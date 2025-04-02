import 'package:app_pedidos/Widgets/item_producto_carrito.dart';
import 'package:app_pedidos/providers/carrito_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Widgets/CartBottomNavBar.dart';

class carritoScreen extends StatefulWidget {
  @override
  State<carritoScreen> createState() => _carritoScreenState();
}

class _carritoScreenState extends State<carritoScreen> {
  final total = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "Carrito",
              style:
                  TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 20,bottom: 20,right: 20,left: 20),
              child: ClipRRect(borderRadius: BorderRadius.circular(40),
                child: Container(color: Colors.white,
                  child: Padding(padding: EdgeInsets.all(10),
                    child: ListView.builder(
                      key: UniqueKey(),
                      itemCount: context.watch<carritoProvider>().listaCarrito.length,
                      itemBuilder: (context, index) {
                        final productoc = context.watch<carritoProvider>().listaCarrito[index];
                        String nombrepro='';
                        String imagenUrl='';
                        double precio=0.0;
                        int cantidad=1;
                        double subtotal=0.0;
                        nombrepro = productoc.nombre;
                        imagenUrl = productoc.imagen;
                        precio = productoc.precio;
                        cantidad = productoc.cantidad;
                        subtotal = productoc.subtotal;
                        return Padding(
                          padding:  EdgeInsets.only(right: 10,left: 10,top: 20,bottom: 20),
                          child: itemCarrito(imagen: imagenUrl, nombre: nombrepro, precio: precio,cantidad: cantidad,subtotal: subtotal,),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          
        ],
      ),
      bottomNavigationBar: CartBottomNavBar(),
    );
  }
}