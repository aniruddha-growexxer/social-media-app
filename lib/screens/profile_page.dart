import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/constants/constants.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/screens/edit_profile.dart';
import 'package:social_media_app/screens/login.dart';
import 'package:social_media_app/shared_preferences.dart';

import '../stores/post_store.dart';
import '../stores/user_store.dart';

class ProfileScreen extends StatefulWidget {
  // ProfileScreen();

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late SocialMediaUser user;
  late PostStore postStore;
  late UserStore userStore;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    postStore = Provider.of<PostStore>(context);
    userStore = Provider.of<UserStore>(context);
    await userStore.setUser(GlobalConstants.userId);
    await postStore.loadPostsByUserId(context, GlobalConstants.userId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          title: const Text(
            'Profile',
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.settings_power),
              color: Color.fromRGBO(0, 0, 0, 1),
              onPressed: () async {
                FirebaseAuth _auth = FirebaseAuth.instance;
                await _auth.signOut();
                clearData();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (c) => const Login()),
                    (route) => false);
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                    child: Container(
                        width: 110.0,
                        height: 110.0,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: userStore.isSettingUser
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Image.network(userStore.user!.imageUrl!.isEmpty
                                ? GlobalConstants.userAvatar
                                : userStore.user!.imageUrl.toString())),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0),
                              child: detailsWidget(
                                  postStore.postsOfSingleUser.length.toString(),
                                  'Posts'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0),
                              child: detailsWidget(
                                  userStore.user!.followers!.length.toString(),
                                  'Followers'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: detailsWidget(
                                  userStore.user!.following!.length.toString(),
                                  'Following'),
                            ),
                          ],
                        ),
                        GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 12.0, left: 20.0, right: 20.0),
                            child: Container(
                              width: 210.0,
                              height: 30.0,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4.0),
                                  border: Border.all(color: Colors.grey)),
                              child: const Center(
                                child: Text('Edit Profile',
                                    style: TextStyle(color: Colors.black)),
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (c) => EditProfilePage(),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0, top: 30.0),
                child: userStore.isSettingUser
                    ? const SizedBox(
                        width: 30,
                        child: LinearProgressIndicator(),
                      )
                    : Text(
                        userStore.user!.userName,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 12.0),
                child: Divider(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: postStore.postsOfSingleUser.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0),
                  itemBuilder: ((context, index) {
                    return GestureDetector(
                      child: Image.network(
                        postStore.posts[index].imageUrl,
                        loadingBuilder: ((context, w, e) => e == null
                            ? w
                            : Center(
                                child: CircularProgressIndicator(
                                  value: e != null
                                      ? e.cumulativeBytesLoaded /
                                          e.expectedTotalBytes!.toInt() *
                                          100
                                      : null,
                                ),
                              )),
                        width: 125.0,
                        height: 125.0,
                        fit: BoxFit.cover,
                      ),
                      onTap: () {},
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget postImagesWidget() {
  //   return _isGridActive == true
  //       ? FutureBuilder(
  //           future: _future,
  //           builder:
  //               ((context, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
  //             if (snapshot.hasData) {
  //               if (snapshot.connectionState == ConnectionState.done) {
  //                 return GridView.builder(
  //                   shrinkWrap: true,
  //                   itemCount: snapshot.data.length,
  //                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //                       crossAxisCount: 3,
  //                       crossAxisSpacing: 4.0,
  //                       mainAxisSpacing: 4.0),
  //                   itemBuilder: ((context, index) {
  //                     return GestureDetector(
  //                       child: CachedNetworkImage(
  //                         imageUrl: snapshot.data[index].data['imgUrl'],
  //                         placeholder: ((context, s) => Center(
  //                               child: CircularProgressIndicator(),
  //                             )),
  //                         width: 125.0,
  //                         height: 125.0,
  //                         fit: BoxFit.cover,
  //                       ),
  //                       onTap: () {
  //                         print(
  //                             "SNAPSHOT : ${snapshot.data[index].reference.path}");
  //                         Navigator.push(
  //                             context,
  //                             MaterialPageRoute(
  //                                 builder: ((context) => PostDetailScreen(
  //                                       user: _user,
  //                                       currentuser: _user,
  //                                       documentSnapshot: snapshot.data[index],
  //                                     ))));
  //                       },
  //                     );
  //                   }),
  //                 );
  //               } else if (snapshot.hasError) {
  //                 return Center(
  //                   child: Text('No Posts Found'),
  //                 );
  //               }
  //             } else {
  //               return Center(child: CircularProgressIndicator());
  //             }
  //           }),
  //         )
  //       : FutureBuilder(
  //           future: _future,
  //           builder:
  //               ((context, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
  //             if (snapshot.hasData) {
  //               if (snapshot.connectionState == ConnectionState.done) {
  //                 return SizedBox(
  //                     height: 600.0,
  //                     child: ListView.builder(
  //                         //shrinkWrap: true,
  //                         itemCount: snapshot.data.length,
  //                         itemBuilder: ((context, index) => ListItem(
  //                             list: snapshot.data,
  //                             index: index,
  //                             user: _user))));
  //               } else {
  //                 return Center(
  //                   child: CircularProgressIndicator(),
  //                 );
  //               }
  //             } else {
  //               return Center(
  //                 child: CircularProgressIndicator(),
  //               );
  //             }
  //           }),
  //         );
  // }

  Widget detailsWidget(String count, String label) {
    return Column(
      children: <Widget>[
        Text(count,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.black)),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(label,
              style: const TextStyle(fontSize: 16.0, color: Colors.grey)),
        )
      ],
    );
  }
}
