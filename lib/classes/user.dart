import 'package:fooddo/enums/donor_type.dart';

class User {
  final String id;
  final String city;
  final String email;
  final String phone;
  final DonorType type;
  final String address;
  final String name;

  User({
    this.id,
    this.city,
    this.email,
    this.phone,
    this.type,
    this.address,
    this.name,
  });
}