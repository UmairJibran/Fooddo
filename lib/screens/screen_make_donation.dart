import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fooddo/components/continuation_button.dart';
import 'package:fooddo/screens/screen_confirm_donation.dart';

class MakeDonation extends StatefulWidget {
  static final String routeName = "/make-donation";

  @override
  _MakeDonationState createState() => _MakeDonationState();
}

class _MakeDonationState extends State<MakeDonation> {
  TextEditingController _servings = new TextEditingController();

  @override
  void initState() {
    _servings.text = "20";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Fooddo",
          style: TextStyle(
            fontFamily: "Billabong",
            fontSize: 35,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                child: Stack(
                  children: [
                    SvgPicture.asset(
                      "./lib/assets/plate_assets/empty_plate.svg",
                      height: 400,
                    ),
                    double.parse(_servings.text).round() > 0
                        ? Positioned(
                            top: 50,
                            right: 30,
                            child: SvgPicture.asset(
                              "./lib/assets/plate_assets/toast.svg",
                              height: 300,
                            ),
                          )
                        : SizedBox(),
                    double.parse(_servings.text).round() > 10
                        ? Positioned(
                            top: 80,
                            left: 10,
                            child: SvgPicture.asset(
                              "./lib/assets/plate_assets/salad_leaf.svg",
                              height: 250,
                            ),
                          )
                        : SizedBox(),
                    double.parse(_servings.text).round() > 20
                        ? Positioned(
                            top: 50,
                            right: 00,
                            child: SvgPicture.asset(
                              "./lib/assets/plate_assets/meat.svg",
                              height: 300,
                            ),
                          )
                        : SizedBox(),
                    double.parse(_servings.text).round() > 30
                        ? Positioned(
                            bottom: 100,
                            left: 20,
                            child: SvgPicture.asset(
                              "./lib/assets/plate_assets/lemon.svg",
                              height: 200,
                            ),
                          )
                        : SizedBox(),
                    double.parse(_servings.text).round() > 40
                        ? Positioned(
                            top: 50,
                            left: 80,
                            child: SvgPicture.asset(
                              "./lib/assets/plate_assets/carrot.svg",
                              height: 200,
                            ),
                          )
                        : SizedBox(),
                    double.parse(_servings.text).round() > 50
                        ? Positioned(
                            bottom: 10,
                            right: 100,
                            child: SvgPicture.asset(
                              "./lib/assets/plate_assets/pizza.svg",
                              height: 200,
                            ),
                          )
                        : SizedBox(),
                    double.parse(_servings.text).round() > 60
                        ? Positioned(
                            top: 10,
                            right: 80,
                            child: SvgPicture.asset(
                              "./lib/assets/plate_assets/lime.svg",
                              height: 200,
                            ),
                          )
                        : SizedBox(),
                    double.parse(_servings.text).round() > 70
                        ? Positioned(
                            top: 50,
                            right: 30,
                            child: SvgPicture.asset(
                              "./lib/assets/plate_assets/mushroom.svg",
                              height: 100,
                            ),
                          )
                        : SizedBox(),
                    double.parse(_servings.text).round() > 80
                        ? Positioned(
                            top: 30,
                            left: 30,
                            child: SvgPicture.asset(
                              "./lib/assets/plate_assets/chicken_leg.svg",
                              height: 180,
                            ),
                          )
                        : SizedBox(),
                    double.parse(_servings.text).round() > 90
                        ? Positioned(
                            bottom: 30,
                            right: 30,
                            child: SvgPicture.asset(
                              "./lib/assets/plate_assets/fried_egg.svg",
                              height: 180,
                            ),
                          )
                        : SizedBox(),
                    double.parse(_servings.text).round() >= 100
                        ? Positioned(
                            bottom: 80,
                            right: 50,
                            child: SvgPicture.asset(
                              "./lib/assets/plate_assets/coriander.svg",
                              height: 250,
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Text(
                          "Food Donation for:",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          child: TextField(
                            controller: _servings,
                            enabled: true,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              hintText: double.parse(_servings.text)
                                  .round()
                                  .toString(),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "People",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Slider(
                    value: double.parse(_servings.text) > 100
                        ? 100
                        : double.parse(_servings.text),
                    min: 0,
                    max: 100,
                    divisions: 100,
                    label: double.parse(_servings.text).round().toString(),
                    onChanged: (value) {
                      setState(() {
                        _servings.text = value.round().toString();
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ContinuationButton(
                        buttonText: "Continue",
                        onTap: () {
                          if (double.parse(_servings.text).round() > 1)
                            Navigator.of(context).pushNamed(
                                ConfirmDonation.routeName,
                              arguments: {
                                "servings": double.parse(_servings.text)
                              },
                            );
                        },
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
