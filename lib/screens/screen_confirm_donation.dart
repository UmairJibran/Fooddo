import 'package:flutter/material.dart';
import 'package:fooddo/classes/donation.dart';
import 'package:fooddo/components/continuation_button.dart';
import 'package:fooddo/screens/screen_home.dart';
import 'package:fooddo/screens/screen_loading.dart';
import 'package:intl/intl.dart';

import '../services.dart';

class ConfirmDonation extends StatefulWidget {
  static final routeName = "/confirm-donation";

  @override
  _ConfirmDonationState createState() => _ConfirmDonationState();
}

class _ConfirmDonationState extends State<ConfirmDonation> {
  String _name = Data.user.name;
  String _pickUpAddress = Data.user.address;
  int _waitingTime = 60;

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments as Map;
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
                    hintText: _name,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _name = value;
                    });
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: _pickUpAddress,
                    helperText: "Pickup Location",
                  ),
                  onChanged: (value) {
                    setState(() {
                      _pickUpAddress = value;
                    });
                  },
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: _waitingTime.toString(),
                    suffixText: "Minutes",
                    helperText:
                        "We will notify the recepients to come in the provided time",
                  ),
                  onChanged: (value) {
                    setState(() {
                      _waitingTime = int.parse(value);
                    });
                  },
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
                    Services.postUserDonation(
                      new Donation(
                        date: DateFormat().add_yMd().format(DateTime.now()),
                        pickupAddress: _pickUpAddress,
                        serving: int.parse(args["servings"].round().toString()),
                        status: "waiting",
                        donorId: Data.userPhone,
                      ),
                      name: _name,
                      address: _pickUpAddress,
                      waitingTime: _waitingTime,
                    );
                    Navigator.of(context).pushReplacementNamed(
                      LoadingScreen.routeName,
                      arguments: {
                        "target": Home.routeName,
                      },
                    );
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
