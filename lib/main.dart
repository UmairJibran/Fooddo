//Packages Import
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

//Screens Import
import 'screens/screen_charity_delivery_person_select.dart';
import 'screens/screen_charity_home.dart';
import 'screens/screen_charity_rejected.dart';
import 'screens/screen_check_reg_status.dart';
import 'screens/screen_home.dart';
import 'screens/screen_login.dart';
import 'screens/screen_make_donation.dart';
import 'screens/screen_register_as_donor.dart';
import 'screens/screen_confirm_donation.dart';
import 'screens/screen_settings.dart';
import 'screens/screen_charity_accepted.dart';
import 'screens/screen_charity_completed.dart';
import 'screens/screen_donation_details.dart';
import 'screens/screen_charity_en_route.dart';
import 'screens/screen_splash.dart';
import 'screens/screen_charity_update_loading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        ConfirmDonation.routeName: (ctx) => ConfirmDonation(),
        CheckRegisterationStatus.routeName: (ctx) => CheckRegisterationStatus(),
        Settings.routeName: (ctx) => Settings(),
        DonationDetails.routeName: (ctx) => DonationDetails(),
        CharityUpdateLoading.routeName: (ctx) => CharityUpdateLoading(),
        CharityDashboard.routeName: (ctx) => CharityDashboard(),
        CharityRejected.routeName: (ctx) => CharityRejected(),
        CharityAccepted.routeName: (ctx) => CharityAccepted(),
        CharityCompleted.routeName: (ctx) => CharityCompleted(),
        CharityEnRoute.routeName: (ctx) => CharityEnRoute(),
        DeliveryPersonsAssignment.routeName: (ctx) =>
            DeliveryPersonsAssignment(),
      },
    );
  }
}
