import 'package:flutter/material.dart';
import 'package:fooddo/components/make_donation.dart';

import '../../../services.dart';
import '../../food_card.dart';

class HomeComponent extends StatelessWidget {
  final double height;

  HomeComponent({Key key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.794,
        child: ListView.builder(
          itemBuilder: (BuildContext context, index) {
            return index == 0
                ? AddDonation(height: height)
                : FoodCardTile(
                    pickupAddress: Data.pastDonations[index - 1].pickupAddress,
                    donationId: Data.pastDonations[index - 1].id,
                    date: Data.pastDonations[index - 1].date,
                    serving: Data.pastDonations[index - 1].serving,
                    imgUrl: Data.pastDonations[index - 1].imgUrl,
                    status: Data.pastDonations[index - 1].status,
                    recepient: Data.pastDonations[index - 1].recepient,
                    height: height * 0.25,
                  );
          },
          itemCount: Data.pastDonations.length + 1,
        ),
      ),
    );
  }
}
