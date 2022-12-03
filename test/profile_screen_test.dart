// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/constants/constants.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/screens/homepage.dart';

import 'package:social_media_app/screens/login.dart';
import 'package:social_media_app/screens/otp.dart';
import 'package:social_media_app/screens/profile_page.dart';
import 'package:social_media_app/stores/login_store.dart';
import 'package:social_media_app/stores/post_store.dart';
import 'package:social_media_app/stores/user_store.dart';

import 'login_screen_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<PostStore>(
      as: #MockPostStore, onMissingStub: OnMissingStub.returnDefault)
])
@GenerateNiceMocks([
  MockSpec<UserStore>(
      as: #MockUserStore, onMissingStub: OnMissingStub.returnDefault)
])
class MockBuildContext extends Mock implements BuildContext {}

void main() {
  MockUserStore mockUserStore = MockUserStore();
  MockPostStore mockPostStore = MockPostStore();
  MockBuildContext context = MockBuildContext();
  SocialMediaUser user = SocialMediaUser(
    userId: GlobalConstants.userId,
    phoneNumber: '111111111',
    userName: 'username',
    followers: [''],
    imageUrl: GlobalConstants.staticAvatar,
    following: [''],
  );
  setUpAll(() => HttpOverrides.global = null);
  setUp(() {
    when(mockUserStore.isSettingUser).thenReturn(true);
    when(mockUserStore.setUser(GlobalConstants.userId))
        .thenAnswer((realInvocation) => user);
    when(mockUserStore.user).thenReturn(user);
    when(mockUserStore.isSettingUser).thenReturn(false);
    when(mockPostStore.loadPostsByUserId(context, GlobalConstants.userId))
        .thenAnswer((realInvocation) => []);
    when(mockPostStore.postsOfSingleUser).thenReturn([]);
  });
  testWidgets('ProfileScreen test when user is already set',
      ((WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<PostStore>(create: (_) => mockPostStore),
          Provider<UserStore>(create: (_) => mockUserStore)
        ],
        child: MaterialApp(
          home: ProfileScreen(),
        ),
      ),
    );
    expect(find.text('Posts'), findsOneWidget);
    expect(find.text('Followers'), findsOneWidget);
    expect(find.text('Following'), findsOneWidget);
  }));
}
