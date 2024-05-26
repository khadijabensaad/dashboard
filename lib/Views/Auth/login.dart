import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import '../../constants/const_colors.dart';
import '../../util/main_screen_responsive.dart';
import '../../util/responsive_ui.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _emailcntrl;
  late TextEditingController _passwordcntrl;
  bool isObscured = true;
  String _emailErrorText = "";
  String _passwordErrorText = "";
  bool _hasErrorEmail = false;
  bool _hasErrorPassword = false;
  int _counterTesterError = 0;
  String message = '';
  late SharedPreferences prefs;

  //tsirelha exec 9bal ma l'app tbuildi
  @override
  void initState() {
    _emailcntrl = TextEditingController();
    _passwordcntrl = TextEditingController();
    initSharedPref();
    super.initState();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> loginUser() async {
    var reqBody = jsonEncode(
        {"email": _emailcntrl.text, "password": _passwordcntrl.text});
    String url = 'http://192.168.1.113:5000/auth/login';
    var response = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'}, body: reqBody);
    var jsonResponse = jsonDecode(response.body);
    setState(() {
      message = jsonResponse["message"];
    });
    print(message);
    if (jsonResponse["status"]) {
      var userToken = jsonResponse['token'];
      prefs.setString("userToken", userToken);
      prefs.setBool("activated", true);
      //bech nbadlou .push ba3d ma na3mlou les tests
      Get.offAll(() => const MainScreenResponsive());
      /*Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(
              builder: (context) => const MainScreenResponsive()),
          (route) => false);*/
    }
    //  navigationController.navigateTo("MainScreenResponsive");
    //Fluttertoast.showToast(msg: message,);
  }

  //libere l'espace memoire
  @override
  void dispose() {
    _emailcntrl.dispose();
    _passwordcntrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 70,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(
                    "Login",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: orange,
                        fontFamily: 'Poppins',
                        fontSize: 45),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(
                    "Welcome back to the admin panel",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 129, 129, 129),
                        fontFamily: 'Poppins',
                        fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 0,
                ),
                if (ResponsiveUI.isDesktop(context))
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 400, right: 400, bottom: 5, top: 5),
                    child: TextField(
                      controller: _emailcntrl,
                      cursorColor: orange,
                      style: const TextStyle(
                          fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        errorText: _emailErrorText,
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: _hasErrorEmail ? Colors.red : orange,
                                width: 2),
                            gapPadding: 10),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: _hasErrorEmail ? Colors.red : orange,
                                width: 2),
                            gapPadding: 10),
                        labelText: "Email",
                        hintText: "Enter your email",
                        labelStyle: const TextStyle(
                            color: orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            fontFamily: 'Poppins'),
                        prefixIcon: const Icon(CupertinoIcons.mail,
                            size: 25, color: darkGrey),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 20),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: orange, width: 2),
                            gapPadding: 10),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: orange, width: 2),
                            gapPadding: 10),
                        errorStyle: const TextStyle(
                            color: Colors.red,
                            fontSize: 11,
                            fontFamily: 'Poppins'),
                      ),
                      onChanged: (value) {
                        setState(() {
                          if (_counterTesterError != 0) {
                            if (value.isEmpty) {
                              _emailErrorText = "This field cannot be empty!";
                              _hasErrorEmail = true;
                            } else if (!value.contains('@') ||
                                !value.contains('.')) {
                              _emailErrorText = "Email is not valid!";
                              _hasErrorEmail = true;
                            } else {
                              _emailErrorText = '';
                              _hasErrorEmail = false;
                            }
                          }
                        });
                      },
                      onTap: () {
                        setState(() {
                          if (_counterTesterError != 0) {
                            if (_emailcntrl.text.isEmpty) {
                              _emailErrorText = "This field cannot be empty!";
                              _hasErrorEmail = true;
                            } else if (!_emailcntrl.text.contains('@') ||
                                !_emailcntrl.text.contains('.')) {
                              _emailErrorText = "Email is not valid!";
                              _hasErrorEmail = true;
                            } else {
                              _emailErrorText = '';
                              _hasErrorEmail = false;
                            }
                          }
                        });
                      },
                    ),
                  ),
                if (!ResponsiveUI.isDesktop(context))
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 0, right: 0, bottom: 5, top: 5),
                    child: TextField(
                      controller: _emailcntrl,
                      cursorColor: orange,
                      style: const TextStyle(
                          fontFamily: 'Poppins', fontWeight: FontWeight.w600),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        errorText: _emailErrorText,
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: _hasErrorEmail ? Colors.red : orange,
                                width: 2),
                            gapPadding: 10),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: _hasErrorEmail ? Colors.red : orange,
                                width: 2),
                            gapPadding: 10),
                        labelText: "Email",
                        hintText: "Enter your email",
                        labelStyle: const TextStyle(
                            color: orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            fontFamily: 'Poppins'),
                        prefixIcon: const Icon(CupertinoIcons.mail,
                            size: 25, color: darkGrey),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 20),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: orange, width: 2),
                            gapPadding: 10),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: orange, width: 2),
                            gapPadding: 10),
                        errorStyle: const TextStyle(
                            color: Colors.red,
                            fontSize: 11,
                            fontFamily: 'Poppins'),
                      ),
                      onChanged: (value) {
                        setState(() {
                          if (_counterTesterError != 0) {
                            if (value.isEmpty) {
                              _emailErrorText = "This field cannot be empty!";
                              _hasErrorEmail = true;
                            } else if (!value.contains('@') ||
                                !value.contains('.')) {
                              _emailErrorText = "Email is not valid!";
                              _hasErrorEmail = true;
                            } else {
                              _emailErrorText = '';
                              _hasErrorEmail = false;
                            }
                          }
                        });
                      },
                      onTap: () {
                        setState(() {
                          if (_counterTesterError != 0) {
                            if (_emailcntrl.text.isEmpty) {
                              _emailErrorText = "This field cannot be empty!";
                              _hasErrorEmail = true;
                            } else if (!_emailcntrl.text.contains('@') ||
                                !_emailcntrl.text.contains('.')) {
                              _emailErrorText = "Email is not valid!";
                              _hasErrorEmail = true;
                            } else {
                              _emailErrorText = '';
                              _hasErrorEmail = false;
                            }
                          }
                        });
                      },
                    ),
                  ),
                if (!ResponsiveUI.isDesktop(context))
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                    child: TextField(
                      controller: _passwordcntrl,
                      cursorColor: orange,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                      obscureText: isObscured,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "Enter your password",
                        errorText: _passwordErrorText,
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: _hasErrorPassword ? Colors.red : orange,
                                width: 2),
                            gapPadding: 10),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: _hasErrorPassword ? Colors.red : orange,
                                width: 2),
                            gapPadding: 10),
                        errorStyle: const TextStyle(
                            color: Colors.red,
                            fontSize: 11,
                            fontFamily: 'Poppins'),
                        labelStyle: const TextStyle(
                            color: orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            fontFamily: 'Poppins'),
                        prefixIcon: const Icon(CupertinoIcons.lock_fill,
                            size: 25, color: darkGrey),
                        suffix: IconButton(
                          icon: isObscured
                              ? const Icon(
                                  CupertinoIcons.eye_slash_fill,
                                  size: 23,
                                  color: darkGrey,
                                )
                              : const Icon(
                                  CupertinoIcons.eye_fill,
                                  size: 23,
                                  color: darkGrey,
                                ),
                          onPressed: () {
                            setState(() {
                              isObscured = !isObscured;
                            });
                          },
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: const EdgeInsets.fromLTRB(50, 5, 5, 10),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: orange, width: 2),
                            gapPadding: 10),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: orange, width: 2),
                            gapPadding: 10),
                      ),
                      onChanged: (value) {
                        setState(() {
                          if (_counterTesterError != 0) {
                            if (value.length < 8) {
                              _passwordErrorText =
                                  "Password should at least contain 8 characters!";
                              _hasErrorPassword = true;
                            } else {
                              _passwordErrorText = "";
                              _hasErrorPassword = false;
                            }
                          }
                        });
                      },
                      onTap: () {
                        setState(() {
                          if (_counterTesterError != 0) {
                            if (_passwordcntrl.text.length < 8) {
                              _passwordErrorText =
                                  "Password should at least contain 8 characters!";
                              _hasErrorPassword = true;
                            } else {
                              _passwordErrorText = "";
                              _hasErrorPassword = false;
                            }
                          }
                        });
                      },
                    ),
                  ),
                if (ResponsiveUI.isDesktop(context))
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 400, vertical: 5),
                    child: TextField(
                      controller: _passwordcntrl,
                      cursorColor: orange,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                      obscureText: isObscured,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "Enter your password",
                        errorText: _passwordErrorText,
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: _hasErrorPassword ? Colors.red : orange,
                                width: 2),
                            gapPadding: 10),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: _hasErrorPassword ? Colors.red : orange,
                                width: 2),
                            gapPadding: 10),
                        errorStyle: const TextStyle(
                            color: Colors.red,
                            fontSize: 11,
                            fontFamily: 'Poppins'),
                        labelStyle: const TextStyle(
                            color: orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            fontFamily: 'Poppins'),
                        prefixIcon: const Icon(CupertinoIcons.lock_fill,
                            size: 25, color: darkGrey),
                        suffix: IconButton(
                          icon: isObscured
                              ? const Icon(
                                  CupertinoIcons.eye_slash_fill,
                                  size: 23,
                                  color: darkGrey,
                                )
                              : const Icon(
                                  CupertinoIcons.eye_fill,
                                  size: 23,
                                  color: darkGrey,
                                ),
                          onPressed: () {
                            setState(() {
                              isObscured = !isObscured;
                            });
                          },
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: const EdgeInsets.fromLTRB(50, 5, 5, 10),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: orange, width: 2),
                            gapPadding: 10),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: orange, width: 2),
                            gapPadding: 10),
                      ),
                      onChanged: (value) {
                        setState(() {
                          if (_counterTesterError != 0) {
                            if (value.length < 8) {
                              _passwordErrorText =
                                  "Password should at least contain 8 characters!";
                              _hasErrorPassword = true;
                            } else {
                              _passwordErrorText = "";
                              _hasErrorPassword = false;
                            }
                          }
                        });
                      },
                      onTap: () {
                        setState(() {
                          if (_counterTesterError != 0) {
                            if (_passwordcntrl.text.length < 8) {
                              _passwordErrorText =
                                  "Password should at least contain 8 characters!";
                              _hasErrorPassword = true;
                            } else {
                              _passwordErrorText = "";
                              _hasErrorPassword = false;
                            }
                          }
                        });
                      },
                    ),
                  ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 250,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: orange, // background color
                        ),
                        child: const Text(
                          'LOG IN',
                          style: TextStyle(
                              color: darkBrown,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins'),
                        ),
                        onPressed: () {
                          if (_emailcntrl.text.isNotEmpty &&
                              (_emailcntrl.text.contains('@') &&
                                  _emailcntrl.text.contains('.')) &&
                              (_passwordcntrl.text.length > 7)) {
                            //lenna win bech nekhdmou
                            loginUser()
                                .whenComplete(() => Fluttertoast.showToast(
                                      msg: message,
                                      toastLength: Toast.LENGTH_LONG,
                                      backgroundColor:
                                          Colors.black.withOpacity(0.7),
                                    ));
                            //  navigationController.navigateTo("MainScreenResponsive");
                            //Navigator.push(context, CupertinoPageRoute(builder: (context)=>const  MainScreenPage()));
                            //_authCallAPi.login();
                          }
                          setState(() {
                            _counterTesterError += 1;
                            if (_emailcntrl.text.isEmpty) {
                              _emailErrorText = "This field cannot be empty!";
                              _hasErrorEmail = true;
                            } else if (!_emailcntrl.text.contains('@') ||
                                !_emailcntrl.text.contains('.')) {
                              _emailErrorText = "Email is not valid!";
                              _hasErrorEmail = true;
                            }
                            if (_passwordcntrl.text.length < 8) {
                              _passwordErrorText =
                                  "Password should at least contain 8 characters!";
                              _hasErrorPassword = true;
                            }
                          });
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
