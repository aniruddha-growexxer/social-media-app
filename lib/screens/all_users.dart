import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/constants.dart';
import 'package:social_media_app/screens/user_wall.dart';
import 'package:social_media_app/stores/user_store.dart';
import 'package:social_media_app/widgets/profile_image_avatar.dart';

class AllUsers extends StatefulWidget {
  const AllUsers({Key? key}) : super(key: key);

  @override
  State<AllUsers> createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  late UserStore userStore;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    userStore = Provider.of<UserStore>(context);
    await userStore.setUser(GlobalConstants.userId);
    await userStore.fetchAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Explore"),
            actions: [
              IconButton(
                  onPressed: () async {
                    await userStore.setUser(GlobalConstants.userId);
                    await userStore.fetchAllUsers();
                    setState(() {});
                  },
                  icon: Icon(Icons.refresh_rounded))
            ],
          ),
          body: userStore.fetchingAllUsers
              ? CircularProgressIndicator()
              : ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  itemCount: userStore.allUsers.length,                  
                  itemBuilder: (c, i) {
                    if (userStore.allUsers[i].userId == userStore.user!.userId)
                      return Container();
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) =>
                                UserWall(userId: userStore.allUsers[i].userId),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        // color: COLORS.secondaryColorLight,
                        padding: EdgeInsets.only(
                          top: 10,
                          right: 10,
                        ),
                        height: 90,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Image.network(
                            //   userStore.allUsers[i].imageUrl.toString(),
                            //   loadingBuilder: (context, child, loadingProgress) {
                            //     if (loadingProgress == null) return child;
                            //     return CircularProgressIndicator(
                            //       value: loadingProgress.cumulativeBytesLoaded /
                            //           loadingProgress.expectedTotalBytes!.toInt(),
                            //     );
                            //   },
                            // ),
                            profileImageAvatar(
                                imageUrl:
                                    userStore.allUsers[i].imageUrl.toString(),
                                diameter: 80),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                userStore.allUsers[i].userName,
                                style: TextStyle(color: COLORS.secondaryColor),
                              ),
                            ),
                            MaterialButton(
                              elevation: 4,
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: userStore.allUsers[i].followers!
                                        .contains(GlobalConstants.userId)
                                    ? BorderSide(
                                        color: COLORS.secondaryColor,
                                      )
                                    : BorderSide.none,
                              ),
                              onPressed: () async {
                                if (userStore.allUsers[i].followers!
                                    .contains(GlobalConstants.userId)) {
                                  userStore.unfollowUser(
                                      userStore.allUsers[i].userId);
                                } else {
                                  userStore
                                      .followUser(userStore.allUsers[i].userId);
                                }
                                userStore.setUser(GlobalConstants.userId);                                
                              },
                              color: userStore.allUsers[i].followers!
                                      .contains(GlobalConstants.userId)
                                  ? Colors.white
                                  : COLORS.secondaryColor,
                              child: Text(
                                userStore.allUsers[i].followers!
                                        .contains(GlobalConstants.userId)
                                    ? "Unfollow"
                                    : "Follow",
                                style: TextStyle(
                                  color: userStore.allUsers[i].followers!
                                          .contains(GlobalConstants.userId)
                                      ? COLORS.secondaryColor
                                      : Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
