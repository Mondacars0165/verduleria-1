// Importa las librerías necesarias
import 'package:flutter/material.dart';
import 'package:verduleria/servicios/productos.services.dart';
import 'package:verduleria/vistas/verproductos.dart';
import 'package:verduleria/vistas/agregarproductos.dart';
import 'package:verduleria/vistas/eliminarproductos.dart';
import 'package:verduleria/vistas/preciounitarios.dart';
import 'package:verduleria/vistas/hacercaja.dart';
import 'package:verduleria/vistas/historial.dart'; // Importa la nueva vista
import 'package:verduleria/servicios/auth.service.dart';

class HomeNRM extends StatelessWidget {
  final AuthService _authService;
  final ProductosService _productosService;

  HomeNRM({
    required AuthService authService,
    required ProductosService productosService,
  })  : _authService = authService,
        _productosService = productosService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Menú Principal',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              await _authService.signOut();
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
          ),
        ],
        backgroundColor: Colors.lightGreen[200],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IngresarComprasScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.lightGreen[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
              ),
              child: Text(
                'Ingresar Compras',
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VerProductosScreen(
                      productosService: _productosService,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.lightGreen[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
              ),
              child: Text(
                'Ver Compras Realizadas',
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EliminarProductoScreen(
                      productosService: _productosService,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.lightGreen[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
              ),
              child: Text(
                'Eliminar Compras',
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PreciosUnitariosScreen(
                      productosService: _productosService,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.lightGreen[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
              ),
              child: Text(
                'Precios',
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HacerCajaScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.lightGreen[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
              ),
              child: Text(
                'Hacer Caja',
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Proximamente(), // Agrega el nuevo botón
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.lightGreen[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
              ),
              child: Text(
                'Historial de Cajas',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
