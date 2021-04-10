import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fooddo/components/continuation_button.dart';

class MakeDonation extends StatefulWidget {
  static final String routeName = "/make-donation";

  @override
  _MakeDonationState createState() => _MakeDonationState();
}

class _MakeDonationState extends State<MakeDonation> {
  double _servings = 0;

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
                    _servings.round() > 0
                        ? Positioned(
                            top: 50,
                            right: 30,
                            child: SvgPicture.asset(
                              "./lib/assets/plate_assets/toast.svg",
                              height: 300,
                            ),
                          )
                        : SizedBox(),
                    _servings.round() > 100
                        ? Positioned(
                            top: 80,
                            left: 10,
                            child: SvgPicture.asset(
                              "./lib/assets/plate_assets/salad_leaf.svg",
                              height: 250,
                            ),
                          )
                        : SizedBox(),
                    _servings.round() > 200
                        ? Positioned(
                            top: 50,
                            right: 00,
                            child: SvgPicture.asset(
                              "./lib/assets/plate_assets/meat.svg",
                              height: 300,
                            ),
                          )
                        : SizedBox(),
                    _servings.round() > 300
                        ? Positioned(
                            bottom: 100,
                            left: 20,
                            child: SvgPicture.asset(
                              "./lib/assets/plate_assets/lemon.svg",
                              height: 200,
                            ),
                          )
                        : SizedBox(),
                    _servings.round() > 400
                        ? Positioned(
                            top: 50,
                            left: 80,
                            child: SvgPicture.asset(
                              "./lib/assets/plate_assets/carrot.svg",
                              height: 200,
                            ),
                          )
                        : SizedBox(),
                    _servings.round() > 500
                        ? Positioned(
                            bottom: 10,
                            right: 100,
                            child: SvgPicture.asset(
                              "./lib/assets/plate_assets/pizza.svg",
                              height: 200,
                            ),
                          )
                        : SizedBox(),
                    _servings.round() > 600
                        ? Positioned(
                            top: 10,
                            right: 80,
                            child: SvgPicture.asset(
                              "./lib/assets/plate_assets/lime.svg",
                              height: 200,
                            ),
                          )
                        : SizedBox(),
                    _servings.round() > 700
                        ? Positioned(
                            top: 50,
                            right: 30,
                            child: SvgPicture.asset(
                              "./lib/assets/plate_assets/mushroom.svg",
                              height: 100,
                            ),
                          )
                        : SizedBox(),
                    _servings.round() > 800
                        ? Positioned(
                            top: 30,
                            left: 30,
                            child: SvgPicture.asset(
                              "./lib/assets/plate_assets/chicken_leg.svg",
                              height: 180,
                            ),
                          )
                        : SizedBox(),
                    _servings.round() > 900
                        ? Positioned(
                            bottom: 30,
                            right: 30,
                            child: SvgPicture.asset(
                              "./lib/assets/plate_assets/fried_egg.svg",
                              height: 180,
                            ),
                          )
                        : SizedBox(),
                    _servings.round() >= 1000
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Food Donation for:",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: TextField(
                            enabled: true,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.left,
                            onChanged: (value) {
                              setState(() {
                                if (double.parse(value) > 1000)
                                  _servings = 1000;
                                else
                                  _servings = double.parse(value);
                              });
                            },
                            decoration: InputDecoration(
                              hintText: _servings.round().toString(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Slider(
                    value: _servings,
                    min: 0,
                    max: 1000,
                    divisions: 1000,
                    label: _servings.round().toString(),
                    onChanged: (value) {
                      setState(() {
                        _servings = value;
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ContinuationButton(
                        buttonText: "Continue",
                        onTap: () {},
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
