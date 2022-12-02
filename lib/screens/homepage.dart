// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/constants/constants.dart';
import 'package:social_media_app/screens/post_page.dart';
import 'package:social_media_app/stores/post_store.dart';
import 'package:social_media_app/stores/user_store.dart';
import 'package:social_media_app/utils.dart';
import 'package:social_media_app/widgets/profile_image_avatar.dart';

import '../constants/colors.dart';
import '../models/post.dart';
import '../widgets/loader.dart';
import 'create_post.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CroppedFile? _croppedFile;
  ImagePicker _picker = ImagePicker();
  late PostStore postStore;
  late UserStore userStore;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    userStore = Provider.of<UserStore>(context);
    postStore = Provider.of<PostStore>(context);
    await userStore.setUser(GlobalConstants.userId);
    await postStore.loadPosts(context);
  }

  @override
  Widget build(BuildContext context) {
    // return Consumer<PostStore>(
    //   builder: ((context, postStore, child) {
    // postStore.fetchAllPosts(context).listen((event) {}).onData((data) {
    //   postStore.posts.clear();
    //   postStore.loadPosts(context);
    // });
    return Observer(builder: (_) {
      log(postStore.posts.length.toString());
      return LoaderHUD(
        inAsyncCall: postStore.isPostLoading,
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 249, 249, 249),
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Welcome',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Bi;})llabong',
                        fontSize: 30.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.add, color: Colors.black),
                        iconSize: 28.0,
                        onPressed: () {
                          _picker.pickImage(source: ImageSource.gallery).then(
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
                                  setState(() {
                                    _croppedFile = croppedFile;
                                  });
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CreatePost(
                                        croppedFilePath: _croppedFile!.path,
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                          ).onError((error, stackTrace) {
                            log(error.toString());
                            buildShowSnackBar(
                                context, "Image could not be selected");
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.refresh, color: Colors.black),
                        iconSize: 28.0,
                        onPressed: () => postStore.loadPosts(context),
                      ),
                      IconButton(
                        icon: const Icon(Icons.message_outlined,
                            color: Colors.black),
                        iconSize: 28.0,
                        onPressed: () => print('ok ok '),
                      ),
                    ],
                  )
                ]),
          ),
          body: bodyMainList(
            postStore: postStore,
            context: context,
            userStore: userStore,
          ),
          // bottomNavigationBar: mainFooterPage(),
        ),
      );
      // });
    });
    // );
  }
}

Widget bodyMainList({
  required PostStore postStore,
  required BuildContext context,
  required UserStore userStore,
}) {
  return Column(
    children: <Widget>[
      Expanded(
        // height: 900,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: postStore.posts.length,
            itemBuilder: (context, i) {
              if (userStore.user!.following!
                      .contains(postStore.posts[i].userId) ||
                  postStore.posts[i].userId == userStore.user!.userId) {
                return _post(context, postStore.posts[i]);
              } else if (userStore.user!.following!.isEmpty) {
                return _post(context, postStore.posts[i]);
              }
              return Container();
            }),
      ),
    ],
  );
}

ClipRRect mainFooterPage() {
  return ClipRRect(
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(30.0),
      topRight: Radius.circular(30.0),
    ),
    child: BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            size: 30.0,
            color: Colors.black,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
            size: 30.0,
            color: Colors.black,
          ),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.video_camera_front_outlined,
            size: 30.0,
            color: Colors.black,
          ),
          label: 'reels',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.shopping_bag_outlined,
            size: 30.0,
            color: Colors.black,
          ),
          label: 'Shop',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person_outlined,
            size: 30.0,
            color: Colors.black,
          ),
          label: 'Profile',
        ),
      ],
    ),
  );
}

Widget _post(BuildContext context, Post post) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
    child: Container(
      width: double.infinity,
      // height: 560.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0.0),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  leading: Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          offset: const Offset(0, 2),
                          blurRadius: 2.0,
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      foregroundColor: COLORS.secondaryColor,
                      child: ClipOval(
                        child: profileImageAvatar(imageUrl: post.userAvatar),
                        // child: Image(
                        //   height: 50.0,
                        //   width: 50.0,
                        //   image: AssetImage(posts[index].userAvatar),
                        //   fit: BoxFit.cover,
                        // ),
                      ),
                    ),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.userName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    DateFormat('MM/dd/yyyy, hh:mm a').format(post.timestamp),
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.more_horiz),
                    color: Colors.black,
                    onPressed: () => print('ok'),
                  ),
                ),
                InkWell(
                  onDoubleTap: () => print('Like'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PostPage(
                          post: post,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(0.0),
                    width: 400,
                    height: 400.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          offset: const Offset(0, 2),
                          blurRadius: 8.0,
                        ),
                      ],
                      image: DecorationImage(
                        image: NetworkImage(post.imageUrl),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              IconButton(
                                icon: const Icon(Icons.favorite_border),
                                iconSize: 30.0,
                                onPressed: () => print('Like post'),
                              ),
                              IconButton(
                                icon: const Icon(Icons.mail_outlined),
                                iconSize: 30.0,
                                onPressed: () => print('mail'),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              IconButton(
                                icon: const Icon(Icons.message_outlined),
                                iconSize: 30.0,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => PostPage(
                                        post: post,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.bookmark_border),
                        iconSize: 30.0,
                        onPressed: () => print('ok saved'),
                      ),
                    ],
                  ),
                ),
                Text(
                  post.postCaption!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    // fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
