import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fooddo/classes/donation.dart';

import '../services.dart';
import 'screen_charity_delivery_person_select.dart';
import 'screen_charity_update_loading.dart';

class DonationDetails extends StatefulWidget {
  static final routeName = "/donation-deatil";

  @override
  _DonationDetailsState createState() => _DonationDetailsState();
}

class _DonationDetailsState extends State<DonationDetails> {
  bool updating;

  @override
  void initState() {
    super.initState();
    updating = false;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Map args = ModalRoute.of(context).settings.arguments as Map;
    final Donation donation = args["donation"];
    final String donationType = args["donationType"];
    final date = new DateTime.fromMicrosecondsSinceEpoch(
        donation.timeStamp.microsecondsSinceEpoch);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              "$donationType Donation",
              style: TextStyle(
                fontFamily: "Billabong",
                fontSize: 45,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Container(
                height: height * 0.365,
                width: width,
                child: ListView.builder(
                  itemCount: donation.moreImages.length == 0
                      ? 1
                      : donation.moreImages.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    return donation.imgUrl == null
                        ? Container(
                            child: Icon(Icons.broken_image),
                          )
                        : Image.network(
                            index == 0
                                ? donation.imgUrl
                                : donation.moreImages[index - 1],
                            height: height * 0.365,
                            width: width,
                            fit: BoxFit.cover,
                          );
                  },
                ),
              ),
              // Container(
              //   color: Color(0xffEBF4FF),
              //   height: height * 0.0,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: <Widget>[
              //       Text(
              //         "Waiting Time: ${donation.waitingTime} Minutes",
              //         style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 20,
              //           color: Colors.black,
              //         ),
              //       ),
              //       SizedBox(width: 10),
              //       Icon(Icons.timer, size: 20, color: Colors.black),
              //     ],
              //   ),
              // ),
              Container(
                color: Color(0xffEBF4FF),
                height: height * 0.065,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Serves ${donation.serving} People",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.people_outline, size: 20, color: Colors.black),
                  ],
                ),
              ),
              Container(
                width: width * 0.9,
                height: height * 0.35,
                margin: EdgeInsets.only(
                  top: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    const BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: height * 0.2,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Details:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                ),
                                Spacer(),
                                if (donation.status == "completed")
                                  Icon(
                                    Icons.done_all_outlined,
                                    color: Colors.blue[700],
                                    size: 30,
                                  )
                                else if (donation.status == "waiting")
                                  Icon(
                                    Icons.schedule_outlined,
                                    color: Colors.indigo,
                                    size: 30,
                                  )
                                else if (donation.status == "accepted")
                                  Icon(
                                    Icons.check,
                                    color: Colors.green,
                                    size: 30,
                                  )
                                else if (donation.status == "rejected")
                                  Icon(
                                    Icons.close,
                                    color: Colors.red,
                                    size: 30,
                                  )
                                else if (donation.status == "collecting")
                                  Icon(
                                    Icons.local_shipping_outlined,
                                    color: Colors.cyan,
                                  )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: RichText(
                                text: TextSpan(
                                  text: "Donor: ",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: donation.donorName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: RichText(
                                text: TextSpan(
                                  text: "Donor Contact: ",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: donation.donorId,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: RichText(
                                text: TextSpan(
                                  text: "Recepient Charity: ",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: donation.recepient,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: RichText(
                                text: TextSpan(
                                  text: "PickUp Location: ",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: donation.pickupAddress,
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: RichText(
                                text: TextSpan(
                                  text: "Donation Time: ",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: date.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (donation.status == "waiting")
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FlatButton(
                            child: Text(
                              "Accept",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            color: Colors.green,
                            onPressed: () async {
                              setState(() {
                                updating = true;
                              });
                              await Services.acceptDonation(donation.id);
                              donation.status = "accepted";
                              await Navigator.of(context).pushReplacementNamed(
                                  DonationDetails.routeName,
                                  arguments: {"donation": donation});
                            },
                          ),
                          FlatButton(
                            child: Text(
                              "Reject",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            color: Colors.red,
                            onPressed: () {
                              return showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  content: Text(
                                    "Are you sure you want to reject?",
                                  ),
                                  actions: [
                                    FlatButton(
                                      child: Text("Yes"),
                                      onPressed: () async {
                                        setState(() {
                                          updating = true;
                                        });
                                        Navigator.pop(context);
                                        await Services.rejectDonation(
                                            donation.id);
                                        await Navigator.of(context).pushNamed(
                                            CharityUpdateLoading.routeName);
                                        setState(() {
                                          updating = false;
                                        });
                                      },
                                    ),
                                    FlatButton(
                                      child: Text("No"),
                                      onPressed: () async {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      )
                    else if (donation.status == "accepted")
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                updating = true;
                              });
                              await Services.fetchDeliveryPersons(
                                donation.city,
                                donation.serving,
                              );
                              setState(() {
                                updating = false;
                              });
                              Navigator.of(context).pushNamed(
                                DeliveryPersonsAssignment.routeName,
                                arguments: {"donation": donation},
                              );
                            },
                            child: Text("Assign Deliveryperson"),
                          )
                        ],
                      )
                    else if (donation.status == "collecting")
                      Text(
                        "${donation.deliveryPersonName} EnRoute",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                  ],
                ),
              ),
              Row(
                children: [
                  Spacer(),
                  donation.deliveryPersonContact == null
                      ? SizedBox()
                      : RaisedButton(
                          color: Colors.blue,
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Call ${donation.deliveryPersonName}",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Icon(Icons.call, color: Colors.white)
                              ],
                            ),
                          ),
                          onPressed: () async {
                            bool res =
                                await FlutterPhoneDirectCaller.callNumber(
                              donation.deliveryPersonContact,
                            );
                          },
                        ),
                  Spacer(flex: 2),
                  RaisedButton(
                    color: Colors.blue,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Call Donor",
                            style: TextStyle(color: Colors.white),
                          ),
                          Icon(Icons.call, color: Colors.white)
                        ],
                      ),
                    ),
                    onPressed: () async {
                      bool res = await FlutterPhoneDirectCaller.callNumber(
                        donation.donorId,
                      );
                    },
                  ),
                  Spacer(),
                ],
              ),
            ],
          ),
          if (updating)
            Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.green,
              ),
            ),
        ],
      ),
    );
  }
}
