import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  static final routeName = "/loading";

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Map args;
  void moveNext() async {
    await Future.delayed(Duration(seconds: 5));
    Navigator.of(context).pushReplacementNamed(args["target"]);
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments as Map;
    moveNext();
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
