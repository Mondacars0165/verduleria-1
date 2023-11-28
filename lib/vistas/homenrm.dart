import 'package:flutter/material.dart';
import 'package:verduleria/servicios/productos.services.dart';
import 'package:verduleria/vistas/verproductos.dart';
import 'package:verduleria/vistas/agregarproductos.dart';
import 'package:verduleria/vistas/eliminarproductos.dart';
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
        title: Text('Menú principal'),
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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bienvenido, Usuario Normal'),
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
              child: Text('Ingresar Compras'),
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
              child: Text('Ver Compras'),
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
              child: Text('Eliminar Compra'),
            ),
            // Agrega más botones u opciones según sea necesario
          ],
        ),
      ),
    );
  }
}
