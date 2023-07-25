

import 'package:fino_wise/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/app_screens.dart';
import '../../constants/image_asset_path.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  bool isLogin = false;
  late Animation<double> animation;
  late AnimationController controller;

  Future initValue() async {

  }


  @override
  void initState() {
    initValue();
    super.initState();
    getLogin();

    controller = AnimationController(vsync: this, duration: const Duration(seconds: 3));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.forward();
    checkLoginUser();
  }


  Future getLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //isLogin = prefs.getBool(AppConstants.ISLOGIN) ?? false;
  }

  Future checkLoginUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    animation.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        if (isLogin) {
          print('Is Login.....');
          //openDashboard();
        } else {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppScreens.login,
                (Route<dynamic> route) => false,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: AppStyles.appColor,
          image: DecorationImage(
            image: AssetImage(ImageAssetPath.icBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: animation,
            child: Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: Image.asset(
                ImageAssetPath.icFinoWise,
                height: 400.0,
                width: 400.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void openDashboard() {
    /*Navigator.pushNamedAndRemoveUntil(
      context,
      AppScreens.dashboard,
          (Route<dynamic> route) => false,
    );*/
  }
}