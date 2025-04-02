import 'package:app_pedidos/Widgets/ListaDrawer.dart';
import 'package:app_pedidos/Widgets/VentaItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/carrito_provider.dart';
import '../services/firebase_service.dart';

class VentasPage extends StatefulWidget {
  @override
  State<VentasPage> createState() => _VentasPageState();
}

class _VentasPageState extends State<VentasPage> {
  @override
  Widget build(BuildContext context) {
    final cargarVentas = context.read<carritoProvider>().cargarVentas();
    final listaVentas = context.watch<carritoProvider>().ventas;
    listaVentas.sort((ventaA, ventaB) => ventaB.fecha.compareTo(ventaA.fecha));
    return Container(
      child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 10,
                bottom: 10,
              ),
              child: Text(
                "Registro de ventas",
                style:
                    TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: 380,
                height: 550,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: ListView.builder(
                        itemCount: listaVentas.length,
                        itemBuilder: (context, index) {
                          final detalleProductos =listaVentas[index].productos;
                          return ventaItem(nombreVenta: '', fecha: listaVentas[index].fecha, total:double.parse(listaVentas[index].total) , 
                          productos: detalleProductos!);
                        },
                      ),
              ),
            ),
            
          ],
        ),
    );
  }
}
