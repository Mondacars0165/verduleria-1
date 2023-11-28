import 'package:cloud_firestore/cloud_firestore.dart';

class ProductosService {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getProductos() async {
    List<Map<String, dynamic>> productos = [];

    CollectionReference collectionReferenceProductos =
        db.collection('productos');
    QuerySnapshot queryProductos = await collectionReferenceProductos.get();
    queryProductos.docs.forEach((documento) {
      Map<String, dynamic> productoData =
          documento.data() as Map<String, dynamic>;
      productoData['Document ID'] =
          documento.id; // Agrega el Document ID al mapa
      productos.add(productoData);
    });
    return productos;
  }

  Future<String> ingresarProducto(
    String nombre,
    String unidad,
    int cantidad,
    int valor,
  ) async {
    DocumentReference docRef = await db.collection('productos').add({
      'nombre': nombre,
      'unidad': unidad,
      'cantidad': cantidad,
      'valor': valor,
    });

    // Devolver el Document ID asignado por Firestore
    String productoId = docRef.id;
    return productoId;
  }

  Future<void> eliminarProducto(String productoId) async {
    await db.collection('productos').doc(productoId).delete();
  }
}
