import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/screens/homepage.dart';
import 'package:social_media_app/stores/post_store.dart';
import 'package:social_media_app/stores/user_store.dart';

import '../widgets/loader.dart';

class CreatePost extends StatefulWidget {
  final String croppedFilePath;
  const CreatePost({Key? key, required this.croppedFilePath}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  TextEditingController textEditingController = TextEditingController();
  late UserStore userStore;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    userStore = Provider.of<UserStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PostStore>(
      builder: ((context, PostStore postStore, child) {
        return Observer(
          builder: ((context) {
            return LoaderHUD(
              inAsyncCall: postStore.isPostUploading,
              child: Scaffold(
                appBar: AppBar(
                    automaticallyImplyLeading: false,
                    leading: GestureDetector(
                      child: Icon(Icons.arrow_back),
                      onTap: () {
                        // Navigator.pop(context);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (c) => HomePage()),
                            (route) => false);
                      },
                    ),
                    actions: [
                      GestureDetector(
                        child: Container(
                          width: 50,
                          // height: 50,
                          margin: EdgeInsets.only(right: 10),
                          child: Icon(Icons.arrow_forward),
                        ),
                        onTap: () {
                          postStore.addNewPost(
                              socialMediaUser: userStore.user!,
                              context: context,
                              filePath: widget.croppedFilePath,
                              caption: textEditingController.text);
                        },
                      )
                    ]),
                body: Column(
                  children: [
                    Container(
                      height: 300,
                      child: Row(children: [
                        Container(
                          height: 200,
                          width: 200,
                          child: Image.file(File(widget.croppedFilePath)),
                        ),
                        Expanded(
                          child: Container(
                            height: 200,
                            child: TextField(
                                controller: textEditingController,
                                decoration:
                                    InputDecoration(hintText: "Caption")),
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            );
          }),
        );
      }),
    );
  }
}
