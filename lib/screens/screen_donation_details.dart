import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fooddo/classes/donation.dart';
import 'package:url_launcher/url_launcher.dart';

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
  Future<void> _launched;

  @override
  void initState() {
    super.initState();
    updating = false;
  }

  Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return const Text('');
    }
  }

  Future<void> _makePhoneCall(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Map args = ModalRoute.of(context).settings.arguments as Map;
    final Donation donation = args["donation"];
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              "Fooddo",
              style: TextStyle(
                fontFamily: "Billabong",
                fontSize: 45,
                color: Colors.black,
              ),
            ),
            SizedBox(width: 10),
            Text(
              "Charity",
              style: TextStyle(
                fontFamily: "Billabong",
                fontSize: 25,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          if (updating)
            CircularProgressIndicator(
              backgroundColor: Colors.green,
            ),
          Container(
            height: height * 0.365,
            width: width,
            child: ListView.builder(
              itemCount: donation.moreImages.length == 0
                  ? 1
                  : donation.moreImages.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return Image.network(
                  index == 0 ? donation.imgUrl : donation.moreImages[index - 1],
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
            height: height * 0.4,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Details:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
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
                      child: Text(
                        "Donor Contact: ${donation.donorId}",
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        "PickUp Location: ${donation.pickupAddress}",
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Donation Date: ${donation.date}",
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
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
                        onPressed: () async {
                          setState(() {
                            updating = true;
                          });
                          await Services.rejectDonation(donation.id);
                          await Navigator.of(context)
                              .pushNamed(CharityUpdateLoading.routeName);
                        },
                      ),
                    ],
                  )
                else if (donation.status == "accepted")
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlatButton(
                        onPressed: () async {
                          setState(() {
                            updating = true;
                          });
                          await Services.fetchDeliveryPersons(donation.city);
                          setState(() {
                            updating = false;
                          });
                          Navigator.of(context).pushNamed(
                            DeliveryPersonsAssignment.routeName,
                            arguments: {"donation": donation},
                          );
                        },
                        child: Text(
                          "Assign Deliveryperson",
                          style: TextStyle(color: Colors.black),
                        ),
                      )
                    ],
                  )
                else if (donation.status == "collecting")
                  Text(
                    "DeliveryPerson EnRoute",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
              ],
            ),
          ),
          FlatButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("Call Donor"), Icon(Icons.call)],
              ),
              onPressed: () async {
                // _launched = _makePhoneCall("tel:+${donation.donorId}");
                bool res =
                    await FlutterPhoneDirectCaller.callNumber("03120919647");
              }),
          // ),
          // FutureBuilder<void>(future: _launched, builder: _launchStatus),
        ],
      ),
    );
  }
}
