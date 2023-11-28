import 'package:flutter/material.dart';
import 'package:verduleria/servicios/productos.services.dart';

class EliminarProductoScreen extends StatefulWidget {
  final ProductosService productosService;
  EliminarProductoScreen({required this.productosService});

  @override
  _EliminarProductoScreenState createState() => _EliminarProductoScreenState();
}

class _EliminarProductoScreenState extends State<EliminarProductoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eliminar Compra'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: widget.productosService.getProductos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List productos = snapshot.data as List;

            // Construir la UI para mostrar los productos con opción de eliminar
            return ListView.builder(
              itemCount: productos.length,
              itemBuilder: (context, index) {
                var producto = productos[index];

                // Verifica si el objeto es nulo antes de acceder a sus propiedades
                String nombre = producto?['nombre'] ?? 'Nombre no disponible';
                String unidad = producto?['unidad'] ?? 'Unidad no disponible';
                int cantidad = producto?['cantidad'] ?? 0;
                int valor = producto?['valor'] ?? 0;
                String productoId = producto?['Document ID'] ?? '';

                return ListTile(
                  title: Text('Nombre: $nombre'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Unidad: $unidad'),
                      Text('Cantidad: $cantidad'),
                      Text('Valor: $valor'),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      // Lógica para eliminar el producto
                      if (productoId.isNotEmpty) {
                        await widget.productosService
                            .eliminarProducto(productoId);

                        // Actualiza la lista de productos después de eliminar
                        setState(() {
                          productos.removeAt(index);
                        });

                        // Muestra un mensaje de éxito
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Compra eliminada correctamente'),
                          ),
                        );
                      } else {
                        // Muestra un mensaje de error si no hay un ID válido
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Error: ID del producto no disponible'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
