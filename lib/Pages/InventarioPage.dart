import 'package:app_pedidos/Widgets/ItemProducto.dart';
import 'package:app_pedidos/providers/carrito_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/producto_model.dart';

class InventarioPage extends StatefulWidget {
  @override
  State<InventarioPage> createState() => _InventarioPageState();
}



class _InventarioPageState extends State<InventarioPage> {
  TextEditingController _searchController = TextEditingController();
  List<ProductoModel> _listaProductosEncontrados = [];

@override
  Widget build(BuildContext context) {
    final cargarProductos = context.read<carritoProvider>().cargarPlatos();
    final listaPlatos = context.watch<carritoProvider>().platos;
    // Filtrar la lista de productos en función del texto ingresado
    _listaProductosEncontrados = listaPlatos.where((producto) {
      final searchTerm = _searchController.text.toLowerCase();
      return producto.nombre.toLowerCase().contains(searchTerm);
    }).toList();
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.only(top: 20,bottom: 10),
            child: Text(
              "Inventario",
              style:
                  TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(padding: EdgeInsets.only(left: 20,right: 20),
            child: ClipRRect(borderRadius: BorderRadius.circular(50),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(filled: true,fillColor: Colors.white,
                  labelText: 'Buscar productos',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  setState(() {}); // Actualizar la UI al cambiar el texto
                },
              ),
            ),
          ),
          
          Expanded(
            child: Padding(padding: EdgeInsets.only(top: 15,right: 20,bottom: 80,left: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(color: Colors.white,
                  child: Padding(padding: EdgeInsets.all(10),
                    child: ListView.builder(itemCount: _listaProductosEncontrados.length,
                        itemBuilder: (context, index) {
                          return itemProducto(imagen: _listaProductosEncontrados[index].imagen, nombre: _listaProductosEncontrados[index].nombre,
                          precio: _listaProductosEncontrados[index].precio, idProducto: _listaProductosEncontrados[index].idProducto,
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
    );
  }
}
