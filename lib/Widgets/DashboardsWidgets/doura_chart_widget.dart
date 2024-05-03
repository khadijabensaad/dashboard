import '../../constants/const_colors.dart';
import '../../data/chart_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({super.key});

  @override
  Widget build(BuildContext context) {
    final pieChartData = ChartData();
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
                sectionsSpace: 0,
                centerSpaceRadius: 70,
                startDegreeOffset: -90,
                sections: pieChartData.paiChartSelectionDatas),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Text(
                  "70%",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: orange,
                      fontWeight: FontWeight.w600,
                      height: 0.5,
                      fontFamily: 'Poppins'),
                ),
                const SizedBox(height: 10),
                const Text(
                  'of 100%',
                  style: TextStyle(
                      color: orange,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      height: 0.5,
                      fontFamily: 'Poppins'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
