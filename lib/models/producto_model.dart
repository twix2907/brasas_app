class ProductoModel {
  final String idProducto;
  final String nombre;
  final String imagen;
  final double precio;

  ProductoModel({
    required this.idProducto,
    required this.nombre,
    required this.imagen,
    required this.precio,
  });

  // Método para convertir desde un mapa a una instancia de Producto
  factory ProductoModel.fromMap(Map<String, dynamic> map) {
    return ProductoModel(
      idProducto: map['id'] ?? '',
      nombre: map['nombre'] ?? '',
      imagen: map['imagen'] ?? '',
      precio: map['precio'] ?? 0.0,
    );
  }
}
