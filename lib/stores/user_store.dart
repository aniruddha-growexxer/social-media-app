import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:social_media_app/constants/constants.dart';
import 'package:social_media_app/firebase_helper/firebase_helper.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/utils.dart';

import '../models/post.dart';
import 'post_store.dart';
part 'user_store.g.dart';

class UserStore = _UserStoreBase with _$UserStore;

abstract class _UserStoreBase with Store {
  @observable
  SocialMediaUser? user;

  @observable
  String userAvatarUrl = "";

  @observable
  bool isUpdatingProfile = false;

  @observable
  bool isSettingUser = false;

  @observable
  bool isFetchingSingleUser = false;

  @observable
  bool fetchingAllUsers = false;

  @observable
  List<Post> myPosts = [];

  @observable
  List<SocialMediaUser> allUsers = [];

  @observable
  SocialMediaUser? peerUser;

  Future<SocialMediaUser?> fetchUser(String userId) async {
    isFetchingSingleUser = true;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((value) {
      log(value.data().toString());
      peerUser = SocialMediaUser.fromDocument(value);
    });
    isFetchingSingleUser = false;
  }

  setUser(String id) async {
    isSettingUser = true;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .get()
        .then((value) {
      user = SocialMediaUser.fromDocument(value);
    });
    isSettingUser = false;
  }

  createUserObject(SocialMediaUser socialMediaUser) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(socialMediaUser.userId)
        .set({
      FirestoreConstants.userName: socialMediaUser.userName,
      FirestoreConstants.userId: socialMediaUser.userId,
      FirestoreConstants.imageUrl: socialMediaUser.imageUrl,
      FirestoreConstants.phoneNumber: socialMediaUser.phoneNumber,
      FirestoreConstants.followers: socialMediaUser.followers,
      FirestoreConstants.following: socialMediaUser.following,
    });
    user = socialMediaUser;
  }

  fetchAllUsers() async {
    fetchingAllUsers = true;
    log("fetching all users");
    allUsers.clear();
    await FirebaseFirestore.instance
        .collection('users')
        // .limit(limit)
        .snapshots()
        .asBroadcastStream()
        .first
        .then((value) {
      for (var element in value.docs) {
        allUsers.add(SocialMediaUser.fromDocument(element));
      }
    });
    log('=====');
    fetchingAllUsers = false;
  }

  Future<bool> updateUser(
      {required BuildContext context,
      required String field,
      required String value}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(GlobalConstants.userId)
        .update({field: value}).whenComplete(() async {
      await PostStore()
          .fetchAllPosts(context)
          .asBroadcastStream()
          .first
          .then((e) async {
        for (var element in e.docs) {
          Post post = Post.fromDocument(element);
          if (post.userId == GlobalConstants.userId) {
            if (field == FirestoreConstants.imageUrl) {
              await PostStore().updatePost("userAvatar", value, post.postId);
            } else {
              await PostStore().updatePost(field, value, post.postId);
            }
          }
        }
      });
      buildShowSnackBar(context, "Details updated successfully");
    }).onError((error, stackTrace) {
      buildShowSnackBar(context, "Details could not be saved");
    });
    return true;
  }

  void addProfilePicture({required BuildContext context, required File file}) {
    isUpdatingProfile = true;
    UploadTask uploadTask =
        Firebasehelper().uploadProfilePicture(GlobalConstants.userId, file);
    uploadTask.whenComplete(() {}).then((fileRef) async {
      String url = await fileRef.ref.getDownloadURL();
      userAvatarUrl = url;
      updateUser(
          context: context, value: url, field: FirestoreConstants.imageUrl);
      setUser(GlobalConstants.userId);
      isUpdatingProfile = false;
    }).onError((error, stackTrace) {
      log(error.toString());
      buildShowSnackBar(context, "Something went wrong");
      isUpdatingProfile = false;
    });
  }

  void followUser(String userId) async {
    await fetchUser(userId);
    if (peerUser!.followers!.contains(GlobalConstants.userId) == false) {
      peerUser!.followers!.add(GlobalConstants.userId);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({FirestoreConstants.followers: peerUser!.followers});
    }
    if (user!.following!.contains(userId) == false) {
      user!.following!.add(userId);
    }
    log("peerUserFollowers is ${peerUser!.followers!.length}");
    log("myFollowing is ${user!.following!.length}");
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.userId)
        .update({FirestoreConstants.following: user!.following});
    fetchAllUsers();
    setUser(GlobalConstants.userId);
  }

  void unfollowUser(String userId) async {
    await fetchUser(userId);
    List<String>? peerUserFollowers = peerUser!.followers;
    List<String>? myFollowing = user!.following;
    peerUserFollowers!.remove(GlobalConstants.userId);
    myFollowing!.remove(userId);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({FirestoreConstants.followers: peerUserFollowers});
    await FirebaseFirestore.instance
        .collection('users')
        .doc(GlobalConstants.userId)
        .update({FirestoreConstants.following: myFollowing});
    // });
    fetchAllUsers();
    setUser(GlobalConstants.userId);
  }
}
