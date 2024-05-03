import 'package:fl_chart/fl_chart.dart';

class LineData {
  final spots = const [
    FlSpot(1.68, 21.04),
    FlSpot(1.68, 21.04),
    FlSpot(2.22, 25.4),
    FlSpot(5.6, 27.8),
    FlSpot(6.7, 29.3),
    FlSpot(10.3, 33.3),
    FlSpot(22.2, 40.6),
    FlSpot(30.9, 60.5),
    FlSpot(37.6, 55),
    FlSpot(40.2, 45),
    FlSpot(45.7, 48.6),
    FlSpot(50.9, 50.9),
    FlSpot(60.8, 70.8),
    FlSpot(68.6, 80.9),
    FlSpot(77.5, 60.3),
    FlSpot(80.4, 85.2),
    FlSpot(85.9, 88.6),
    FlSpot(90.9, 88.6),
    FlSpot(99.9, 88.6),
    FlSpot(110.15, 80.2),
    FlSpot(120.2, 90.1),
    FlSpot(121.1, 60.2),
  ];

  final leftTitle = {
    0: '0',
    20: '2K',
    40: '4K',
    60: '6K',
    80: '8K',
    100: '10K',
  };
  final bottomTitle = {
    0: 'Jan',
    10: 'Feb',
    20: 'Mar',
    30: 'Apr',
    40: 'May',
    50: 'Jun',
    60: 'Jul',
    70: 'Aug',
    80: 'Sep',
    90: 'Oct',
    100: 'Nov',
    110: 'Dec',
  };
}
