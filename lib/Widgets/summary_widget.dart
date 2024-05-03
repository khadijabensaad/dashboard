import '../Widgets/DashboardsWidgets/doura_chart_widget.dart';
import '../constants/const_colors.dart';
import 'package:flutter/material.dart';

class SummaryWidget extends StatelessWidget {
  const SummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: backgoundColor,
        child: const Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Chart(),
            Text(
              'Summary',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
                color: orange,
              ),
            ),
          ],
        ));
  }
}
