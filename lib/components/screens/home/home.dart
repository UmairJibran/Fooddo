import 'package:flutter/material.dart';

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
            return FoodCardTile(
              date: Data.pastDonations[index].date,
              serving: Data.pastDonations[index].serving,
              imgUrl: Data.pastDonations[index].imgUrl,
              status: Data.pastDonations[index].status,
              recepient: Data.pastDonations[index].recepient,
              height: height * 0.25,
            );
          },
          itemCount: Data.pastDonations.length,
        ),
      ),
    );
  }
}
