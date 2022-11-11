import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/shared_preferences.dart';
import 'package:social_media_app/widgets/display_image.dart';

import '../constants/colors.dart';
import '../stores/user_store.dart';
import '../utils.dart';

// This class handles the Page to dispaly the user's info on the "Edit Profile" Screen
class AddNewUser extends StatefulWidget {
  @override
  _AddNewUserState createState() => _AddNewUserState();
}

class _AddNewUserState extends State<AddNewUser> {
  late UserStore userStore;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userStore = Provider.of<UserStore>(context);
  }

  // @override
  // void initState() {
  //   super.initState();
  //   userStore = Provider.of<UserStore>(context);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              toolbarHeight: 10,
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  'Add your Profile',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: COLORS.primaryColor,
                  ),
                ),
              ),
            ),
            DisplayImage(
                imagePath: "",
                onPressed: () {
                  ImagePicker _picker = ImagePicker();

                  _picker.pickImage(source: ImageSource.gallery).then(
                    (pickedFile) async {
                      if (pickedFile != null) {
                        final croppedFile = await ImageCropper().cropImage(
                          sourcePath: pickedFile.path,
                          compressFormat: ImageCompressFormat.jpg,
                          compressQuality: 100,
                          uiSettings: [
                            AndroidUiSettings(
                                toolbarTitle: 'Cropper',
                                toolbarColor: COLORS.primaryColor,
                                toolbarWidgetColor: Colors.white,
                                initAspectRatio: CropAspectRatioPreset.original,
                                lockAspectRatio: false),
                            IOSUiSettings(
                              title: 'Cropper',
                              aspectRatioLockEnabled: true,
                            ),
                          ],
                        );
                        if (croppedFile != null) {
                          userStore.addProfilePicture(
                              file: File(croppedFile.path));
                        }
                      }
                    },
                  ).onError((error, stackTrace) {
                    log(error.toString());
                    buildShowSnackBar(context, "Image could not be selected");
                  });
                }),
            TextFormField(
              controller: firstNameController,
              decoration: const InputDecoration(hintText: "First Name"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            TextFormField(
              controller: lastNameController,
              decoration: const InputDecoration(hintText: "Last Name"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              constraints: const BoxConstraints(maxWidth: 500),
              child: MaterialButton(
                onPressed: () {
                  if (firstNameController.text.isNotEmpty &&
                      lastNameController.text.isNotEmpty) {
                    setUserName(
                        "${firstNameController.text} ${lastNameController.text}");
                    userStore.updateDisplayName(
                        "${firstNameController.text} ${lastNameController.text}");
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                      content: Text(
                        'Please enter a phone number',
                        style: TextStyle(color: Colors.white),
                      ),
                    ));
                  }
                },
                color: COLORS.primaryColor,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(14))),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Next',
                        style: TextStyle(color: Colors.white),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          color: COLORS.primaryColorLight,
                        ),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 16,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
