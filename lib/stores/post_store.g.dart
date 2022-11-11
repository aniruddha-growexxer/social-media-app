// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PostStore on _PostStoreBase, Store {
  late final _$isPostLoadingAtom =
      Atom(name: '_PostStoreBase.isPostLoading', context: context);

  @override
  bool get isPostLoading {
    _$isPostLoadingAtom.reportRead();
    return super.isPostLoading;
  }

  @override
  set isPostLoading(bool value) {
    _$isPostLoadingAtom.reportWrite(value, super.isPostLoading, () {
      super.isPostLoading = value;
    });
  }

  late final _$isPostUploadingAtom =
      Atom(name: '_PostStoreBase.isPostUploading', context: context);

  @override
  bool get isPostUploading {
    _$isPostUploadingAtom.reportRead();
    return super.isPostUploading;
  }

  @override
  set isPostUploading(bool value) {
    _$isPostUploadingAtom.reportWrite(value, super.isPostUploading, () {
      super.isPostUploading = value;
    });
  }

  late final _$postsAtom = Atom(name: '_PostStoreBase.posts', context: context);

  @override
  List<Post> get posts {
    _$postsAtom.reportRead();
    return super.posts;
  }

  @override
  set posts(List<Post> value) {
    _$postsAtom.reportWrite(value, super.posts, () {
      super.posts = value;
    });
  }

  late final _$postsOfSingleUserAtom =
      Atom(name: '_PostStoreBase.postsOfSingleUser', context: context);

  @override
  List<Post> get postsOfSingleUser {
    _$postsOfSingleUserAtom.reportRead();
    return super.postsOfSingleUser;
  }

  @override
  set postsOfSingleUser(List<Post> value) {
    _$postsOfSingleUserAtom.reportWrite(value, super.postsOfSingleUser, () {
      super.postsOfSingleUser = value;
    });
  }

  @override
  String toString() {
    return '''
isPostLoading: ${isPostLoading},
isPostUploading: ${isPostUploading},
posts: ${posts},
postsOfSingleUser: ${postsOfSingleUser}
    ''';
  }
}
