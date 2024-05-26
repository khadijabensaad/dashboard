import 'package:admintest/Widgets/summary_widget.dart';
import 'package:admintest/util/responsive_ui.dart';

import '../header_widget.dart';
import '../DashboardsWidgets/line_chart_widget.dart';
import '../DashboardsWidgets/product_info_card.dart';
import '../../Widgets/DashboardsWidgets/bar_graph_widget.dart';
import 'package:flutter/material.dart';

class DashBoardWidget extends StatefulWidget {
  DashBoardWidget({super.key});

  @override
  State<DashBoardWidget> createState() => _DashBoardWidgetState();
}

class _DashBoardWidgetState extends State<DashBoardWidget> {
  TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            const SizedBox(
              height: 18,
            ),
            HeaderWidget(scaffoldContext: context, cntrl: _searchController),
            const SizedBox(
              height: 18,
            ),
            const ProductInfoCards(),
            const SizedBox(
              height: 18,
            ),
            const LineChartCardWidget(),
            const SizedBox(
              height: 18,
            ),
            const BarGraphWidget(),
            const SizedBox(
              height: 18,
            ),
            if (ResponsiveUI.isTablet(context)) const SummaryWidget(),
          ],
        ),
      ),
    );
  }
}
