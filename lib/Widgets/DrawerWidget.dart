import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ListaDrawer.dart';

class DrawerWidget extends StatelessWidget {
  final Function(Widget) onItemSelected;

  DrawerWidget({required this.onItemSelected});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.black),
              accountName: Text(
                "D'Brasas y Carbón",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(
                "App de ordenes internas",
                style: TextStyle(fontSize: 16),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/images/logo_brasas.jpg"),
              ),
            ),
          ),
          for(var elemento in lista)
          ListTile(
            leading: elemento[0],
            title: Text(
              '${elemento[1]}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              onItemSelected(elemento[2]);

            },
          ),
          // Añade un divisor
          Divider(
            color: Colors.grey,
            thickness: 1,
          ),
          
          // Añade la opción de cerrar sesión
          ListTile(
            leading: Icon(
              CupertinoIcons.square_arrow_left, // o puedes usar Icons.logout
              color: Color.fromARGB(255, 218, 160, 0),
            ),
            title: Text(
              'Cerrar sesión',
              style: TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 218, 160, 0),
              ),
            ),
            onTap: () {
              // No navegamos a una nueva pantalla, sino que ejecutamos la función
              cerrarSesion(context);
            },
          ),
        ],
      ),
    );
  }
}
