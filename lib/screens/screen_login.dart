//Packages Import
import 'package:flutter/material.dart';

//Component Import
import 'package:fooddo/components/continuation_button.dart';

class Login extends StatelessWidget {
  static final routeName = "/login";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                "./lib/assets/fooddo_logo.png",
                height: 150,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  autofocus: true,
                  enabled: true,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    prefixText: "+92",
                    hintText: "3123456789",
                    helperText: "Please Enter Your Mobile Number",
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ContinuationButton(
                    onTap: () {},
                    buttonText: "Continue",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
