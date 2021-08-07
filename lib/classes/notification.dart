import 'package:flutter/foundation.dart';

class Notification {
  final String id;
  final String donationId;
  final String status;
  final String timeStamp;
  final String donationName;
  final String reason;

  Notification({
    @required this.id,
    @required this.donationId,
    @required this.status,
    @required this.timeStamp,
    @required this.donationName,
    @required this.reason,
  });
}
