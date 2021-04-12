import 'package:flutter/material.dart';
import 'package:fooddo/screens/screen_charity_home.dart';
import 'package:fooddo/services.dart';

class CharityUpdateLoading extends StatelessWidget {
  static final routeName = "/chairty-update";

  updateDonationRequests(BuildContext context) async {
    await Services.fetchUnclaimedDonations();
    Navigator.of(context).pushReplacementNamed(CharityDashboard.routeName);
  }

  @override
  Widget build(BuildContext context) {
    updateDonationRequests(context);

    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
