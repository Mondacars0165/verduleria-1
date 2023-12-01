// login.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:verduleria/servicios/auth.service.dart';
import 'package:verduleria/vistas/homeadm.dart';
import 'package:verduleria/vistas/homenrm.dart';
import 'package:verduleria/servicios/productos.services.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  Future<void> _signInWithEmailAndPassword(BuildContext context) async {
    String email = emailController.text.trim();
    String password = passwordController.text;

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        if (userCredential.user!.email == 'admin@admin.cl') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeAdmin(authService: _authService),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeNRM(
                authService: _authService,
                productosService: ProductosService(),
              ),
            ),
          );
        }
      } else {
        print('Error al iniciar sesión: Usuario nulo');
      }
    } catch (e) {
      print('Error al iniciar sesión: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lo Mejor Del Campo',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.lightGreen[200],
      ),
      body: SafeArea(
        child: Container(
          color: Colors.teal[200],
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 16.0),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'Correo electrónico',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 12.0),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Contraseña',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 12.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: () async {
                    await _signInWithEmailAndPassword(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightGreen[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                  ),
                  child: Text('Iniciar Sesión',
                      style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
