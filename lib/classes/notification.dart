import 'package:flutter/foundation.dart';

class Notification {
  final String id;
  final String donationId;
  final String status;
  final String timeStamp;

  Notification({
    @required this.id,
    @required this.donationId,
    @required this.status,
    @required this.timeStamp,
  });
}
