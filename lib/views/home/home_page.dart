import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_odering_app/utils/colors.dart';
import 'package:food_odering_app/utils/dimentions.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../controllers/location_controller.dart';
import '../auth/signup.dart';
import '../cart/cart_history.dart';
import '../profile/profile_view.dart';
import 'main_food_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  late PersistentTabController _controller;
  List<Widget> _buildScreens() {
    return [
      const MainFoodView(),
      Container(
        color: AppColors.mainColor,
        child: const Center(
          child: Text("History"),
        ),
      ),
      const CartHistory(),
      const ProfileView(),
    ];
  }
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home,size: Dimentions.icon24,),
        title: ("Home"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: AppColors.signColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.archivebox,size: Dimentions.icon24,),
        title: ("History"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: AppColors.signColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.cart,size: Dimentions.icon24,),
        title: ("Cart"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: AppColors.signColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.profile_circled,size: Dimentions.icon24,),
        title: ("Profile"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: AppColors.signColor,
      ),
    ];
  }
  @override
  void initState() {
    super.initState();
    Get.find<LocationController>().getCurrentLocation();
    _controller = PersistentTabController(initialIndex: 0);
  }

  // List pages = [
  //   const MainFoodView(),
  //   Container(color: Colors.cyan,child: const Center(child: Text("PAGE 2")),),
  //   Container(color: Colors.green,child: const Center(child: Text("PAGE 3")),),
  //   Container(color: Colors.purpleAccent,child: const Center(child: Text("PAGE 4")),),
  // ];
  // int _selectedIndex = 0;
  // void onTapNav(int index){
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: pages[_selectedIndex],
  //     bottomNavigationBar: BottomNavigationBar(
  //       items: const [
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.home),
  //           label: 'Home',
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.archive_rounded),
  //           label: 'History',
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.shopping_cart),
  //           label: 'Cart',
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.person),
  //           label: 'Profile',
  //         ),
  //       ],
  //       currentIndex: _selectedIndex,
  //       selectedItemColor: AppColors.mainColor,
  //       unselectedItemColor: AppColors.signColor,
  //       showSelectedLabels: false,
  //       showUnselectedLabels: false,
  //       selectedFontSize: 0.0,
  //       unselectedFontSize: 0.0,
  //       elevation: 6,
  //       onTap: (index){
  //         onTapNav(index);
  //       },
  //     )
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      padding: NavBarPadding.only(bottom: Dimentions.height10),
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: AppColors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style1,
    );
  }


}
