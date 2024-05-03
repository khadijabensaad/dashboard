import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  const AppBarWidget({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFFDF1E1),
      leading: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(CupertinoIcons.arrow_left),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      title: Text(
        widget.title, // Accessing title through widget property
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      /* actions: [
  IconButton(
          icon: const Icon(Icons.filter_alt_outlined),
          onPressed: () {},
        ),
      ],*/
    );
  }
}
