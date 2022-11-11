// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/screens/post_page.dart';
import 'package:social_media_app/stores/post_store.dart';
import 'package:social_media_app/utils.dart';

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

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    postStore = Provider.of<PostStore>(context);
    await postStore.loadPosts(context);
    log("postStore.isPostLoading is ${postStore.isPostLoading}");

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
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
                      buildShowSnackBar(context, "Image could not be selected");
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.refresh, color: Colors.black),
                  iconSize: 28.0,
                  onPressed: () => postStore.loadPosts(context),
                ),
                IconButton(
                  icon: const Icon(Icons.message_outlined, color: Colors.black),
                  iconSize: 28.0,
                  onPressed: () => print('ok ok '),
                ),
              ],
            )
          ]),
        ),
        body: bodyMainList(postStore: postStore, context: context),
        // bottomNavigationBar: mainFooterPage(),
      ),
    );
    // });
    });
    // );
  }
}

Widget bodyMainList(
    {required PostStore postStore, required BuildContext context}) {
  return Column(
    children: <Widget>[
      Container(
        width: double.infinity,
        height: 100.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: stories.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return const SizedBox(width: 10.0);
            }
            return Container(
              margin: const EdgeInsets.all(10.0),
              width: 65.0,
              height: 65.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  const BoxShadow(
                    color: Colors.black45,
                    offset: Offset(0, 2),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: CircleAvatar(
                // child: ClipOval(
                backgroundColor: COLORS.secondaryColorLight,
                foregroundColor: COLORS.secondaryColor,
                child: Text(
                  "Story $index",
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w500),
                ),
                // child: Image(
                //   height: 63.0,
                //   width: 63.0,
                //   image: AssetImage(stories[index - 1]),
                //   fit: BoxFit.cover,
                // ),
                // ),
              ),
            );
          },
        ),
      ),
      // _post(0),
      // _post(1),

      Expanded(
        // height: 900,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: postStore.posts.length,
            itemBuilder: (context, i) {
              return _post(context, postStore.posts[i]);
            }),
      ),
      //_post(3),
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
      height: 560.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0.0),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0),
            child: Column(
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
                      // child: ClipOval(
                      foregroundColor: COLORS.secondaryColor,
                      child: Text(
                        post.userName,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                      // child: Image(
                      //   height: 50.0,
                      //   width: 50.0,
                      //   image: AssetImage(posts[index].userAvatar),
                      //   fit: BoxFit.cover,
                      // ),
                      // ),
                    ),
                  ),
                  title: Text(
                    post.postCaption!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text(post.timestamp.toString()),
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
                      // color: Colors.white,
                      borderRadius: BorderRadius.circular(0.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          offset: const Offset(0, 0.5),
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
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
