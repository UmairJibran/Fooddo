import 'package:flutter/material.dart';
import 'package:fooddo/classes/donation.dart';
import 'package:fooddo/components/charity_food_card.dart';

import '../services.dart';

class CharityEnRoute extends StatelessWidget {
  static final routeName = "/charity-en-route";

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
              id: Data.enRouteDonations[index].id,
              date: Data.enRouteDonations[index].date,
              serving: Data.enRouteDonations[index].serving,
              imgUrl: Data.enRouteDonations[index].imgUrl,
              status: Data.enRouteDonations[index].status,
              recepient: Data.enRouteDonations[index].recepient,
              donorId: Data.enRouteDonations[index].donorId,
              pickupAddress: Data.enRouteDonations[index].pickupAddress,
              waitingTime: Data.enRouteDonations[index].waitingTime,
            ),
            height: height * 0.25,
          );
        },
        itemCount: Data.enRouteDonations.length,
      ),
    );
  }
}
