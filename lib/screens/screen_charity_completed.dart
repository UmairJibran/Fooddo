import 'package:flutter/material.dart';
import 'package:fooddo/classes/donation.dart';
import 'package:fooddo/components/charity_food_card.dart';

import '../services.dart';

class CharityCompleted extends StatelessWidget {
  static final routeName = "/charity-completed";

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
              id: Data.completedDonations[index].id,
              date: Data.completedDonations[index].date,
              serving: Data.completedDonations[index].serving,
              imgUrl: Data.completedDonations[index].imgUrl,
              status: Data.completedDonations[index].status,
              recepient: Data.completedDonations[index].recepient,
              donorId: Data.completedDonations[index].donorId,
              pickupAddress: Data.completedDonations[index].pickupAddress,
              waitingTime: Data.completedDonations[index].waitingTime,
            ),
            height: height * 0.25,
          );
        },
        itemCount: Data.completedDonations.length,
      ),
    );
  }
}
