import 'package:fino_wise/router/app_router.dart';
import 'package:fino_wise/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyApp> {
  final AppRouter _router = AppRouter();


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Sizer(
      builder: (context, orientation, deviceType) {
        // Set system UI to Dark with Light icons

        return MaterialApp(
          title: 'FinoWise',
          debugShowCheckedModeBanner: false,
          //theme: ThemeUtils.buildAppTheme(context),
          home: SplashScreen(),
          onGenerateRoute: _router.getRoute,
          navigatorObservers: [_router.routeObserver],
        );
      },
    );
  }
}
