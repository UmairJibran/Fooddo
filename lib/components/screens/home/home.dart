import 'package:flutter/material.dart';
import 'package:fooddo/classes/donation.dart';
import 'package:fooddo/enums/status.dart';
import 'package:intl/intl.dart';

import '../../food_card.dart';

class HomeComponent extends StatelessWidget {
  final double height;
  final List<Donation> pastDonations = <Donation>[
    Donation(
      date: DateFormat.yMd().format(DateTime.now()).toString(),
      id: "donation_1",
      imgUrl: "https://via.placeholder.com/150",
      pickupAddress: "Dalazak",
      recepient: "Edhi Care Center",
      serving: 23,
      status: Status.delivered,
    ),
    Donation(
      date: DateFormat.yMd().format(DateTime.now()).toString(),
      id: "donation_2",
      imgUrl: "https://via.placeholder.com/150",
      pickupAddress: "Dalazak",
      recepient: "Langar Khana",
      serving: 56,
      status: Status.delivered,
    ),
    Donation(
      date: DateFormat.yMd().format(DateTime.now()).toString(),
      id: "donation_3",
      imgUrl: "https://via.placeholder.com/150",
      pickupAddress: "Dalazak",
      recepient: "Orphanage",
      serving: 23,
      status: Status.waiting,
    ),
    Donation(
      date: DateFormat.yMd().format(DateTime.now()).toString(),
      id: "donation_1",
      imgUrl: "https://via.placeholder.com/150",
      pickupAddress: "Dalazak",
      recepient: "Madrassa Tableeghul Quran",
      serving: 23,
      status: Status.waiting,
    ),
  ];

  HomeComponent({Key key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.794,
        child: ListView.builder(
          itemBuilder: (BuildContext context, index) {
            return FoodCardTile(
              date: pastDonations[index].date,
              serving: pastDonations[index].serving,
              imgUrl: pastDonations[index].imgUrl,
              status: pastDonations[index].status,
              recepient: pastDonations[index].recepient,
              height: height * 0.25,
            );
          },
          itemCount: pastDonations.length,
        ),
      ),
    );
  }
}
