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

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late UserStore userStore;
  TextEditingController userNameController = TextEditingController();

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    userStore = Provider.of<UserStore>(context);
    await userStore.fetchUser(GlobalConstants.userId);
    userNameController.text = userStore.user!.userName;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: ((context) {
      return WillPopScope(
          child: Scaffold(
            appBar: AppBar(
              foregroundColor: Colors.white,
              backgroundColor: COLORS.secondaryColor,
              elevation: 0,
              // toolbarHeight: 10,
              automaticallyImplyLeading: false,
              leading: GestureDetector(
                child: Icon(Icons.arrow_back),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (c) {
                    return MainPage(
                      currentTabIndex: 2,
                    );
                  }));
                },
              ),
              centerTitle: true,
              title: Container(
                child: Text(
                  'Edit your Profile',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DisplayImage(
                      isLoading: userStore.isUpdatingProfile,
                      imagePath: userStore.user!.imageUrl != ""
                          ? userStore.user!.imageUrl.toString()
                          : "",
                      onPressed: () async {
                        ImagePicker _picker = ImagePicker();

                        await _picker
                            .pickImage(source: ImageSource.gallery)
                            .then(
                          (pickedFile) async {
                            if (pickedFile != null) {
                              final croppedFile =
                                  await ImageCropper().cropImage(
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
                                    context: context,
                                    file: File(croppedFile.path));
                                setState(() {});
                              }
                            }
                          },
                        ).onError((error, stackTrace) {
                          log(error.toString());
                          buildShowSnackBar(
                              context, "Image could not be selected");
                        });
                      }),
                  // TextFormField(
                  //   controller: firstNameController,
                  //   decoration: const InputDecoration(hintText: "First Name"),
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please enter some text';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  TextFormField(
                    controller: userNameController,
                    decoration: const InputDecoration(hintText: "Username"),
                    validator: (value) {
                      log("value is $value");
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: MaterialButton(
                      onPressed: () async {
                        if (userNameController.text.isNotEmpty &&
                            userStore.user!.imageUrl!.isNotEmpty) {
                          setUserName(userNameController.text);
                          bool success = await userStore.updateUser(
                              context: context,
                              field: FirestoreConstants.userName,
                              value: userNameController.text);
                          if (!success) {
                            buildShowSnackBar(context, "Something went wrong");
                          }
                        }
                      },
                      color: COLORS.secondaryColor,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14))),
                      child: const Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          onWillPop: () async {
            return false;
          });
    }));
  }
}
