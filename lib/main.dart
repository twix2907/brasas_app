import 'package:app_pedidos/Pages/CarritoScreen.dart';
import 'package:app_pedidos/Pages/ItemPage.dart';
import 'package:app_pedidos/Pages/RegistrarProducto.dart';
import 'package:app_pedidos/Widgets/scafol.dart';
import 'package:app_pedidos/providers/carrito_provider.dart';
import 'package:app_pedidos/screens/login_screen.dart';
import 'package:app_pedidos/screens/recover_password_screen.dart';
import 'package:app_pedidos/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              // Usuario autenticado
              return scafol();
            } else {
              // Usuario no autenticado
              return LoginScreen();
            }
          }
          // Mientras verifica, muestra un indicador de carga
          return Scaffold(
            backgroundColor: Color(0xFF040404),
            body: Center(
              child: CircularProgressIndicator(
                color: Color(0xFFF5D321),
              ),
            ),
          );
        }
      ),
      routes: {
        
        "cartPage": (context) => InventarioPage(),
        "itemPage": (context) => ItemPage(imagen: '',),
        "regis": (context) => ProductForm(),
        "carrito":(context) => carritoScreen(),

        // Nuevas rutas para autenticación
        "/login": (context) => LoginScreen(),
        "/register": (context) => RegisterScreen(), // Debes crear esta pantalla
        "/recover-password": (context) => RecoverPasswordScreen(), // Debes crear esta pantalla
        "/home": (context) => scafol(),
      },
    );
  }
}
