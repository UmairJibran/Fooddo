import 'package:flutter/material.dart';
import 'package:fooddo/classes/donation.dart';
import 'package:fooddo/screens/screen_donation_details.dart';

class UnclaimedFoodCardTile extends StatelessWidget {
  final Donation donation;
  final double height;
  UnclaimedFoodCardTile({
    this.donation,
    this.height,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          new BoxShadow(
            blurRadius: 20,
            color: Colors.grey[400],
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            DonationDetails.routeName,
            arguments: {
              "donation": donation,
            },
          );
        },
        splashColor: Colors.black38,
        child: Row(
          children: [
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  donation.imgUrl,
                  height: height * 0.78,
                  width: height * 0.78,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 10),
            Container(
              height: height * 0.7,
              width: MediaQuery.of(context).size.width * 0.38,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Served",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        donation.status == "delivered"
                            ? Icons.check
                            : Icons.query_builder,
                        color: donation.status == "delivered"
                            ? Colors.greenAccent
                            : Colors.indigo,
                      ),
                    ],
                  ),
                  Text(
                    "${donation.serving} People",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "at ${donation.recepient}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "on ${donation.date}",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}