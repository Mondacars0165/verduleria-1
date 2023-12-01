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
        title: Text(
          'Productos Comprados',
          style: TextStyle(fontSize: 28),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: _productosService.getProductos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List productos = snapshot.data as List;

            if (productos.isEmpty) {
              return Center(
                child: Text('No hay productos disponibles.'),
              );
            }

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 20, // Ajusta el espacio entre columnas
                columns: [
                  DataColumn(
                      label: Expanded(
                          child:
                              Text('Nombre', style: TextStyle(fontSize: 19)))),
                  DataColumn(
                      label: Expanded(
                          child:
                              Text('Unidad', style: TextStyle(fontSize: 19)))),
                  DataColumn(
                      label: Expanded(
                          child: Text('Cantidad',
                              style: TextStyle(fontSize: 19)))),
                  DataColumn(
                      label: Expanded(
                          child:
                              Text('Valor', style: TextStyle(fontSize: 19)))),
                  DataColumn(
                      label: Expanded(
                          child:
                              Text('Fecha', style: TextStyle(fontSize: 19)))),
                ],
                rows: productos.map((producto) {
                  if (producto is Function) {
                    producto = producto();
                  }

                  String nombre = producto?['nombre'] ?? 'Nombre no disponible';
                  String unidad = producto?['unidad'] ?? 'Unidad no disponible';
                  int cantidad = producto?['cantidad'] ?? 0;
                  int valor = producto?['valor'] ?? 0;
                  String fecha =
                      producto?['fechaIngreso'] ?? 'Fecha no disponible';

                  return DataRow(
                    cells: [
                      DataCell(Text(nombre, style: TextStyle(fontSize: 18))),
                      DataCell(Text(unidad, style: TextStyle(fontSize: 18))),
                      DataCell(Text(cantidad.toString(),
                          style: TextStyle(fontSize: 18))),
                      DataCell(Text(valor.toString(),
                          style: TextStyle(fontSize: 18))),
                      DataCell(Text(fecha, style: TextStyle(fontSize: 18))),
                    ],
                  );
                }).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
