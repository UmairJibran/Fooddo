import 'package:flutter/material.dart';

class RegisterAsDonor extends StatefulWidget {
  static final routeName = "/register";

  @override
  _RegisterAsDonorState createState() => _RegisterAsDonorState();
}

class _RegisterAsDonorState extends State<RegisterAsDonor> {
  String donorType = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.symmetric(
            vertical: 50,
            horizontal: 100,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Tell us about yourself",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Radio(
                          groupValue: donorType,
                          value: "Individual",
                          onChanged: (value) {
                            setState(() {
                              donorType = value;
                            });
                          },
                        ),
                        Text(
                          "Individual",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          groupValue: donorType,
                          value: "Banquet Hall",
                          onChanged: (value) {
                            setState(() {
                              donorType = value;
                            });
                          },
                        ),
                        Text(
                          "Banquet Hall",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          groupValue: donorType,
                          value: "Resturant",
                          onChanged: (value) {
                            setState(() {
                              donorType = value;
                            });
                          },
                        ),
                        Text(
                          "Resturant",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
