import 'package:flutter/material.dart';

class Proximamente extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter En Proceso'),
        ),
        body: Center(
          child: Text(
            'En proceso',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
