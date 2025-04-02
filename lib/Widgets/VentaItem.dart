import 'package:app_pedidos/models/carrito_model.dart';
import 'package:flutter/material.dart';
class ventaItem extends StatefulWidget {
  final String nombreVenta;
  final String fecha;
  final double total;
  final List<CarritoModel> productos;
  const ventaItem({super.key, required this.nombreVenta, required this.fecha, required this.total, required this.productos});

  @override
  State<ventaItem> createState() => _ventaItemState();
}

class _ventaItemState extends State<ventaItem> {
  bool _mostrarProductos = false;
  @override
  Widget build(BuildContext context) {
    
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(widget.fecha,style: TextStyle(fontSize: 14),),
            subtitle: Text('Total: \S/${widget.total.toString()}'),
            trailing: GestureDetector(
              onTap: () {
                setState(() {
                  _mostrarProductos = !_mostrarProductos;
                });
              },
              child: Text(
                _mostrarProductos ? 'Ocultar' : 'Mostrar Más',
                style: TextStyle(color: Colors.blue,),
              ),
            ),
          ),
          if (_mostrarProductos)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.productos.map((producto) {
                return ListTile(
                  title: Text(producto.nombre),
                  subtitle: Text('Cantidad: ${producto.cantidad} - Subtotal: \S/${producto.subtotal.toString()}'),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}