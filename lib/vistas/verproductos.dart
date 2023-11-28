// verproductos.dart
import 'package:flutter/material.dart';
import 'package:verduleria/servicios/productos.services.dart';

class VerProductosScreen extends StatelessWidget {
  final ProductosService _productosService;

  VerProductosScreen({required ProductosService productosService})
      : _productosService = productosService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ver Productos'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _productosService.getProductos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List productos = snapshot.data as List;

            if (productos.isEmpty) {
              return Center(
                child: Text('No hay productos disponibles.'),
              );
            }

            // Construir la matriz de columnas
            return DataTable(
              columns: [
                DataColumn(label: Text('Nombre')),
                DataColumn(label: Text('Unidad')),
                DataColumn(label: Text('Cantidad')),
                DataColumn(label: Text('Valor')),
              ],
              rows: productos.map((producto) {
                // Verifica si el objeto es una función y ejecútala para obtener el mapa de datos
                if (producto is Function) {
                  producto = producto();
                }

                // Verifica si el objeto es nulo antes de acceder a sus propiedades
                String nombre = producto?['nombre'] ?? 'Nombre no disponible';
                String unidad = producto?['unidad'] ?? 'Unidad no disponible';
                int cantidad = producto?['cantidad'] ?? 0;
                int valor = producto?['valor'] ?? 0;

                // Construir una fila de datos
                return DataRow(
                  cells: [
                    DataCell(Text(nombre)),
                    DataCell(Text(unidad)),
                    DataCell(Text(cantidad.toString())),
                    DataCell(Text(valor.toString())),
                  ],
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
