import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:news_test_app/pages/favorite_news_page.dart';
import 'package:news_test_app/pages/news_list_page.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:sizer/sizer.dart';

import '../controllers/main_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MainController controller = Get.find();
  bool isSearch = false;
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: controller.perTabController.value,
      screens: [
        NewsListPage(),
        FavoriteNewsPage(),
      ],
      items: [
        PersistentBottomNavBarItem(
          icon: Center(
            child: FaIcon(FontAwesomeIcons.house,
                color: Colors.black, size: 20.sp),
          ),
          inactiveIcon: Center(
            child: FaIcon(FontAwesomeIcons.house,
                color: Colors.grey.withOpacity(0.5), size: 20.sp),
          ),
        ),
        PersistentBottomNavBarItem(
          icon: Center(
            child: FaIcon(
              FontAwesomeIcons.solidHeart,
              color: Colors.black,
              size: 20.sp,
            ),
          ),
          inactiveIcon: Center(
            child: FaIcon(
              FontAwesomeIcons.solidHeart,
              color: Colors.grey.withOpacity(0.5),
              size: 20.sp,
            ),
          ),
        ),
      ],
      navBarHeight: 16.w,
      padding: NavBarPadding.only(bottom: 3.w),
      confineInSafeArea: true,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      decoration: NavBarDecoration(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(26), topLeft: Radius.circular(26)),
        colorBehindNavBar: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
      ),
      navBarStyle: NavBarStyle.style11,
    );
  }
}
