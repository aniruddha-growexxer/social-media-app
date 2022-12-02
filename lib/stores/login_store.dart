import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/constants/constants.dart';
import 'package:social_media_app/models/user.dart';
import 'package:social_media_app/screens/add_new_user.dart';
import 'package:social_media_app/screens/main_page.dart';
import 'package:social_media_app/screens/otp.dart';
import 'package:social_media_app/shared_preferences.dart';
import 'package:social_media_app/stores/user_store.dart';
import 'package:social_media_app/utils.dart';

import '../screens/homepage.dart';
import '../screens/login.dart';

part 'login_store.g.dart';

class LoginStore = LoginStoreBase with _$LoginStore;

abstract class LoginStoreBase with Store {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String actualCode;

  @observable
  bool isLoginLoading = false;
  @observable
  bool isOtpLoading = false;

  @observable
  GlobalKey<ScaffoldState> loginScaffoldKey = GlobalKey<ScaffoldState>();
  @observable
  GlobalKey<ScaffoldState> otpScaffoldKey = GlobalKey<ScaffoldState>();

  @observable
  User? firebaseUser;

  @action
  Future<bool> isAlreadyAuthenticated() async {
    firebaseUser = await _auth.currentUser!;
    if (firebaseUser != null) {
      GlobalConstants.userId = firebaseUser!.uid;
      log("already authenticated");
      return true;
    } else {
      return false;
    }
  }

  @action
  Future<void> getCodeWithPhoneNumber(
      BuildContext context, String phoneNumber) async {
    isLoginLoading = true;

    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential auth) async {
          await firebaseUser!.updatePhoneNumber(auth);
          await _auth.signInWithCredential(auth).then((UserCredential value) {
            if (value != null && value.user != null) {
              print('Authentication successful');
              onAuthenticationSuccessful(context, value);
            } else {
              buildShowSnackBar(context, 'Invalid code/invalid authentication');
            }
          }).catchError((error) {
            buildShowSnackBar(
                context, 'Something has gone wrong, please try later');
          });
          isLoginLoading = false;
        },
        verificationFailed: (FirebaseAuthException authException) {
          print('Error message: ' + authException.message.toString());
          buildShowSnackBar(context,
              'The phone number format is incorrect. Please enter your number in E.164 format. [+][country code][number]');
          isLoginLoading = false;
        },
        codeSent: (String verificationId, [int? forceResendingToken]) async {
          actualCode = verificationId;
          isLoginLoading = false;
          await Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const OtpScreen()));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          actualCode = verificationId;
        });
  }

  @action
  Future<void> validateOtpAndLogin(BuildContext context, String smsCode) async {
    isOtpLoading = true;
    final AuthCredential _authCredential = PhoneAuthProvider.credential(
        verificationId: actualCode, smsCode: smsCode);

    await _auth.signInWithCredential(_authCredential).catchError((error) {
      isOtpLoading = false;
      buildShowSnackBar(
          context, 'Wrong code ! Please enter the last code received.');
    }).then((UserCredential authResult) {
      if (authResult != null && authResult.user != null) {
        print('Authentication successful');
        onAuthenticationSuccessful(context, authResult);
      }
    });
  }

  Future<void> onAuthenticationSuccessful(
      BuildContext context, UserCredential result) async {
    UserStore userStore;
    userStore = Provider.of<UserStore>(context, listen: false);
    isLoginLoading = true;
    isOtpLoading = true;

    firebaseUser = result.user!;
    await userStore.setUser(result.user!.uid);
    setUserId(result.user!.uid);
    setPhoneNumber(result.user!.phoneNumber);
    GlobalConstants.userId = result.user!.uid;
    GlobalConstants.phoneNumber = result.user!.phoneNumber!;
    isLoginLoading = false;
    isOtpLoading = false;
    if (userStore.user!.userId != "" && userStore.user!.userName == "") {
      await userStore.createUserObject(
        SocialMediaUser(
            userId: GlobalConstants.userId,
            phoneNumber: GlobalConstants.phoneNumber,
            userName: "",
            imageUrl: GlobalConstants.userAvatar),
      );
      await Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => AddNewUser()),
          (Route<dynamic> route) => false);
    } else {
      await Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => MainPage()),
          (Route<dynamic> route) => false);
    }
  }

  @action
  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    await Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const Login()),
        (Route<dynamic> route) => false);
    isLoginLoading = false;
    isOtpLoading = false;
  }
}
