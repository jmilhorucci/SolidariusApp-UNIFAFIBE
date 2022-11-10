import 'package:flutter/material.dart';
import 'package:solidarius_app/custom_drawer/screens/about_screen.dart';
import 'package:solidarius_app/custom_drawer/screens/feedback_screen.dart';
import 'package:solidarius_app/custom_drawer/screens/help_screen.dart';
import 'package:solidarius_app/custom_drawer/screens/share_screen.dart';
import 'package:solidarius_app/theme/app_theme.dart';
import 'package:solidarius_app/custom_drawer/controller/drawer_user_controller.dart';
import 'package:solidarius_app/custom_drawer/home_drawer.dart';
import 'package:solidarius_app/home_screen.dart';

class NavigationHomeScreen extends StatefulWidget {
  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget? screenView;
  DrawerIndex? drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = const MyHomePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
              //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
            },
            screenView: screenView,
            //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      switch (drawerIndex) {
        case DrawerIndex.HOME:
          setState(() {
            screenView = const MyHomePage();
          });
          break;
        case DrawerIndex.Help:
          setState(() {
            screenView = AjudaScreen();
          });
          break;
        case DrawerIndex.FeedBack:
          setState(() {
            screenView = FeedbackScreen();
          });
          break;
        case DrawerIndex.Share:
          setState(() {
            screenView = ShareScreen();
          });
          break;
        case DrawerIndex.About:
          setState(() {
            screenView = AboutScreen();
          });
          break;
        default:
          break;
      }
    }
  }
}
