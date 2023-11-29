import 'package:flutter/material.dart';
import 'package:verduleria/servicios/productos.services.dart';

class PreciosUnitariosScreen extends StatefulWidget {
  final ProductosService _productosService;

  PreciosUnitariosScreen({required ProductosService productosService})
      : _productosService = productosService;

  @override
  _PreciosUnitariosScreenState createState() => _PreciosUnitariosScreenState();
}

class _PreciosUnitariosScreenState extends State<PreciosUnitariosScreen> {
  late double _porcentajeGanancia;
  late double _precioVenta;

  @override
  void initState() {
    super.initState();
    _porcentajeGanancia = 0.0;
    _precioVenta = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Precios',
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              _mostrarDialogoPorcentajeGanancia();
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Ganancia: $_porcentajeGanancia%',
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: widget._productosService.getProductos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List productos = snapshot.data as List;

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 15,
                dataRowHeight: 50,
                headingRowHeight: 60,
                columns: [
                  DataColumn(
                    label: Container(
                        padding: EdgeInsets.all(10),
                        child: Center(
                            child: Text('Nombre',
                                style: TextStyle(fontSize: 19)))),
                  ),
                  DataColumn(
                    label: Container(
                        padding: EdgeInsets.all(10),
                        child: Center(
                            child: Text('Unidad',
                                style: TextStyle(fontSize: 19)))),
                  ),
                  DataColumn(
                    label: Container(
                        padding: EdgeInsets.all(10),
                        child: Center(
                            child: Text('Precio Compra',
                                style: TextStyle(fontSize: 19)))),
                  ),
                  DataColumn(
                    label: Container(
                        padding: EdgeInsets.all(10),
                        child: Center(
                            child: Text('Precio Venta',
                                style: TextStyle(fontSize: 19)))),
                  ),
                  DataColumn(
                    label: Container(
                        padding: EdgeInsets.all(10),
                        child: Center(
                            child:
                                Text('Fecha', style: TextStyle(fontSize: 19)))),
                  ),
                ],
                rows: productos.map((producto) {
                  String nombre = producto?['nombre'] ?? 'Nombre no disponible';
                  String fecha =
                      producto?['fechaIngreso'] ?? 'Fecha no disponible';
                  String unidad = producto?['unidad'] ?? 'Unidad no disponible';
                  int cantidad = producto?['cantidad'] ?? 0;
                  int valor = producto?['valor'] ?? 0;
                  double precioUnitario = cantidad > 0 ? valor / cantidad : 0;
                  double precioVenta =
                      precioUnitario * (1 + _porcentajeGanancia / 100);

                  return DataRow(
                    cells: [
                      DataCell(Container(
                          padding: EdgeInsets.all(10),
                          child: Center(
                              child: Text(nombre,
                                  style: TextStyle(fontSize: 18))))),
                      DataCell(Container(
                          padding: EdgeInsets.all(10),
                          child: Center(
                              child: Text(unidad,
                                  style: TextStyle(fontSize: 18))))),
                      DataCell(Container(
                          padding: EdgeInsets.all(10),
                          child: Center(
                              child: Text(precioUnitario.toStringAsFixed(2),
                                  style: TextStyle(fontSize: 18))))),
                      DataCell(Container(
                          padding: EdgeInsets.all(10),
                          child: Center(
                              child: Text(precioVenta.toStringAsFixed(2),
                                  style: TextStyle(fontSize: 18))))),
                      DataCell(Container(
                          padding: EdgeInsets.all(10),
                          child: Center(
                              child: Text(fecha,
                                  style: TextStyle(fontSize: 18))))),
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

  Future<void> _mostrarDialogoPorcentajeGanancia() async {
    TextEditingController porcentajeController = TextEditingController();

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Configurar Ganancia (%)'),
          content: TextField(
            controller: porcentajeController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(labelText: 'Porcentaje'),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                double porcentaje =
                    double.tryParse(porcentajeController.text) ?? 0.0;
                setState(() {
                  _porcentajeGanancia = porcentaje;
                });
                Navigator.of(context).pop();
              },
              child: Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }
}
