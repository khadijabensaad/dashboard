import 'package:admintest/util/responsive_ui.dart';
import '../constants/const_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatefulWidget {
  final TextEditingController cntrl;
  final BuildContext scaffoldContext;
  //const HeaderWidget({super.key});

  HeaderWidget({Key? key, required this.scaffoldContext, required this.cntrl})
      : super(key: key);

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (!ResponsiveUI.isDesktop(context))
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () {
                // Use the GlobalKey to open the drawer
                // Get.to(() => const SideMenu());
                //_scaffoldKey.currentState?.openDrawer();
                Scaffold.of(widget.scaffoldContext).openDrawer();
              },
              child: const Padding(
                padding: EdgeInsets.all(4.0),
                child: Icon(
                  Icons.menu_outlined,
                  color: Colors.black,
                  size: 25,
                ),
              ),
            ),
          ),
        if (!ResponsiveUI.isMobile(context))
          Expanded(
            child: TextField(
              controller: widget.cntrl,
              cursorColor: orange,
              style: const TextStyle(
                  fontFamily: 'Poppins', fontWeight: FontWeight.w600),
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                hintText: "Search ",
                prefixIcon: IconButton(
                  icon: const Icon(
                    CupertinoIcons.search,
                    size: 25,
                    color: darkGrey,
                  ),
                  splashRadius: 10,
                  onPressed: () {},
                ),
                suffixIcon: IconButton(
                  icon: const Icon(
                    CupertinoIcons.mic,
                    size: 23,
                    color: darkGrey,
                  ),
                  splashRadius: 10,
                  onPressed: () {},
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding: const EdgeInsets.fromLTRB(50, 5, 1, 10),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: orange, width: 2),
                    gapPadding: 10),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: orange, width: 2),
                    gapPadding: 10),
              ),
              onChanged: (value) {},
              onTap: () {},
            ),
          ),
        if (ResponsiveUI.isMobile(context))
          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search_outlined,
                    color: Colors.black,
                    size: 25,
                  )),
              InkWell(
                onTap: () {
                  Scaffold.of(widget.scaffoldContext).openEndDrawer();
                },
                child: CircleAvatar(
                  backgroundColor: backgoundColor,
                  child: ClipOval(
                    child: Image.asset(
                      "assets/images/dash3.jpg",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  radius: 16,
                ),
              )
            ],
          )
      ],
    );
  }
}
