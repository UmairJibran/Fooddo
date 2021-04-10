//Packages Import
import 'package:flutter/material.dart';
import 'package:fooddo/screens/screen_login.dart';
import 'package:fooddo/screens/screen_register_as_donor.dart';

//Screens Import
import 'screens/screen_splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (ctx) => SplashScreen(),
        Login.routeName: (ctx) => Login(),
        RegisterAsDonor.routeName: (ctx) => RegisterAsDonor(),
      },
    );
  }
}
