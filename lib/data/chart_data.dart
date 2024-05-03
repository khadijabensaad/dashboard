import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartData {
  final paiChartSelectionDatas = [
    PieChartSectionData(
      color: Colors.pink.shade800,
      value: 25,
      showTitle: false,
      radius: 25,
    ),
    PieChartSectionData(
      color: Colors.amber.shade200,
      value: 20,
      showTitle: false,
      radius: 22,
    ),
    PieChartSectionData(
      color: Colors.pink,
      value: 10,
      showTitle: false,
      radius: 19,
    ),
    PieChartSectionData(
      color: Colors.blueGrey.shade300,
      value: 25,
      showTitle: false,
      radius: 13,
    ),
    PieChartSectionData(
      color: Colors.white.withOpacity(0.9),
      value: 25,
      showTitle: false,
      radius: 13,
    ),
  ];
}
