import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../constants/constants.dart';

class SocialMediaUser {
  SocialMediaUser({
    required this.userId,
    this.imageUrl,
    required this.phoneNumber,
    required this.userName,
    this.followers,
    this.following,
  });

  final String phoneNumber;
  final String userName;
  final String userId;
  final String? imageUrl;
  List<String>? followers = [];
  List<String>? following = [];

  factory SocialMediaUser.fromJson(Map<String, dynamic> json) =>
      SocialMediaUser(
        userId: json["userId"],
        imageUrl: json["imageUrl"],
        phoneNumber: json["phoneNumber"],
        userName: json["userName"],
        followers: json["followers"],
        following: json["following"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "phoneNumber": phoneNumber,
        "userName": userName,
        "imageUrl": imageUrl,
        "followers": followers,
        "following": following,
      };

  factory SocialMediaUser.fromDocument(DocumentSnapshot snapshot) {
    String phoneNumber = "";
    String userName = "";
    String imageUrl = "";
    String userId = "";
    List<String> followers = [];
    List<String> following = [];
    try {
      userId = snapshot.id;
      phoneNumber = snapshot.get(FirestoreConstants.phoneNumber) ?? "";
      userName = snapshot.get(FirestoreConstants.userName) ?? "";
      imageUrl = snapshot.get(FirestoreConstants.imageUrl) ?? "";
      List<dynamic> listFollowers =
          snapshot.get(FirestoreConstants.followers) ?? [];
      for (var value in listFollowers) {
        followers.add(value.toString());
      }
      List<dynamic> listFollowing =
          snapshot.get(FirestoreConstants.following) ?? [];
      for (var value in listFollowing) {
        following.add(value.toString());
      }
    } catch (e) {
      log("error in setting user ${snapshot.data().toString()} $e");
    }
    return SocialMediaUser(
      userId: snapshot.id,
      userName: userName,
      imageUrl: imageUrl,
      phoneNumber: phoneNumber,
      followers: followers,
      following: following,
    );
  }
}
