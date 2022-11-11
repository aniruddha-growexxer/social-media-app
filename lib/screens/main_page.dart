import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/screens/all_users.dart';
import 'package:social_media_app/screens/homepage.dart';
import 'package:social_media_app/screens/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  late TabController tabController;
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      // print("${tabController.index}");
      setState(() {
        _currentTabIndex = tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    tabController.animateTo(_currentTabIndex);
    return DefaultTabController(
      length: 3,
      initialIndex: _currentTabIndex,
      child: Scaffold(
        body: TabBarView(controller: tabController, children: [
          HomePage(),
          AllUsers(),
          ProfileScreen(),
        ]),
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentTabIndex,
            selectedItemColor: COLORS.secondaryColor,
            unselectedItemColor: COLORS.secondaryColorLight,            
            onTap: (index) {
              setState(() {
                _currentTabIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(                        
                icon: Icon(
                  Icons.home,
                  size: 30.0,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  size: 30.0,
                ),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_outlined,
                  size: 30.0,
                ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
