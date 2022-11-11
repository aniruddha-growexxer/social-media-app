import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class Firebasehelper {
  UploadTask uploadPostImage(String postId, File file) {
    // try {
    log("myId is $postId");
    return FirebaseStorage.instance
        .ref()
        .child("postImages")
        .child(postId)
        .putFile(file);
  }

  UploadTask uploadProfilePicture(String myId, File file) {    
    return FirebaseStorage.instance
        .ref()
        .child("profilePictures")
        .child(myId)
        .putFile(file);
  }
}
