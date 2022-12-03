// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/screens/homepage.dart';

import 'package:social_media_app/screens/login.dart';
import 'package:social_media_app/screens/otp.dart';
import 'package:social_media_app/screens/profile_page.dart';
import 'package:social_media_app/stores/login_store.dart';
import 'package:social_media_app/stores/post_store.dart';
import 'package:social_media_app/stores/user_store.dart';

import 'login_screen_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<LoginStore>(
      as: #MockLoginStore, onMissingStub: OnMissingStub.returnDefault)
])
@GenerateNiceMocks([
  MockSpec<PostStore>(
      as: #MockPostStore, onMissingStub: OnMissingStub.returnDefault)
])
@GenerateNiceMocks([
  MockSpec<UserStore>(
      as: #MockUserStore, onMissingStub: OnMissingStub.returnDefault)
])
void main() {
  setUp(() {
    MockLoginStore mockLoginStore = MockLoginStore();
    when(mockLoginStore.isLoginLoading).thenReturn(false);
  });
  testWidgets('LoginScreen test', ((WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<LoginStore>(create: ((context) => MockLoginStore())),
          Provider<PostStore>(create: (_) => MockPostStore()),
          Provider<UserStore>(create: (_) => MockUserStore())
        ],
        child: MaterialApp(
          home: Login(),
        ),
      ),
    );
    expect(find.text('Next'), findsOneWidget);
  }));

  testWidgets('OtpScreen test', ((WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<LoginStore>(create: ((context) => MockLoginStore())),
          Provider<PostStore>(create: (_) => MockPostStore()),
          Provider<UserStore>(create: (_) => MockUserStore())
        ],
        child: MaterialApp(
          home: OtpScreen(),
        ),
      ),
    );
    expect(find.text('Confirm'), findsOneWidget);
  }));
}
