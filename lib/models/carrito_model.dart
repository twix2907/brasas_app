class CarritoModel {
  String nombre;
  String imagen;
  double precio;
  int cantidad;
  double subtotal;

  CarritoModel({
    required this.nombre,
    required this.imagen,
    required this.precio,
    required this.cantidad,
    required this.subtotal,
  });
  CarritoModel.fromMap(Map<String, dynamic> map)
      : nombre = map['nombre'],
        imagen = map['imagen'],
        precio = map['precio'].toDouble(), // Aseguramos que 'precio' sea un double
        cantidad = map['cantidad'],
        subtotal = map['subtotal'].toDouble(); // Aseguramos que 'subtotal' sea un double
}