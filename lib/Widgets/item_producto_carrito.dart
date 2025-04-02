import 'package:app_pedidos/Pages/ItemPage.dart';
import 'package:app_pedidos/providers/carrito_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class itemCarrito extends StatefulWidget {
  final String nombre;
  final String imagen;
  final double precio;
  final int cantidad;
  final double subtotal;

  itemCarrito({
    required this.imagen,
    required this.nombre,
    required this.precio,
    required this.cantidad,
    required this.subtotal,
  });

  @override
  State<itemCarrito> createState() => _itemCarritoState();
}

class _itemCarritoState extends State<itemCarrito> {
  @override
  Widget build(BuildContext context) {
    double subtotal = widget.precio * widget.cantidad;
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          alignment: Alignment.center,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                widget.imagen,
                width: 100,
                height: 70,
                fit: BoxFit.cover,
              )),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${widget.nombre}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "${widget.precio}",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.red),
            ),
            Text('${widget.subtotal} -- x ${widget.cantidad}'),
          ],
        ),
        IconButton(
            onPressed: () {
              context.read<carritoProvider>().eliminarDelCarrito(widget.nombre);
            },
            icon: Icon(CupertinoIcons.trash_circle_fill,size: 40,)),
        Container(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Column(
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      int canti = widget.cantidad;
                      canti++;
                      subtotal = widget.precio * canti;
                      context
                          .read<carritoProvider>()
                          .actualizarCantidadYSubtotal(
                              widget.nombre, canti, subtotal);
                    });
                  },
                  icon: Icon(
                    CupertinoIcons.add,
                    color: Colors.white,
                    size: 20,
                  )),
              Text(
                '${widget.cantidad}',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      if (widget.cantidad > 1) {
                        int canti = widget.cantidad;
                        canti--;
                        subtotal = widget.precio * canti;
                        context
                            .read<carritoProvider>()
                            .actualizarCantidadYSubtotal(
                                widget.nombre, canti, subtotal);
                      }
                    });
                  },
                  icon: Icon(
                    CupertinoIcons.minus,
                    color: Colors.white,
                    size: 20,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
