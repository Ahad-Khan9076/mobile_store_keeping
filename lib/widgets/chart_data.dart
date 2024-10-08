// chart_data.dart
import 'package:fl_chart/fl_chart.dart';

class ChartData {
  static List<FlSpot> productionData = [
    FlSpot(1, 200),
    FlSpot(2, 400),
    FlSpot(3, 300),
  ];

  static List<FlSpot> soldData = [
    FlSpot(1, 150),
    FlSpot(2, 350),
    FlSpot(3, 250),
  ];

  static var salesData;

  // Function to update data dynamically
  static void updateProductionData(List<FlSpot> newData) {
    productionData = newData;
  }

  static void updateSoldData(List<FlSpot> newData) {
    soldData = newData;
  }
}
