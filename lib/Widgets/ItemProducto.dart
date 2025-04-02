import 'package:app_pedidos/Pages/ItemPage.dart';
import 'package:app_pedidos/Widgets/cartWidget.dart';
import 'package:app_pedidos/providers/carrito_provider.dart';
import 'package:app_pedidos/services/firebase_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class itemProducto extends StatefulWidget {
  final String idProducto;
  final String nombre;
  final String imagen;
  final double precio;

  itemProducto({required this.imagen, required this.nombre, required this.precio, required this.idProducto});

  @override
  State<itemProducto> createState() => _itemProductoState();
}

class _itemProductoState extends State<itemProducto> {
  
  @override
  Widget build(BuildContext context) {
    final cont = context.read<carritoProvider>();
    return Padding(padding: EdgeInsets.all(10),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ItemPage(imagen: widget.imagen);
              },));
              print('hola');
              print(widget.imagen);
            },
            child: Container(
              alignment: Alignment.center,
              child:
                  ClipRRect(borderRadius: BorderRadius.circular(10),child: Image.network(widget.imagen, width: 100,height: 70,fit: BoxFit.cover,)),
                  
            ),
          ),
          SizedBox(width: 10,),
          Container(
            width: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${widget.nombre}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                
                Text(
                  '${widget.precio}',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ],
            ),
          ),
          IconButton(onPressed: () async {
            await eliminarPlato(widget.idProducto);
            
          }, icon: Icon(CupertinoIcons.trash_fill)),
          SizedBox(width: 5,),
          IconButton(onPressed:() {
            cont.agregarAlCarrito(widget.nombre, widget.imagen, widget.precio);
          }, icon: Icon(CupertinoIcons.add_circled_solid))
        ],
      ),
    );
  }
}
