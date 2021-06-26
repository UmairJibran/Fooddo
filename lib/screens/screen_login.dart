//Packages Import
import 'package:flutter/material.dart';

//Component Import
import 'package:fooddo/components/continuation_button.dart';

import '../services.dart';

class Login extends StatefulWidget {
  static final routeName = "/login";

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _phoneNumber = "";
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _loading
            ? CircularProgressIndicator()
            : Container(
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
                        style: TextStyle(fontFamily: "Roboto"),
                        onChanged: (value) {
                          setState(() {
                            _phoneNumber = value;
                          });
                        },
                        decoration: InputDecoration(
                          prefixText: "+92 - ",
                          hintText: "3123456789",
                          helperText: "Please Enter Your Mobile Number",
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ContinuationButton(
                          onTap: () async {
                            if (_phoneNumber.isNotEmpty &&
                                _phoneNumber.length == 10) {
                              setState(() {
                                _loading = true;
                              });
                              await Services.verifyPhone(
                                "+92" + _phoneNumber,
                                context,
                              );
                            }
                          },
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
