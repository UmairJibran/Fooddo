import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Donation {
  final String id;
  final String imgUrl;
  final int serving;
  String status;
  final String recepient;
  final String date;
  final String pickupAddress;
  final String donorId;
  final int waitingTime;
  final String city;
  final Map<String, dynamic> longlat;
  final List<dynamic> moreImages;
  final Timestamp timeStamp;
  final String donorName;

  Donation({
    @required this.id,
    @required this.donorId,
    @required this.pickupAddress,
    @required this.imgUrl,
    @required this.serving,
    @required this.status,
    @required this.recepient,
    @required this.date,
    @required this.waitingTime,
    @required this.city,
    @required this.longlat,
    @required this.donorName,
    this.timeStamp,
    this.moreImages,
  });
}
