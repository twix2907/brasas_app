
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
final FirebaseStorage storage = FirebaseStorage.instance;
Future<String> subirImagen(File imagen) async {
  print(imagen);
  final String nombreArchivo = imagen.path.split("/").last;
  Reference ref = storage.ref().child("imagenes").child(nombreArchivo);
  final UploadTask uploadTask = ref.putFile(imagen);
  final TaskSnapshot snapshot = await uploadTask.whenComplete(() => true);
  final String url = await snapshot.ref.getDownloadURL();
  print(url);
  return url;
}