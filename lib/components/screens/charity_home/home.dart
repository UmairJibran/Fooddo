import 'package:flutter/material.dart';
import 'package:fooddo/classes/donation.dart';
import 'package:fooddo/components/charity_food_card.dart';
import 'package:fooddo/screens/screen_charity_update_loading.dart';

import '../../../services.dart';

class ChairyHomeComponent extends StatelessWidget {
  final double height;

  ChairyHomeComponent({Key key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.794,
        child: ListView.builder(
          itemBuilder: (BuildContext context, index) {
            return index == 0
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed(
                          (CharityUpdateLoading.routeName),
                        );
                      },
                      child: Text(
                        "Refresh",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                : CharityFoodCard(
                    donation: new Donation(
                      id: Data.unclaimedDonations[index - 1].id,
                      date: Data.unclaimedDonations[index - 1].date,
                      serving: Data.unclaimedDonations[index - 1].serving,
                      imgUrl: Data.unclaimedDonations[index - 1].imgUrl,
                      status: Data.unclaimedDonations[index - 1].status,
                      recepient: Data.unclaimedDonations[index - 1].recepient,
                      donorId: Data.unclaimedDonations[index - 1].donorId,
                      pickupAddress:
                          Data.unclaimedDonations[index - 1].pickupAddress,
                    ),
                    height: height * 0.25,
                  );
          },
          itemCount: Data.unclaimedDonations.length + 1,
        ),
      ),
    );
  }
}
