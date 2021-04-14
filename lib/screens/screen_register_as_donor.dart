import 'package:flutter/material.dart';
import 'package:fooddo/classes/city.dart';
import 'package:fooddo/classes/user.dart';
import 'package:fooddo/components/continuation_button.dart';
import '../services.dart';

class RegisterAsDonor extends StatefulWidget {
  static final routeName = "/register";

  @override
  _RegisterAsDonorState createState() => _RegisterAsDonorState();
}

class _RegisterAsDonorState extends State<RegisterAsDonor> {
  var _formKey;
  List<City> cities = <City>[
    const City("Peshawar"),
    const City("Lahore"),
    const City("Islamabad"),
    const City("Mardan"),
    const City("Nowshehra")
  ];
  String donorType = "";
  City donorSelectedCity;
  String donorEmail = "";
  String donorPickUpAddress = "";
  String donorName = "";
  String registerationNumber = "";

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as Map;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.symmetric(
            vertical: 50,
            horizontal: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              ),
              Column(
                //conditional item
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Address",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      DropdownButton<City>(
                        hint: Text("Select a city"),
                        value: donorSelectedCity,
                        onChanged: (City selected) => {
                          setState(
                            () {
                              donorSelectedCity = selected;
                            },
                          ),
                        },
                        items: cities.map(
                          (City city) {
                            return DropdownMenuItem<City>(
                              value: city,
                              child: Text(city.name),
                            );
                          },
                        ).toList(),
                      ),
                    ],
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: "mail@example.com",
                            helperText:
                                "Please provide email for mportant communication",
                          ),
                          onChanged: (value) {
                            setState(() {
                              donorEmail = value;
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please Enter your Email";
                            } else if (value.contains(' ') ||
                                !(value.contains('@') && value.contains('.'))) {
                              return "Please Enter a valid Email";
                            } else {
                              return null;
                            }
                          },
                          textCapitalization: TextCapitalization.none,
                          enableSuggestions: false,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: "Street#1, Building#4, xyz road",
                            helperText: "Please provide address for pickup",
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            setState(() {
                              donorPickUpAddress = value;
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) return "Please Enter Address";
                            return null;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: donorType == "Individual"
                                ? "John Doe"
                                : "xyz Marquee",
                            helperText: donorType == "Individual"
                                ? "Your good name for human identification"
                                : "Representative of the Establishment",
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please Enter a name";
                            }
                            if (value.contains('1') ||
                                value.contains('2') ||
                                value.contains('3') ||
                                value.contains('4') ||
                                value.contains('5') ||
                                value.contains('6') ||
                                value.contains('6') ||
                                value.contains('7') ||
                                value.contains('8') ||
                                value.contains('9') ||
                                value.contains('0')) {
                              return "Name can not have numbers";
                            } else if (value.trim().length < 3) {
                              return "Please Enter your Complete Name";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            setState(() {
                              donorName = value;
                            });
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ContinuationButton(
                    buttonText: "Continue",
                    onTap: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        Services.registerDonor(
                          User(
                            address: donorPickUpAddress,
                            city: donorSelectedCity.name,
                            email: donorEmail,
                            name: donorName,
                            type: donorType,
                            phone: args["phoneNumber"],
                          ),
                          context,
                        );
                      }
                    },
                  ),
                ],
              ),
              SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
