import '../Models/GraphsModels/bar_graph_model.dart';
import '../Models/GraphsModels/graph_model.dart';
import '../constants/const_colors.dart';
import 'package:flutter/material.dart';

class BarGraphData {
  final data = [
    const BarGraphModel(
      color: orange,
      label: "Total searches",
      graph: [
        GraphModel(x: 0, y: 8),
        GraphModel(x: 1, y: 10),
        GraphModel(x: 2, y: 7),
        GraphModel(x: 3, y: 4),
        GraphModel(x: 4, y: 4),
        GraphModel(x: 5, y: 6),
      ],
    ),
    BarGraphModel(
      color: Colors.teal.shade100,
      label: "Total reviews",
      graph: [
        const GraphModel(x: 0, y: 4),
        const GraphModel(x: 1, y: 10),
        const GraphModel(x: 2, y: 2),
        const GraphModel(x: 3, y: 4),
        const GraphModel(x: 4, y: 8),
        const GraphModel(x: 5, y: 3),
      ],
    ),
    BarGraphModel(
      color: Colors.green.shade200,
      label: "Total reviews",
      graph: [
        const GraphModel(x: 0, y: 4),
        const GraphModel(x: 1, y: 10),
        const GraphModel(x: 2, y: 2),
        const GraphModel(x: 3, y: 4),
        const GraphModel(x: 4, y: 8),
        const GraphModel(x: 5, y: 3),
      ],
    ),
  ];
  final label = ['M', 'T', 'W', 'T', 'F', 'S'];
}
