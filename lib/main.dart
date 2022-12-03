import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/screens/splashscreen.dart';
import 'package:social_media_app/stores/login_store.dart';
import 'package:social_media_app/stores/post_store.dart';
import 'package:social_media_app/stores/user_store.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<UserStore>(create: ((context) => UserStore())),
        Provider<LoginStore>(create: (_) => LoginStore()),
        Provider<PostStore>(create: (_) => PostStore())
      ],
      child: const MaterialApp(
        title: 'Social Media App',
        home: SplashScreen(),
      ),
    );
  }
}
