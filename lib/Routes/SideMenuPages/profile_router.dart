import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Controllers/CRUDControllers/auth_api.dart';
import '../../Models/CRUDModels/user_model.dart';
import '../../Views/Auth/login.dart';
import '../../constants/const_colors.dart';

class ProfileRouter extends StatefulWidget {
  const ProfileRouter({super.key, required this.id, required this.user});
  final String id;
  final UserModel user;
  @override
  State<ProfileRouter> createState() => _ProfileRouterState();
}

class _ProfileRouterState extends State<ProfileRouter> {
  bool isLoading = true;
  AuthCallAPi _authCallAPi = AuthCallAPi();
  late SharedPreferences prefs;

  @override
  void initState() {
    initSharedPref();
    super.initState();
  }

  void initSharedPref() async {
    print("id: ${widget.id}");
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgoundColor,
      appBar: AppBar(
        backgroundColor: backgoundColor,
        title: const Text("My Profile",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color: Colors.black,
                fontSize: 18)),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FutureBuilder(
            future: _authCallAPi.getUserById(widget.user.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print("id: ${widget.id}");
                return Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        CircleAvatar(
                          backgroundColor: backgoundColor,
                          radius: 80,
                          child: ClipOval(
                            child: Image.network(
                              snapshot.data!.image,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 0, right: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Username:",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: darkBrown),
                              ),
                              Text("${snapshot.data?.username}",
                                  style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                'Email: ',
                                style: TextStyle(
                                  color: darkBrown,
                                  fontSize: 20,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  height: 0,
                                ),
                              ),
                              Text(
                                '${snapshot.data?.email}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w800,
                                  height: 0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                        Container(
                          width: 170,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: orange, // background color
                              ),
                              onPressed: () {
                                prefs.setBool("activated", false);
                                /*   Navigator.pushAndRemoveUntil(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) => LoginPage(),
                                    ),
                                    (route) => false);*/
                                Get.offAll(() => const LoginPage());
                              },
                              child: const Text(
                                "LOG OUT",
                                style: TextStyle(
                                    color: darkBrown,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins'),
                              )),
                        ),
                        //Expanded(child: SizedBox(), flex: 1,),
                      ],
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: darkBrown,
                  ),
                );
              }
            },
          )
        ],
      )),
    );
  }
}
