import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/constants/constants.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/screens/homepage.dart';
import 'package:social_media_app/screens/main_page.dart';
import 'package:social_media_app/shared_preferences.dart';
import 'package:social_media_app/widgets/display_image.dart';

import '../constants/colors.dart';
import '../stores/user_store.dart';
import '../utils.dart';

class AddNewUser extends StatefulWidget {
  @override
  _AddNewUserState createState() => _AddNewUserState();
}

class _AddNewUserState extends State<AddNewUser> {
  late UserStore userStore;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    userStore = Provider.of<UserStore>(context);
    await userStore.createUserObject(
      SocialMediaUser(
          userId: GlobalConstants.userId,
          phoneNumber: GlobalConstants.phoneNumber,
          userName: "",
          imageUrl: GlobalConstants.userAvatar),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: ((context) {
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
                    'Edit your Profile',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: COLORS.primaryColor,
                    ),
                  ),
                ),
              ),
              DisplayImage(
                  isLoading: userStore.isUpdatingProfile,
                  imagePath: userStore.user!.imageUrl != ""
                      ? userStore.user!.imageUrl.toString()
                      : "",
                  onPressed: () async {
                    ImagePicker _picker = ImagePicker();
                    await _picker.pickImage(source: ImageSource.gallery).then(
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
                                  initAspectRatio:
                                      CropAspectRatioPreset.original,
                                  lockAspectRatio: false),
                              IOSUiSettings(
                                title: 'Cropper',
                                aspectRatioLockEnabled: true,
                              ),
                            ],
                          );
                          if (croppedFile != null) {
                            userStore.addProfilePicture(
                                context: context, file: File(croppedFile.path));
                            setState(() {});
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
                  log("value is $value");
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                constraints: const BoxConstraints(maxWidth: 500),
                child: MaterialButton(
                  onPressed: () async {
                    if (firstNameController.text.isNotEmpty &&
                        lastNameController.text.isNotEmpty &&
                        userStore.user!.imageUrl!.isNotEmpty) {
                      String userName =
                          "${firstNameController.text} ${lastNameController.text}";
                      setUserName(userName);
                      bool success = await userStore.updateUser(
                          context: context,
                          field: FirestoreConstants.userName,
                          value: userName);
                      if (success) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (c) => MainPage()),
                            (route) => false);
                      } else {
                        buildShowSnackBar(context, "Something went wrong");
                      }
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
    }));
  }
}
