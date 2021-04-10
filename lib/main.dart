//Packages Import
import 'package:flutter/material.dart';
import 'package:fooddo/screens/screen_home.dart';
import 'package:fooddo/screens/screen_login.dart';
import 'package:fooddo/screens/screen_make_donation.dart';
import 'package:fooddo/screens/screen_register_as_donor.dart';

//Screens Import
import 'screens/screen_confirm_donation.dart';
import 'screens/screen_splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromRGBO(242, 166, 66, 1),
        fontFamily: "Raleway",
      ),
      routes: {
        "/": (ctx) => SplashScreen(),
        Login.routeName: (ctx) => Login(),
        RegisterAsDonor.routeName: (ctx) => RegisterAsDonor(),
        Home.routeName: (ctx) => Home(),
        MakeDonation.routeName: (ctx) => MakeDonation(),
        ConfirmDonation.routeName: (ctx) => ConfirmDonation()
      },
    );
  }
}
