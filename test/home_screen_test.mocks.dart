// Mocks generated by Mockito 5.3.2 from annotations
// in social_media_app/test/home_screen_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;
import 'dart:io' as _i10;

import 'package:cloud_firestore/cloud_firestore.dart' as _i8;
import 'package:flutter/cupertino.dart' as _i5;
import 'package:mobx/mobx.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:social_media_app/models/post.dart' as _i4;
import 'package:social_media_app/models/user.dart' as _i6;
import 'package:social_media_app/stores/post_store.dart' as _i3;
import 'package:social_media_app/stores/user_store.dart' as _i9;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeReactiveContext_0 extends _i1.SmartFake
    implements _i2.ReactiveContext {
  _FakeReactiveContext_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [PostStore].
///
/// See the documentation for Mockito's code generation for more information.
class MockPostStore extends _i1.Mock implements _i3.PostStore {
  @override
  bool get isPostLoading => (super.noSuchMethod(
        Invocation.getter(#isPostLoading),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  set isPostLoading(bool? _isPostLoading) => super.noSuchMethod(
        Invocation.setter(
          #isPostLoading,
          _isPostLoading,
        ),
        returnValueForMissingStub: null,
      );
  @override
  bool get isPostUploading => (super.noSuchMethod(
        Invocation.getter(#isPostUploading),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  set isPostUploading(bool? _isPostUploading) => super.noSuchMethod(
        Invocation.setter(
          #isPostUploading,
          _isPostUploading,
        ),
        returnValueForMissingStub: null,
      );
  @override
  List<_i4.Post> get posts => (super.noSuchMethod(
        Invocation.getter(#posts),
        returnValue: <_i4.Post>[],
        returnValueForMissingStub: <_i4.Post>[],
      ) as List<_i4.Post>);
  @override
  set posts(List<_i4.Post>? _posts) => super.noSuchMethod(
        Invocation.setter(
          #posts,
          _posts,
        ),
        returnValueForMissingStub: null,
      );
  @override
  List<_i4.Post> get postsOfSingleUser => (super.noSuchMethod(
        Invocation.getter(#postsOfSingleUser),
        returnValue: <_i4.Post>[],
        returnValueForMissingStub: <_i4.Post>[],
      ) as List<_i4.Post>);
  @override
  set postsOfSingleUser(List<_i4.Post>? _postsOfSingleUser) =>
      super.noSuchMethod(
        Invocation.setter(
          #postsOfSingleUser,
          _postsOfSingleUser,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i2.ReactiveContext get context => (super.noSuchMethod(
        Invocation.getter(#context),
        returnValue: _FakeReactiveContext_0(
          this,
          Invocation.getter(#context),
        ),
        returnValueForMissingStub: _FakeReactiveContext_0(
          this,
          Invocation.getter(#context),
        ),
      ) as _i2.ReactiveContext);
  @override
  void addNewPost({
    required _i5.BuildContext? context,
    required _i6.SocialMediaUser? socialMediaUser,
    required String? filePath,
    required String? caption,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #addNewPost,
          [],
          {
            #context: context,
            #socialMediaUser: socialMediaUser,
            #filePath: filePath,
            #caption: caption,
          },
        ),
        returnValueForMissingStub: null,
      );
  @override
  dynamic updatePost(
    String? field,
    String? value,
    String? postId,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #updatePost,
          [
            field,
            value,
            postId,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  dynamic loadPosts(_i5.BuildContext? context) => super.noSuchMethod(
        Invocation.method(
          #loadPosts,
          [context],
        ),
        returnValueForMissingStub: null,
      );
  @override
  dynamic loadPostsByUserId(
    _i5.BuildContext? context,
    String? userId,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #loadPostsByUserId,
          [
            context,
            userId,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i7.Stream<_i8.QuerySnapshot<Map<String, dynamic>>> fetchAllPosts(
          _i5.BuildContext? context) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchAllPosts,
          [context],
        ),
        returnValue:
            _i7.Stream<_i8.QuerySnapshot<Map<String, dynamic>>>.empty(),
        returnValueForMissingStub:
            _i7.Stream<_i8.QuerySnapshot<Map<String, dynamic>>>.empty(),
      ) as _i7.Stream<_i8.QuerySnapshot<Map<String, dynamic>>>);
}

/// A class which mocks [UserStore].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserStore extends _i1.Mock implements _i9.UserStore {
  @override
  set user(_i6.SocialMediaUser? _user) => super.noSuchMethod(
        Invocation.setter(
          #user,
          _user,
        ),
        returnValueForMissingStub: null,
      );
  @override
  String get userAvatarUrl => (super.noSuchMethod(
        Invocation.getter(#userAvatarUrl),
        returnValue: '',
        returnValueForMissingStub: '',
      ) as String);
  @override
  set userAvatarUrl(String? _userAvatarUrl) => super.noSuchMethod(
        Invocation.setter(
          #userAvatarUrl,
          _userAvatarUrl,
        ),
        returnValueForMissingStub: null,
      );
  @override
  bool get isUpdatingProfile => (super.noSuchMethod(
        Invocation.getter(#isUpdatingProfile),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  set isUpdatingProfile(bool? _isUpdatingProfile) => super.noSuchMethod(
        Invocation.setter(
          #isUpdatingProfile,
          _isUpdatingProfile,
        ),
        returnValueForMissingStub: null,
      );
  @override
  bool get isSettingUser => (super.noSuchMethod(
        Invocation.getter(#isSettingUser),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  set isSettingUser(bool? _isSettingUser) => super.noSuchMethod(
        Invocation.setter(
          #isSettingUser,
          _isSettingUser,
        ),
        returnValueForMissingStub: null,
      );
  @override
  bool get isFetchingSingleUser => (super.noSuchMethod(
        Invocation.getter(#isFetchingSingleUser),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  set isFetchingSingleUser(bool? _isFetchingSingleUser) => super.noSuchMethod(
        Invocation.setter(
          #isFetchingSingleUser,
          _isFetchingSingleUser,
        ),
        returnValueForMissingStub: null,
      );
  @override
  bool get fetchingAllUsers => (super.noSuchMethod(
        Invocation.getter(#fetchingAllUsers),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  set fetchingAllUsers(bool? _fetchingAllUsers) => super.noSuchMethod(
        Invocation.setter(
          #fetchingAllUsers,
          _fetchingAllUsers,
        ),
        returnValueForMissingStub: null,
      );
  @override
  List<_i4.Post> get myPosts => (super.noSuchMethod(
        Invocation.getter(#myPosts),
        returnValue: <_i4.Post>[],
        returnValueForMissingStub: <_i4.Post>[],
      ) as List<_i4.Post>);
  @override
  set myPosts(List<_i4.Post>? _myPosts) => super.noSuchMethod(
        Invocation.setter(
          #myPosts,
          _myPosts,
        ),
        returnValueForMissingStub: null,
      );
  @override
  List<_i6.SocialMediaUser> get allUsers => (super.noSuchMethod(
        Invocation.getter(#allUsers),
        returnValue: <_i6.SocialMediaUser>[],
        returnValueForMissingStub: <_i6.SocialMediaUser>[],
      ) as List<_i6.SocialMediaUser>);
  @override
  set allUsers(List<_i6.SocialMediaUser>? _allUsers) => super.noSuchMethod(
        Invocation.setter(
          #allUsers,
          _allUsers,
        ),
        returnValueForMissingStub: null,
      );
  @override
  set peerUser(_i6.SocialMediaUser? _peerUser) => super.noSuchMethod(
        Invocation.setter(
          #peerUser,
          _peerUser,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i2.ReactiveContext get context => (super.noSuchMethod(
        Invocation.getter(#context),
        returnValue: _FakeReactiveContext_0(
          this,
          Invocation.getter(#context),
        ),
        returnValueForMissingStub: _FakeReactiveContext_0(
          this,
          Invocation.getter(#context),
        ),
      ) as _i2.ReactiveContext);
  @override
  _i7.Future<_i6.SocialMediaUser?> fetchUser(String? userId) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchUser,
          [userId],
        ),
        returnValue: _i7.Future<_i6.SocialMediaUser?>.value(),
        returnValueForMissingStub: _i7.Future<_i6.SocialMediaUser?>.value(),
      ) as _i7.Future<_i6.SocialMediaUser?>);
  @override
  dynamic setUser(String? id) => super.noSuchMethod(
        Invocation.method(
          #setUser,
          [id],
        ),
        returnValueForMissingStub: null,
      );
  @override
  dynamic createUserObject(_i6.SocialMediaUser? socialMediaUser) =>
      super.noSuchMethod(
        Invocation.method(
          #createUserObject,
          [socialMediaUser],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i7.Future<bool> updateUser({
    required _i5.BuildContext? context,
    required String? field,
    required String? value,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateUser,
          [],
          {
            #context: context,
            #field: field,
            #value: value,
          },
        ),
        returnValue: _i7.Future<bool>.value(false),
        returnValueForMissingStub: _i7.Future<bool>.value(false),
      ) as _i7.Future<bool>);
  @override
  void addProfilePicture({
    required _i5.BuildContext? context,
    required _i10.File? file,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #addProfilePicture,
          [],
          {
            #context: context,
            #file: file,
          },
        ),
        returnValueForMissingStub: null,
      );
  @override
  void followUser(String? userId) => super.noSuchMethod(
        Invocation.method(
          #followUser,
          [userId],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void unfollowUser(String? userId) => super.noSuchMethod(
        Invocation.method(
          #unfollowUser,
          [userId],
        ),
        returnValueForMissingStub: null,
      );
}
