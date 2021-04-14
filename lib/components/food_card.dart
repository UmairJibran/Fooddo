import 'package:flutter/material.dart';

class FoodCardTile extends StatelessWidget {
  final String date;
  final String imgUrl;
  final int serving;
  final String status;
  final double height;
  final String recepient;
  final String donationId;
  final String pickupAddress;
  FoodCardTile({
    this.pickupAddress,
    this.date,
    this.donationId,
    this.imgUrl,
    this.serving,
    this.status,
    this.height,
    this.recepient,
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
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Details",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    if (status == "completed")
                      Icon(
                        Icons.done_all_outlined,
                        color: Theme.of(context).primaryColor,
                      )
                    else if (status == "waiting")
                      Icon(
                        Icons.schedule_outlined,
                        color: Colors.indigo,
                      )
                    else if (status == "accepted")
                      Icon(
                        Icons.check,
                        color: Colors.green,
                      )
                    else if (status == "rejected")
                      Icon(
                        Icons.close,
                        color: Colors.red,
                      )
                    else if (status == "collecting")
                      Icon(
                        Icons.local_shipping_outlined,
                        color: Colors.cyan,
                      )
                  ],
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          imgUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Meal for $serving was donated to $recepient on $date",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "$pickupAddress",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              );
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
                  imgUrl,
                  height: height * 0.7,
                  width: height * 0.7,
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
                      if (status == "completed")
                        Icon(
                          Icons.done_all_outlined,
                          color: Theme.of(context).primaryColor,
                        )
                      else if (status == "waiting")
                        Icon(
                          Icons.schedule_outlined,
                          color: Colors.indigo,
                        )
                      else if (status == "accepted")
                        Icon(
                          Icons.check,
                          color: Colors.green,
                        )
                      else if (status == "rejected")
                        Icon(
                          Icons.close,
                          color: Colors.red,
                        )
                      else if (status == "collecting")
                        Icon(
                          Icons.local_shipping_outlined,
                          color: Colors.cyan,
                        )
                    ],
                  ),
                  Text(
                    "$serving People",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "at $recepient",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "on $date",
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
