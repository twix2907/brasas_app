import 'package:app_pedidos/Pages/CarritoScreen.dart';
import 'package:app_pedidos/Pages/ItemPage.dart';
import 'package:app_pedidos/Pages/RegistrarProducto.dart';
import 'package:app_pedidos/Widgets/scafol.dart';
import 'package:app_pedidos/providers/carrito_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'Pages/InventarioPage.dart';

void main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(create: (_) =>carritoProvider(),child:  MyApp(),));
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});


  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "App de Pedidos",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.amberAccent
      ),
        home: scafol(),
      routes: {
        
        "cartPage": (context) => InventarioPage(),
        "itemPage": (context) => ItemPage(imagen: '',),
        "regis": (context) => ProductForm(),
        "carrito":(context) => carritoScreen()
      },
    );
  }
}
