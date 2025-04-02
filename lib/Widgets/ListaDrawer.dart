import 'package:app_pedidos/Pages/CarritoScreen.dart';
import 'package:app_pedidos/Pages/InicioPage.dart';
import 'package:app_pedidos/Pages/InventarioPage.dart';
import 'package:app_pedidos/Pages/VentasPage.dart';
import 'package:app_pedidos/Pages/RegistrarProducto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<List<dynamic>> lista = [
  [Icon(CupertinoIcons.home, color: Color.fromARGB(255, 218, 160, 0)), 'Pagina de inicio',  InicioPage()],
  [Icon(CupertinoIcons.add, color: Color.fromARGB(255, 218, 160, 0)), 'Registrar producto', ProductForm()],
  [Icon(CupertinoIcons.list_bullet, color: Color.fromARGB(255, 218, 160, 0)), 'Inventario',InventarioPage()],
  [Icon(CupertinoIcons.cart, color: Color.fromARGB(255, 218, 160, 0)), 'Carrito',carritoScreen()],
  [Icon(CupertinoIcons.money_dollar, color: Color.fromARGB(255, 218, 160, 0)), 'Registro de ventas',VentasPage()],

];
