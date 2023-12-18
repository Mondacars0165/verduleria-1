import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CajasTotalesScreen extends StatefulWidget {
  @override
  _CajasTotalesScreenState createState() => _CajasTotalesScreenState();
}

class _CajasTotalesScreenState extends State<CajasTotalesScreen> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cajas Totales'),
        backgroundColor: Colors.lightGreen[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<BarChartData>>(
          future: _fetchChartData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                  child: Text('Error obteniendo datos: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  'No hay datos disponibles',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              );
            } else {
              List<BarChartData> data = snapshot.data!;
              return charts.BarChart(
                [
                  charts.Series<BarChartData, String>(
                    id: 'CajasTotales',
                    domainFn: (BarChartData sales, _) => sales.date,
                    measureFn: (BarChartData sales, _) => sales.amount,
                    data: data,
                  ),
                ],
                animate: true,
                animationDuration: Duration(milliseconds: 500),
                domainAxis: charts.OrdinalAxisSpec(
                  renderSpec: charts.SmallTickRendererSpec(
                    labelStyle: charts.TextStyleSpec(
                      fontSize: 12,
                    ),
                  ),
                ),
                primaryMeasureAxis: charts.NumericAxisSpec(
                  renderSpec: charts.GridlineRendererSpec(
                    labelStyle: charts.TextStyleSpec(
                      fontSize: 12,
                    ),
                  ),
                ),
                behaviors: [
                  charts.ChartTitle(
                    'Fechas',
                    behaviorPosition: charts.BehaviorPosition.bottom,
                    titleStyleSpec: charts.TextStyleSpec(fontSize: 16),
                    titleOutsideJustification:
                        charts.OutsideJustification.middleDrawArea,
                  ),
                  charts.ChartTitle(
                    'Monto Total',
                    behaviorPosition: charts.BehaviorPosition.start,
                    titleStyleSpec: charts.TextStyleSpec(fontSize: 16),
                    titleOutsideJustification:
                        charts.OutsideJustification.middleDrawArea,
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<List<BarChartData>> _fetchChartData() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _db.collection('cajas').get();

    print("Query Snapshot Size: ${querySnapshot.size}");

    List<BarChartData> data = querySnapshot.docs.map((doc) {
      print("Document Data: ${doc.data()}");

      dynamic fecha = doc['fecha'];
      DateTime date;

      if (fecha is Timestamp) {
        date = fecha.toDate();
      } else if (fecha is String) {
        date = DateTime.parse(fecha);
      } else {
        throw Exception("Formato de fecha desconocido");
      }

      return BarChartData(
        _formattedDate(date),
        doc['montoTotal'].toDouble(),
      );
    }).toList();

    print("Data Size: ${data.length}");

    return data;
  }

  String _formattedDate(DateTime date) {
    return DateFormat('d/M/yyyy').format(date);
  }
}

class BarChartData {
  final String date;
  final double amount;

  BarChartData(this.date, this.amount);
}
