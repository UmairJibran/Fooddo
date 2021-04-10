import 'package:fooddo/enums/status.dart';

class Donation {
  final String id;
  final String imgUrl;
  final int serving;
  final Status status;
  final String recepient;
  final String date;
  final String pickupAddress;

  Donation({
    this.id,
    this.pickupAddress,
    this.imgUrl,
    this.serving,
    this.status,
    this.recepient,
    this.date,
  });
}