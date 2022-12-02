import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/shared_preferences.dart';
import 'package:social_media_app/stores/login_store.dart';

import '../screens/login.dart';

showAlertDialog({required BuildContext context}) {
  // set up the buttons
  Widget cancelButton = MaterialButton(
    color: COLORS.secondaryColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: Text(
      "Cancel",
      style: TextStyle(color: Colors.white),
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget launchButton = MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: COLORS.secondaryColorLight,
      child: Text(
        "Logout",
        style: TextStyle(color: Colors.black),
      ),
      onPressed: () async {
        LoginStore().signOut(context);
      });
  AlertDialog alert = AlertDialog(
    title: Text("Logout"),
    content: Text("Are you sure you want to log out?"),
    actions: [
      cancelButton,
      launchButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
