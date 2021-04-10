import 'package:flutter/material.dart';
import 'package:fooddo/classes/city.dart';
import 'package:fooddo/components/continuation_button.dart';

class RegisterAsDonor extends StatefulWidget {
  static final routeName = "/register";

  @override
  _RegisterAsDonorState createState() => _RegisterAsDonorState();
}

class _RegisterAsDonorState extends State<RegisterAsDonor> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                    child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "mail@example.com",
                        helperText:
                            "Please provide email for mportant communication",
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        setState(() {
                          donorEmail = value;
                        });
                      },
                      validator: (value) {
                        return null;
                      },
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
                      onChanged: (value) {
                        setState(() {
                          donorName = value;
                        });
                      },
                      validator: (value) {
                        return null;
                      },
                    ),
                  ],
                ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ContinuationButton(
                  buttonText: "Continue",
                  onTap: () {},
                ),
              ],
            ),
            SizedBox(),
          ],
        ),
      ),
    );
  }
}
