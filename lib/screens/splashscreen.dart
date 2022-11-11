// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:social_media_app/screens/add_new_user.dart';
import 'package:social_media_app/shared_preferences.dart';

import 'login.dart';
import 'main_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () async {
      String userId = await getId();
      String userName = await getuserName();
      log(userId);
      log(userName);
      if (userId != "" && userName != "") {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: ((context) => MainPage())),
          (route) => false,
        );
      } else if (userId != "" && userName == "") {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: ((context) => AddNewUser())),
          (route) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: ((context) => Login())),
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/social-media.jpeg'),
                // const CircularProgressIndicator()
              ],
            ),
          )),
    );
  }
}
