import 'package:flutter/material.dart';
import './../classes/notification.dart' as Notification;

class NotificationTile extends StatelessWidget {
  final Notification.Notification notification;
  final double height;

  const NotificationTile({Key key, this.notification, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.15,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black,
            style: BorderStyle.solid,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "An Update on your Donation: \"${notification.donationName}\"",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Status changed to: ${notification.status}",
                style: TextStyle(fontSize: 16),
              ),
              notification.reason == null
                  ? SizedBox()
                  : Text(
                      "Reason: ${notification.reason}",
                      style: TextStyle(fontSize: 16),
                    ),
            ],
          ),
          Text(
            "${notification.timeStamp}",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
