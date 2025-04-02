import 'dart:io';
import 'package:app_pedidos/services/firebase_service.dart';
import 'package:app_pedidos/services/seleccionar_image.dart';
import 'package:app_pedidos/services/subir_imagen.dart';
import 'package:flutter/material.dart';

class ProductForm extends StatefulWidget {
  @override
  ProductFormState createState() {
    return ProductFormState();
  }
}

class ProductFormState extends State<ProductForm> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  File? image_to_upload;
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(30),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: Container(
          color: Colors.white,
          child: Padding(padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Nombre del producto'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingresa el nombre del producto';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(labelText: 'Precio del producto'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingresa el precio del producto';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20,),
                ElevatedButton(onPressed: () async {
                  final imagen = await getImage();
                  setState(() {
                    image_to_upload=File(imagen!.path);
                  });
                  
                  
                  
                }, child: Text("Seleccionar Imagen")),
                if(image_to_upload!=null)
                ClipRRect(borderRadius: BorderRadius.circular(20),child: Image.file(image_to_upload!,width: 50,)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (image_to_upload!=null) {
                    
                    final url = await subirImagen(image_to_upload!);
                    _descriptionController.text = url;
                  }
                  
                      await guardarPlato(_nameController.text, _descriptionController.text, double.parse(_priceController.text));
                      
                    },
                    child: Text('Registrar Producto'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}