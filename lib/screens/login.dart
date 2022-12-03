import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/constants/constants.dart';
import 'package:social_media_app/widgets/loader.dart';

import '../constants/colors.dart';
import '../stores/login_store.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginStore>(builder: (_, loginStore, __) {
      return Observer(
        builder: (context) => LoaderHUD(
          inAsyncCall: loginStore.isLoginLoading,
          child: Scaffold(
            backgroundColor: Color.fromARGB(255, 237, 236, 236),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: <Widget>[
                            Container(
                                // margin: const EdgeInsets.symmetric(horizontal: 10),
                                margin: const EdgeInsets.only(top: 50),
                                child: Text('Social Media',
                                    style: TextStyle(
                                        color: COLORS.primaryColor,
                                        fontSize: 40,
                                        fontWeight: FontWeight.w800))),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Stack(
                                children: <Widget>[
                                  Center(
                                    child: Container(
                                      height: 240,
                                      constraints:
                                          const BoxConstraints(maxWidth: 500),
                                      margin: const EdgeInsets.only(top: 50),
                                      decoration: const BoxDecoration(
                                          color: Color(0xFFE1E0F5),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30))),
                                      child: Center(
                                        child: Container(
                                          constraints: const BoxConstraints(
                                              maxHeight: 100),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Image.asset(
                                            Strings.socialMediaIcon,
                                            // fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            Container(
                                constraints:
                                    const BoxConstraints(maxWidth: 500),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(children: <TextSpan>[
                                    TextSpan(
                                        text: 'We will send you an ',
                                        style: TextStyle(
                                            color: COLORS.primaryColor)),
                                    TextSpan(
                                        text: 'One Time Password ',
                                        style: TextStyle(
                                            color: COLORS.primaryColor,
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: 'on this mobile number',
                                        style: TextStyle(
                                            color: COLORS.primaryColor)),
                                  ]),
                                )),
                            Container(
                              height: 40,
                              constraints: const BoxConstraints(maxWidth: 500),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: CupertinoTextField(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(4))),
                                controller: phoneController,
                                clearButtonMode: OverlayVisibilityMode.editing,
                                keyboardType: TextInputType.phone,
                                maxLines: 1,
                                placeholder: '+91...',
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              constraints: const BoxConstraints(maxWidth: 500),
                              child: MaterialButton(
                                onPressed: () {
                                  if (phoneController.text.isNotEmpty) {
                                    loginStore.getCodeWithPhoneNumber(context,
                                        phoneController.text.toString());
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        'Please enter a phone number',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ));
                                  }
                                },
                                color: COLORS.primaryColor,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(14))),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Next',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
                                          color: COLORS.primaryColorLight,
                                        ),
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
