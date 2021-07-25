import 'package:flutter/foundation.dart';

class User {
  final String id;
  final String city;
  String email;
  final String phone;
  final String type;
  String address;
  String name;
  String imageUrl;
  final bool isDonor;
  final bool unreadNotifications;

  User({
    @required this.id,
    @required this.city,
    @required this.email,
    @required this.phone,
    @required this.type,
    @required this.address,
    @required this.name,
    @required this.isDonor,
    @required this.unreadNotifications,
    @required this.imageUrl,
  });
}
