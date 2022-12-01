import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/screens/main_page.dart';
import 'package:uuid/uuid.dart';

import '../constants/constants.dart';
import '../firebase_helper/firebase_helper.dart';
import '../models/post.dart';
import '../screens/homepage.dart';
import '../utils.dart';
part 'post_store.g.dart';

class PostStore = _PostStoreBase with _$PostStore;

abstract class _PostStoreBase with Store {
  @observable
  bool isPostLoading = false;

  @observable
  bool isPostUploading = false;

  @observable
  List<Post> posts = [];

  @observable
  List<Post> postsOfSingleUser = [];

  void addNewPost(
      {required BuildContext context,
      required SocialMediaUser socialMediaUser,
      required String filePath,
      required String caption}) {
    isPostUploading = true;
    try {
      File file = File(filePath);
      String postId = Uuid().v4();
      UploadTask uploadTask = Firebasehelper().uploadPostImage(postId, file);
      uploadTask.whenComplete(() {
        uploadTask.then((fileRef) async {
          String url = await fileRef.ref.getDownloadURL();
          log("url is $url");
          FirebaseFirestore.instance.collection('posts').doc(postId).set({
            FirestoreConstants.postId: postId,
            FirestoreConstants.timestamp: DateTime.now(),
            FirestoreConstants.userAvatar: socialMediaUser.imageUrl,
            FirestoreConstants.userId: socialMediaUser.userId,
            FirestoreConstants.userName: socialMediaUser.userName,
            FirestoreConstants.postCaption: caption,
            FirestoreConstants.imageUrl: url,
          });
        }).whenComplete(() {
          isPostUploading = false;
          posts.clear();
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (c) => MainPage()), (route) => false);
        });
      }).onError((error, stackTrace) {
        log(error.toString());
        throw (error.toString());
      });
    } on FirebaseException catch (e) {
      log(e.message.toString());
      buildShowSnackBar(context, "Something went wrong");
    }
  }

  loadPosts(BuildContext context) async {
    log("post loading");
    isPostLoading = true;
    posts.clear();
    await fetchAllPosts(context).asBroadcastStream().first.then((e) {
      for (var element in e.docs) {
        posts.add(Post.fromDocument(element));
      }
    });

    isPostLoading = false;
  }

  loadPostsByUserId(BuildContext context, String userId) async {
    isPostLoading = true;
    postsOfSingleUser.clear();
    await fetchAllPosts(context).asBroadcastStream().first.then((e) {
      for (var element in e.docs) {
        Post post = Post.fromDocument(element);
        if (post.userId == userId) {
          postsOfSingleUser.add(post);
        }
      }
    });
    isPostLoading = false;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllPosts(
      BuildContext context) {
    return FirebaseFirestore.instance
        .collection('posts')
        // .limit(10)
        .orderBy("timestamp", descending: true)
        .snapshots();
  }
}
