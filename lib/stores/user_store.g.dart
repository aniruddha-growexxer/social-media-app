// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserStore on _UserStoreBase, Store {
  late final _$userAtom = Atom(name: '_UserStoreBase.user', context: context);

  @override
  SocialMediaUser? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(SocialMediaUser? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$userAvatarUrlAtom =
      Atom(name: '_UserStoreBase.userAvatarUrl', context: context);

  @override
  String get userAvatarUrl {
    _$userAvatarUrlAtom.reportRead();
    return super.userAvatarUrl;
  }

  @override
  set userAvatarUrl(String value) {
    _$userAvatarUrlAtom.reportWrite(value, super.userAvatarUrl, () {
      super.userAvatarUrl = value;
    });
  }

  late final _$isUpdatingProfileAtom =
      Atom(name: '_UserStoreBase.isUpdatingProfile', context: context);

  @override
  bool get isUpdatingProfile {
    _$isUpdatingProfileAtom.reportRead();
    return super.isUpdatingProfile;
  }

  @override
  set isUpdatingProfile(bool value) {
    _$isUpdatingProfileAtom.reportWrite(value, super.isUpdatingProfile, () {
      super.isUpdatingProfile = value;
    });
  }

  late final _$isSettingUserAtom =
      Atom(name: '_UserStoreBase.isSettingUser', context: context);

  @override
  bool get isSettingUser {
    _$isSettingUserAtom.reportRead();
    return super.isSettingUser;
  }

  @override
  set isSettingUser(bool value) {
    _$isSettingUserAtom.reportWrite(value, super.isSettingUser, () {
      super.isSettingUser = value;
    });
  }

  late final _$isFetchingSingleUserAtom =
      Atom(name: '_UserStoreBase.isFetchingSingleUser', context: context);

  @override
  bool get isFetchingSingleUser {
    _$isFetchingSingleUserAtom.reportRead();
    return super.isFetchingSingleUser;
  }

  @override
  set isFetchingSingleUser(bool value) {
    _$isFetchingSingleUserAtom.reportWrite(value, super.isFetchingSingleUser,
        () {
      super.isFetchingSingleUser = value;
    });
  }

  late final _$fetchingAllUsersAtom =
      Atom(name: '_UserStoreBase.fetchingAllUsers', context: context);

  @override
  bool get fetchingAllUsers {
    _$fetchingAllUsersAtom.reportRead();
    return super.fetchingAllUsers;
  }

  @override
  set fetchingAllUsers(bool value) {
    _$fetchingAllUsersAtom.reportWrite(value, super.fetchingAllUsers, () {
      super.fetchingAllUsers = value;
    });
  }

  late final _$myPostsAtom =
      Atom(name: '_UserStoreBase.myPosts', context: context);

  @override
  List<Post> get myPosts {
    _$myPostsAtom.reportRead();
    return super.myPosts;
  }

  @override
  set myPosts(List<Post> value) {
    _$myPostsAtom.reportWrite(value, super.myPosts, () {
      super.myPosts = value;
    });
  }

  late final _$allUsersAtom =
      Atom(name: '_UserStoreBase.allUsers', context: context);

  @override
  List<SocialMediaUser> get allUsers {
    _$allUsersAtom.reportRead();
    return super.allUsers;
  }

  @override
  set allUsers(List<SocialMediaUser> value) {
    _$allUsersAtom.reportWrite(value, super.allUsers, () {
      super.allUsers = value;
    });
  }

  late final _$peerUserAtom =
      Atom(name: '_UserStoreBase.peerUser', context: context);

  @override
  SocialMediaUser? get peerUser {
    _$peerUserAtom.reportRead();
    return super.peerUser;
  }

  @override
  set peerUser(SocialMediaUser? value) {
    _$peerUserAtom.reportWrite(value, super.peerUser, () {
      super.peerUser = value;
    });
  }

  @override
  String toString() {
    return '''
user: ${user},
userAvatarUrl: ${userAvatarUrl},
isUpdatingProfile: ${isUpdatingProfile},
isSettingUser: ${isSettingUser},
isFetchingSingleUser: ${isFetchingSingleUser},
fetchingAllUsers: ${fetchingAllUsers},
myPosts: ${myPosts},
allUsers: ${allUsers},
peerUser: ${peerUser}
    ''';
  }
}
