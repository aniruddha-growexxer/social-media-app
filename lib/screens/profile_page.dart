import 'dart:async';
import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/constants.dart';

import '../stores/post_store.dart';

class ProfileScreen extends StatefulWidget {
  // ProfileScreen();

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User _user;
  Color _gridColor = Colors.blue;
  Color _listColor = Colors.grey;
  bool _isGridActive = true;
  bool _isLiked = false;
  late PostStore postStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    postStore = Provider.of<PostStore>(context);
    postStore.loadPostsByUserId(context, GlobalConstants.userId);
  }

  @override
  void initState() {
    super.initState();
    retrieveUserDetails();
  }

  retrieveUserDetails() async {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          title: Text(
            'Profile',
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings_power),
              color: Colors.black,
              onPressed: () {},
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
                        child: Text("Profile Image"),
                        height: 110.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80.0),
                          // image: DecorationImage(
                          //     image: _user.photoUrl.isEmpty
                          //         ? AssetImage('assets/no_image.png')
                          //         : NetworkImage(_user.photoUrl),
                          //     fit: BoxFit.cover),
                        )),
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
                              child: detailsWidget('110', 'followers'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: detailsWidget('10', 'following'),
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
                              child: Center(
                                child: Text('Edit Profile',
                                    style: TextStyle(color: Colors.black)),
                              ),
                            ),
                          ),
                          onTap: () {},
                        )
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0, top: 30.0),
                child: Text("displayName",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0, top: 10.0),
                child: Text("Bio"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Divider(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: postStore.posts.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.black)),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child:
              Text(label, style: TextStyle(fontSize: 16.0, color: Colors.grey)),
        )
      ],
    );
  }
}
