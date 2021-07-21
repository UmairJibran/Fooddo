import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class FoodCardTile extends StatelessWidget {
  final String date;
  final String imgUrl;
  final int serving;
  final String status;
  final double height;
  final String recepient;
  final String donationId;
  final String pickupAddress;
  final String charityCall;
  final Timestamp timeStamp;
  final String foodName;
  final String foodDetails;
  FoodCardTile({
    this.pickupAddress,
    this.date,
    this.donationId,
    this.imgUrl,
    this.serving,
    this.status,
    this.height,
    this.recepient,
    this.charityCall,
    this.timeStamp,
    this.foodName,
    this.foodDetails,
  });
  @override
  Widget build(BuildContext context) {
    var _timeStamp =
        DateTime.fromMicrosecondsSinceEpoch(timeStamp.microsecondsSinceEpoch);
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
                backgroundColor: Colors.teal[100],
                title: Row(
                  children: [
                    Text(
                      "Details",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 30,
                      ),
                    ),
                    Spacer(),
                    if (status == "completed")
                      Icon(
                        Icons.done_all_outlined,
                        color: Colors.blue[700],
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        foodName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(foodDetails),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Meal for $serving people was donated to $recepient on $date",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "$pickupAddress",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 20),
                    RaisedButton(
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        "Call $recepient",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      onPressed: () async {
                        await FlutterPhoneDirectCaller.callNumber(
                            "03138185443");
                      },
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
                  height: height * 0.8,
                  width: height * 0.8,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 10),
            Container(
              height: height * 0.7,
              width: MediaQuery.of(context).size.width * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        foodName,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      if (status == "completed")
                        Icon(
                          Icons.done_all_outlined,
                          color: Colors.blue[700],
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
                    foodDetails,
                    style: TextStyle(fontSize: 16),
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
                    "on ${_timeStamp.day}/${_timeStamp.month}/${_timeStamp.year} around ${_timeStamp.hour}:${_timeStamp.minute}",
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
