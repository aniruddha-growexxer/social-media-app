import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mobx/mobx.dart';
import 'package:social_media_app/constants/constants.dart';
import 'package:social_media_app/firebase_helper/firebase_helper.dart';

import '../models/post.dart';
part 'user_store.g.dart';

class UserStore = _UserStoreBase with _$UserStore;

abstract class _UserStoreBase with Store {
  @observable
  late User user;

  @observable
  List<Post> myPosts = [];

  setUser(User firebaseUser) {
    user = firebaseUser;
  }

  void updateDisplayName(String userName) {
    user.updateDisplayName(userName);
  }

  void addProfilePicture({required File file}) {
    UploadTask uploadTask =
        Firebasehelper().uploadProfilePicture(GlobalConstants.userId, file);
    uploadTask.whenComplete(() {}).then((fileRef) async {
      String url = await fileRef.ref.getDownloadURL();
      await user.updatePhotoURL(url);
    });
  }

  void saveUserDisplayName(String displayName) async {
    await user.updateDisplayName(displayName);
  }
}
