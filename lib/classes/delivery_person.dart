import 'package:flutter/foundation.dart';

class DeliveryPerson {
  final String name;
  final String contact;
  final String id;
  final int vehicleCapacity;

  DeliveryPerson({
    @required this.name,
    @required this.contact,
    @required this.id,
    @required this.vehicleCapacity,
  });
}
