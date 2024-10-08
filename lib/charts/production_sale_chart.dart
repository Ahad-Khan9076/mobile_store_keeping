// production_sales_chart.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../widgets/chart_data.dart';

class ProductionSalesChart extends StatefulWidget {
  @override
  _ProductionSalesChartState createState() => _ProductionSalesChartState();
}

class _ProductionSalesChartState extends State<ProductionSalesChart> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Production vs Sold',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (value, meta) {
                          switch (value.toInt()) {
                            case 1:
                              return Text('Product A');
                            case 2:
                              return Text('Product B');
                            case 3:
                              return Text('Product C');
                          }
                          return Text('');
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: true, border: Border.all(color: Colors.grey.withOpacity(0.5))),
                  minX: 0,
                  maxX: 4,
                  minY: 0,
                  maxY: 600,
                  lineBarsData: [
                    LineChartBarData(
                      spots: ChartData.productionData,
                      isCurved: true,
                      color: Colors.green,
                      belowBarData: BarAreaData(show: false),
                      dotData: FlDotData(show: true, getDotPainter: (spot, _, __, ___) {
                        return FlDotCirclePainter(radius: 5, color: Colors.greenAccent);
                      }),
                    ),
                    LineChartBarData(
                      spots: ChartData.soldData,
                      isCurved: true,
                      color: Colors.red,
                      belowBarData: BarAreaData(show: false),
                      dotData: FlDotData(show: true, getDotPainter: (spot, _, __, ___) {
                        return FlDotCirclePainter(radius: 5, color: Colors.redAccent);
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
