import 'package:app_pedidos/Pages/CarritoScreen.dart';
import 'package:app_pedidos/Pages/InicioPage.dart';
import 'package:app_pedidos/Pages/InventarioPage.dart';
import 'package:app_pedidos/Widgets/DrawerWidget.dart';
import 'package:app_pedidos/Widgets/carritoHand.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class scafol extends StatefulWidget {
  @override
  State<scafol> createState() => _scafolState();
}

class _scafolState extends State<scafol> {
  Widget selectedMenuItem = InicioPage();
  @override
Widget build(BuildContext context) {
  return CarritoHandler(
    child: Scaffold(
      appBar: AppBar(title: Text("D'Brasas y Carbón"), actions: [IconButton(onPressed: () {
        setState(() {
          selectedMenuItem = carritoScreen();
        });
        
      }, icon: Icon(CupertinoIcons.shopping_cart))]),
      drawer: DrawerWidget(onItemSelected: (item) {
            setState(() {
              selectedMenuItem = item;
              
            });
            Navigator.pop(context); // Cierra el Drawer después de seleccionar un item
          }),
      body: selectedMenuItem,
    ),
  );
}
}