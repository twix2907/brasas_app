import 'package:app_pedidos/models/carrito_model.dart';
import 'package:app_pedidos/models/producto_model.dart';
import 'package:app_pedidos/models/venta_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/firebase_service.dart';

class carritoProvider with ChangeNotifier{
  int _counter=0;
  int get counter => _counter;

  List<CarritoModel> _listaCarrito=[];
  List<CarritoModel> get listaCarrito => _listaCarrito;

  List<ProductoModel> _platos = [];
  List<ProductoModel> get platos => _platos;

  List<VentaModel> _ventas = [];
  List<VentaModel> get ventas => _ventas;

  Future<void> cargarVentas() async {
    try {
      List<VentaModel> ventas = await obtenerVentas();
      _ventas = ventas;
      notifyListeners();
    } catch (e) {
      print('Error al cargar las ventas: $e');
    }
  }
  Future<void> limpiarCarrito() async{
    try {
      _listaCarrito.clear();
      notifyListeners();
    } catch (e) {
      
    }
  }
  Future<void> cargarPlatos() async {
    try {
      List<DocumentSnapshot> documentos = await getPlatos();

      _platos = documentos.map((documento) {
        return ProductoModel(
          idProducto: documento.id,
          nombre: documento['nombre'] as String,
          imagen: documento['imagen'] as String,
          precio: documento['precio'] as double,
        );
      }).toList();

      notifyListeners();
    } catch (e) {
      print('Error al cargar platos: $e');
    }
  }

  
 void agregarAlCarrito(String nombre, String imagen, double precio) {
    // Verificar si el producto ya está en el carrito
    bool productoExistente = false;
    for (var item in _listaCarrito) {
      if (item.nombre == nombre) {
        item.cantidad += 1;
        item.subtotal = item.cantidad * precio;
        productoExistente = true;
        break;
      }
    }

    // Si el producto no existe, agregar uno nuevo
    if (!productoExistente) {
      _listaCarrito.add(
        CarritoModel(
          nombre: nombre,
          imagen: imagen,
          precio: precio,
          cantidad: 1,
          subtotal: precio,
        ),
      );
    }

    notifyListeners();
  }
void eliminarDelCarrito(String nombre) {
    _listaCarrito.removeWhere((producto) => producto.nombre == nombre);
    notifyListeners();
  }
  double calcularTotal() {
    double total = 0.0;
    for (var item in _listaCarrito) {
      total += item.subtotal;
    }
    return total;
  }
   void actualizarCantidadYSubtotal(String nombre, int cantidad, double subtotal) {
    final carritoItem = _listaCarrito.firstWhere((item) => item.nombre == nombre);
    carritoItem.cantidad = cantidad;
    carritoItem.subtotal = subtotal;
    notifyListeners();
  }
}
