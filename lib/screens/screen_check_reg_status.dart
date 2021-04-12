import 'package:flutter/material.dart';
import 'package:fooddo/services.dart';

class CheckRegisterationStatus extends StatelessWidget {
  static final routeName = "/check-registeration-status";
  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments as Map;
    Services.checkIfUserExists(args["user"].phoneNumber, context);

    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
