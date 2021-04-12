//Packages Import
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart' as Splash;

//Screens Import
import '../services.dart';
import 'screen_charity_home.dart';
import 'screen_home.dart';
import 'screen_login.dart';

class SplashScreen extends StatelessWidget {
  Future<Widget> checkIfLoggedIn(BuildContext context) async {
    bool isLoggedIn = await Services.checkIfLoggedIn();
    if (isLoggedIn) {
      await Services.fetchUserData(Data.userPhone);
      if (Data.user.isDonor) {
        await Services.fetchUserPastDonation();
        return Home();
      } else {
        await Services.fetchUnclaimedDonations();
        return CharityDashboard();
      }
    } else {
      return Login();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Splash.SplashScreen(
        navigateAfterFuture: checkIfLoggedIn(context),
        useLoader: false,
        backgroundColor: Colors.white,
        photoSize: 150.0,
        image: Image.asset("./lib/assets/fooddo_logo.png"),
      ),
    );
  }
}
