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
  TextEditingController _phoneNumberController = new TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            if (_loading)
              Container(
                color: Colors.black26,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    "assets/fooddo_logo.png",
                    height: 150,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      controller: _phoneNumberController,
                      autofocus: true,
                      enabled: true,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontFamily: "Roboto"),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        prefixText: "+92 - ",
                        hintText: "3123456789",
                        labelText: "Please Enter Your Mobile Number",
                        labelStyle: TextStyle(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ContinuationButton(
                        onTap: () async {
                          if (_phoneNumberController.text.isNotEmpty &&
                              _phoneNumberController.text.length == 10) {
                            setState(() {
                              _loading = true;
                            });
                            await Services.verifyPhone(
                              "+92" + _phoneNumberController.text,
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
          ],
        ),
      ),
    );
  }
}
