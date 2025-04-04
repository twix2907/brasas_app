import 'package:app_pedidos/Pages/CarritoScreen.dart';
import 'package:app_pedidos/Pages/InicioPage.dart';
import 'package:app_pedidos/Pages/InventarioPage.dart';
import 'package:app_pedidos/Pages/VentasPage.dart';
import 'package:app_pedidos/Pages/RegistrarProducto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

List<List<dynamic>> lista = [
  [Icon(CupertinoIcons.home, color: Color.fromARGB(255, 218, 160, 0)), 'Pagina de inicio',  InicioPage()],
  [Icon(CupertinoIcons.add, color: Color.fromARGB(255, 218, 160, 0)), 'Registrar producto', ProductForm()],
  [Icon(CupertinoIcons.list_bullet, color: Color.fromARGB(255, 218, 160, 0)), 'Inventario',InventarioPage()],
  [Icon(CupertinoIcons.cart, color: Color.fromARGB(255, 218, 160, 0)), 'Carrito',carritoScreen()],
  [Icon(CupertinoIcons.money_dollar, color: Color.fromARGB(255, 218, 160, 0)), 'Registro de ventas',VentasPage()],

];

// Crea una nueva función para manejar el cierre de sesión
Future<void> cerrarSesion(BuildContext context) async {
  bool confirm = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.black,
        title: Text(
          '¿Cerrar sesión?',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          '¿Estás seguro que deseas cerrar tu sesión?',
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            child: Text(
              'Cancelar',
              style: TextStyle(color: Colors.grey),
            ),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 218, 160, 0),
              foregroundColor: Colors.black,
            ),
            child: Text('Cerrar sesión'),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  ) ?? false;

  if (confirm) {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushNamedAndRemoveUntil(
      '/login',
      (Route<dynamic> route) => false,
    );
  }
}