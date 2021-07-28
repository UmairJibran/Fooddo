import 'package:flutter/material.dart';
import 'package:fooddo/classes/donation.dart';
import 'package:fooddo/screens/screen_donation_details.dart';

import '../services.dart';

class CharityFoodCard extends StatefulWidget {
  final Donation donation;
  final double height;
  final String donationType;
  CharityFoodCard({
    this.donation,
    this.height,
    this.donationType,
  });

  @override
  _CharityFoodCardState createState() => _CharityFoodCardState();
}

class _CharityFoodCardState extends State<CharityFoodCard> {
  @override
  Widget build(BuildContext context) {
    widget.donation.seen ??= true;
    return Container(
      height: widget.height,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: widget.donation.seen ? Colors.transparent : Colors.blue,
        ),
        boxShadow: [
          new BoxShadow(
            blurRadius: 20,
            color: Colors.grey[400],
          ),
        ],
      ),
      child: InkWell(
        onTap: () async {
          if (!widget.donation.seen) {
            await Services.donationSeen(widget.donation.id);
            final index = Data.unclaimedDonations.indexWhere((d) {
              return d.id == widget.donation.id;
            });
            setState(() {
              Data.unclaimedDonations[index].seen = true;
            });
          }
          Navigator.of(context).pushNamed(
            DonationDetails.routeName,
            arguments: {
              "donation": widget.donation,
              "donationType": widget.donationType,
            },
          );
        },
        splashColor: Colors.black38,
        child: Row(
          children: [
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: widget.donation.imgUrl == null
                    ? Image.asset(
                        "assets/broken_image.png",
                        height: widget.height * 0.7,
                        width: widget.height * 0.7,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        widget.donation.imgUrl,
                        height: widget.height * 0.7,
                        width: widget.height * 0.7,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            SizedBox(width: 10),
            Container(
              height: widget.height * 0.7,
              width: MediaQuery.of(context).size.width * 0.38,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Serves",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (widget.donation.status == "completed")
                        Icon(
                          Icons.done_all_outlined,
                          color: Colors.blue[700],
                        )
                      else if (widget.donation.status == "waiting")
                        Icon(
                          Icons.schedule_outlined,
                          color: Colors.indigo,
                        )
                      else if (widget.donation.status == "accepted")
                        Icon(
                          Icons.check,
                          color: Colors.green,
                        )
                      else if (widget.donation.status == "rejected")
                        Icon(
                          Icons.close,
                          color: Colors.red,
                        )
                      else if (widget.donation.status == "collecting")
                        Icon(
                          Icons.local_shipping_outlined,
                          color: Colors.cyan,
                        )
                    ],
                  ),
                  Text(
                    "${widget.donation.serving} People",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "at ${widget.donation.recepient}",
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "on ${DateTime.fromMicrosecondsSinceEpoch(widget.donation.timeStamp.microsecondsSinceEpoch)}",
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
