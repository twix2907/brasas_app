import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/carrito_model.dart';
import '../models/venta_model.dart';
FirebaseFirestore db = FirebaseFirestore.instance;

Future<List<DocumentSnapshot>> getPlatos() async {
    try {
      QuerySnapshot queryPlatos = await db.collection('Platos').get();
      return queryPlatos.docs;
    } catch (e) {
      print('Error al obtener platos como DocumentSnapshots: $e');
      return [];
    }
  }
  
Future<void> guardarPlato(String nombre, String imagen, double precio) async {
  await db.collection('Platos').add({
    'nombre': nombre,
    'imagen': imagen,
    'precio': precio,
  });
}
Future<void> eliminarPlato(String id) async {
  try {
    await db.collection('Platos').doc(id).delete();
    print('Plato eliminado correctamente.');
  } catch (e) {
    print('Error al eliminar el plato: $e');
  }
}
Future<void> registrarVenta(String fecha, List<CarritoModel> productos, String total) async {
  try {
    List<Map<String, dynamic>> productosMap = productos.map((item) {
      return {
        'nombre': item.nombre,
        'imagen': item.imagen,
        'precio': item.precio,
        'cantidad': item.cantidad,
        'subtotal': item.subtotal,
      };
    }).toList();

    await FirebaseFirestore.instance.collection('Ventas').add({
      'fecha': fecha,
      'productos': productosMap,
      'total': total,
    });

    print('Orden agregada correctamente.');
  } catch (e) {
    print('Error al agregar la orden: $e');
  }
  
}
Future<List<VentaModel>> obtenerVentas() async {
  try {
    QuerySnapshot queryVentas = await FirebaseFirestore.instance.collection('Ventas').get();

    List<VentaModel> ventas = queryVentas.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

      String fecha = data['fecha'] as String;
      String total = data['total'] as String;

      List<CarritoModel> productos = (data['productos'] as List<dynamic>).map((productoData) {
        String nombre = productoData['nombre'] as String;
        String imagen = productoData['imagen'] as String;
        double precio = productoData['precio'] as double;
        int cantidad = productoData['cantidad'] as int;
        double subtotal = productoData['subtotal'] as double;

        return CarritoModel(
          nombre: nombre,
          imagen: imagen,
          precio: precio,
          cantidad: cantidad,
          subtotal: subtotal,
        );
      }).toList();

      return VentaModel(
        fecha: fecha,
        productos: productos,
        total: total,
      );
    }).toList();

    return ventas;
  } catch (e) {
    print('Error al obtener las ventas: $e');
    return [];
  }
}