import 'package:flutter/material.dart';
import 'package:verduleria/servicios/auth.service.dart';

class HomeNormalUser extends StatelessWidget {
  final AuthService _authService;

  HomeNormalUser({required AuthService authService})
      : _authService = authService;

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
              // Cerrar sesión al hacer clic en el botón de cerrar sesión
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
                // Acción para "Ingresar Compras"
              },
              child: Text('Ingresar Compras'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Acción para "Ver Compras"
              },
              child: Text('Ver Compras'),
            ),
          ],
        ),
      ),
    );
  }
}
