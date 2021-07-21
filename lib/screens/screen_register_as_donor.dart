import 'package:flutter/material.dart';
import 'package:fooddo/classes/city.dart';
import 'package:fooddo/classes/user.dart';
import 'package:fooddo/components/continuation_button.dart';
import 'package:loading_animations/loading_animations.dart';
import '../services.dart';

class RegisterAsDonor extends StatefulWidget {
  static final routeName = "/register";

  @override
  _RegisterAsDonorState createState() => _RegisterAsDonorState();
}

class _RegisterAsDonorState extends State<RegisterAsDonor> {
  var _formKey;
  bool _loading;
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
    donorSelectedCity = cities[0];
    _loading = false;
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
              if (_loading)
                LoadingFlipping.circle(
                  borderColor: Colors.cyan,
                  borderSize: 3.0,
                  size: 30.0,
                  backgroundColor: Colors.cyanAccent,
                  duration: Duration(milliseconds: 500),
                ),
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
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            hintText: "mail@example.com",
                            labelText:
                                "Please provide email for mportant communication",
                            labelStyle: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),enabledBorder: OutlineInputBorder(
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
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            hintText: "Street#1, Building#4, xyz road",
                            labelText: "Please provide address for pickup",
                            labelStyle: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),enabledBorder: OutlineInputBorder(
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
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            hintText: donorType == "Individual"
                                ? "John Doe"
                                : "xyz Marquee",
                            labelText: donorType == "Individual"
                                ? "Your good name for human identification"
                                : "Representative of the Establishment",
                            labelStyle: TextStyle(
                              color: Theme.of(context).accentColor,
                            ),enabledBorder: OutlineInputBorder(
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
                            setState(
                              () {
                                donorName = value;
                              },
                            );
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
                        setState(() {
                          _loading = true;
                        });
                        Services.registerDonor(
                          User(
                            unreadNotifications: false,
                            isDonor: true,
                            address: donorPickUpAddress,
                            city: donorSelectedCity.name,
                            email: donorEmail,
                            name: donorName,
                            type: donorType,
                            phone: args["phoneNumber"],
                            imageUrl:
                                "https://th.bing.com/th/id/R.773184e334cd743766a32dc04e2a16d0?rik=MiG911OrslrxKw&riu=http%3a%2f%2fgetdrawings.com%2fimg%2fuser-silhouette-icon-24.png&ehk=uDBCWJ%2bbjNhhHpYd%2fNh6WU7crzwVUieff7fGsFRf%2fy4%3d&risl=&pid=ImgRaw",
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
