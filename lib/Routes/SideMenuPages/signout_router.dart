import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Views/Auth/login.dart';

class SignOutPageRouter extends StatelessWidget {
  late Future<SharedPreferences> prefsFuture;

  SignOutPageRouter({Key? key}) : super(key: key) {
    prefsFuture = SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return /*AlertDialog(
      title: const Text('Sign Out'),
      content: const Text('Are you sure you want to sign out?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            // Close the dialog when cancel button is pressed
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            SharedPreferences prefs = await prefsFuture;
            await prefs.setBool("activated", false);
            Get.offAll(() => const LoginPage());
          },
          child: const Text('Sign Out'),
        ),
      ],
    );*/
        AlertDialog(
      icon: const Icon(Icons.warning_amber_rounded, size: 50),
      iconColor: Color(0xFF965D1A),
      backgroundColor: Color(0xFFFDF1E1),
      title: const Text(
        'Sign Out',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
            color: Colors.black,
            fontSize: 20),
      ),
      content: const Text(
        'Are you sure you want to sign out???',
        style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.black,
            fontWeight: FontWeight.bold),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();

            // Close the dialog after deletion
          },
          child: const Text('Cancel',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Color(0xFF965D1A),
                  fontWeight: FontWeight.bold)),
        ),
        TextButton(
          onPressed: () async {
            SharedPreferences prefs = await prefsFuture;
            await prefs.setBool("activated", false);
            Get.offAll(() => const LoginPage());

            // Navigator.of(context).pop();
          },

          // Close the dialog after deletion

          child: const Text('Sign Out',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Color(0xFF965D1A),
                  fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
