//Packages Import
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart' as Splash;

//Screens Import
import '../services.dart';
import 'screen_login.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Services.fetchUserPastDonation();
    return Scaffold(
      body: Splash.SplashScreen(
        seconds: 4,
        navigateAfterSeconds: Login(),
        useLoader: false,
        backgroundColor: Colors.white,
        photoSize: 150.0,
        image: Image.asset("./lib/assets/fooddo_logo.png"),
      ),
    );
  }
}
