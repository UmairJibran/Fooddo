import 'package:flutter/material.dart';
import 'package:fooddo/components/continuation_button.dart';
import 'package:fooddo/screens/screen_home.dart';

class ConfirmDonation extends StatelessWidget {
  static final routeName = "/confirm-donation";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Fooddo",
          style: TextStyle(
            fontFamily: "Billabong",
            fontSize: 35,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 30,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Review Donation",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: "Name of the donor(for contact)",
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: "xyz road",
                    helperText: "Pickup Location",
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: "How long can you wait?",
                    helperText:
                        "We will notify the recepients to come in the provided time",
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ContinuationButton(
                  buttonText: "Donate",
                  onTap: () {
                    //TODO: post donation request
                    Navigator.of(context).pushReplacementNamed(Home.routeName);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
