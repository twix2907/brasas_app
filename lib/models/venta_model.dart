import 'carrito_model.dart';

class VentaModel {
  String fecha;
  List<CarritoModel> productos;
  String total;

  VentaModel({
    required this.fecha,
    required this.productos,
    required this.total,
  });
}

