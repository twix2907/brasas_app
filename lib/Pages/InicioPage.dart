import 'package:flutter/material.dart';
class InicioPage extends StatelessWidget {
  const InicioPage({super.key});

  @override
  Widget build(BuildContext context) {
    String descripcion="Explora nuestro menú vibrante y descubre la deliciosa fusión de sabores que solo D'Brasas y Carbón puede ofrecerte. Desde jugosas hamburguesas a la parrilla hasta auténticos anticuchos, cada elección es una aventura culinaria que satisfará tus antojos."; 
    return Padding(padding: EdgeInsets.fromLTRB(20, 50, 20, 50),
      child: ClipRRect(borderRadius: BorderRadius.circular(30),
        child: Container(color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('¡Bienvenido!',textAlign: TextAlign.center, style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold)),
              SizedBox(height: 20,),
              ClipRRect(borderRadius: BorderRadius.circular(35.0),child: Image.asset('assets/images/BrasasLocal.jpg', width: 300,)),
              Padding(padding: EdgeInsets.all(30), child: Text(descripcion,style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal, ),textAlign: TextAlign.justify,))
            ],
          )),
        ),
      ),
    );
  }
}