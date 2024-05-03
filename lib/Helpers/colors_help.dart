import 'package:flutter/material.dart';

class HelperFunctions {
  static Color? getColor(String value) {
    switch (value.toLowerCase()) {
      case 'green':
        return Colors.green;
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      case 'pink':
        return Colors.pink;
      case 'grey':
        return const Color.fromARGB(255, 214, 214, 214);
      case 'purple':
        return Colors.purple;
      case 'black':
        return Colors.black;
      case 'white':
        return Colors.white;
      case 'yellow':
        return Colors.yellow;
      case 'orange':
        return Colors.orange;
      case 'brown':
        return Colors.brown;
      case 'gold':
        return Colors.amber;
      case 'cyan':
        return Colors.cyan;
      case 'teal':
        return Colors.teal;
      case 'light blue':
        return const Color.fromARGB(255, 160, 225, 255);
      case 'cream':
        return const Color.fromARGB(255, 255, 229, 195);
      case 'bronze':
        return const  Color(0xFFCD7F32);
      case 'beige':
        return const Color.fromARGB(255, 255, 226, 188);
      case 'silver':
        return Colors.grey.shade400;

      case 'indigo':
        return Colors.indigo;
      case 'lime':
        return Colors.lime;
      case 'deeporange':
        return Colors.deepOrange;
      case 'lightgreen':
        return Colors.lightGreen;
      case 'deepPurple':
        return Colors.deepPurple;
      case 'yellowAccent':
        return Colors.yellowAccent;
      case 'tealAccent':
        return Colors.tealAccent;
      case 'cyanAccent':
        return Colors.cyanAccent;
      case 'blueAccent':
        return Colors.blueAccent;
      case 'greenAccent':
        return Colors.greenAccent;
      case 'indigoAccent':
        return Colors.indigoAccent;
      case 'purpleAccent':
        return Colors.purpleAccent;
      default:
        return null;
    }
  }
}
