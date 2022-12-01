import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../constants/constants.dart';

class Post {
  String postId;
  String userId;
  String userName;
  String userAvatar;
  DateTime timestamp;
  String? postCaption;
  String imageUrl;

  Post({
    this.postCaption = '',
    required this.postId,
    required this.userId,
    required this.userName,
    required this.userAvatar,
    required this.timestamp,
    required this.imageUrl,
  });

  factory Post.fromDocument(DocumentSnapshot snapshot) {
    String userId = "";
    String imageUrl = "";
    String postId = "";
    String userName = "";
    String userAvatar = "";
    DateTime timestamp = DateTime.now();
    String postCaption = "";

    try {
      userId = snapshot.get(FirestoreConstants.userId);
      postCaption = snapshot.get(FirestoreConstants.postCaption);
      imageUrl = snapshot.get(FirestoreConstants.imageUrl);
      postId = snapshot.get(FirestoreConstants.postId).toString();
      userName = snapshot.get(FirestoreConstants.userName);
      userAvatar = snapshot.get(FirestoreConstants.userAvatar);
      timestamp =
          (snapshot.get(FirestoreConstants.timestamp) as Timestamp)
              .toDate();
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
        // print(e);
      }
    }
    return Post(
        postId: postId,
        postCaption: postCaption,
        userId: userId,
        userName: userName,
        userAvatar: userAvatar,
        timestamp: timestamp,
        imageUrl: imageUrl);
  }
}

final List<String> stories = [
  'assets/images/user1.jpeg',
  'assets/images/user2.jpeg',
  'assets/images/user3.jpeg',
  'assets/images/user4.jpeg',
  'assets/images/user0.jpeg',
  'assets/images/user1.jpeg',
  'assets/images/user2.jpeg',
  'assets/images/user3.jpeg',
];
