import 'package:flutter/material.dart';
import 'package:fooddo/classes/donation.dart';
import 'package:fooddo/components/charity_food_card.dart';

import '../services.dart';

class CharityRejected extends StatelessWidget {
  static final routeName = "/charity-rejected";

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
              id: Data.rejectedDonations[index].id,
              date: Data.rejectedDonations[index].date,
              serving: Data.rejectedDonations[index].serving,
              imgUrl: Data.rejectedDonations[index].imgUrl,
              status: Data.rejectedDonations[index].status,
              recepient: Data.rejectedDonations[index].recepient,
              donorId: Data.rejectedDonations[index].donorId,
              pickupAddress: Data.rejectedDonations[index].pickupAddress,
              waitingTime: Data.rejectedDonations[index].waitingTime,
            ),
            height: height * 0.25,
          );
        },
        itemCount: Data.rejectedDonations.length,
      ),
    );
  }
}
