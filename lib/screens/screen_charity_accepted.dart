import 'package:flutter/material.dart';
import 'package:fooddo/classes/donation.dart';
import 'package:fooddo/components/charity_food_card.dart';

import '../services.dart';

class CharityAccepted extends StatelessWidget {
  static final routeName = "/charity-accepted";

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              "Fooddo",
              style: TextStyle(
                fontFamily: "Billabong",
                fontSize: 45,
                color: Colors.black,
              ),
            ),
            SizedBox(width: 10),
            Text(
              "Charity",
              style: TextStyle(
                fontFamily: "Billabong",
                fontSize: 25,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, index) {
          return CharityFoodCard(
            donation: new Donation(
              id: Data.acceptedDonations[index].id,
              date: Data.acceptedDonations[index].date,
              serving: Data.acceptedDonations[index].serving,
              imgUrl: Data.acceptedDonations[index].imgUrl,
              status: Data.acceptedDonations[index].status,
              recepient: Data.acceptedDonations[index].recepient,
              donorId: Data.acceptedDonations[index].donorId,
              pickupAddress: Data.acceptedDonations[index].pickupAddress,
              waitingTime: Data.acceptedDonations[index].waitingTime,
              city: Data.acceptedDonations[index].city,
            ),
            height: height * 0.25,
          );
        },
        itemCount: Data.acceptedDonations.length,
      ),
    );
  }
}
