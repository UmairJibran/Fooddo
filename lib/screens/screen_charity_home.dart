import 'package:flutter/material.dart';
import 'package:fooddo/classes/donation.dart';
import 'package:fooddo/components/charity_food_card.dart';

import '../services.dart';
import 'screen_charity_accepted.dart';
import 'screen_charity_rejected.dart';
import 'screen_charity_completed.dart';
import 'screen_charity_update_loading.dart';
import 'screen_settings.dart';

class CharityDashboard extends StatefulWidget {
  static final routeName = "/charity-dashboard";

  @override
  _CharityDashboardState createState() => _CharityDashboardState();
}

class _CharityDashboardState extends State<CharityDashboard> {
  bool loading;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Center(
                child: Text(
                  "Fooddo!",
                  style: TextStyle(
                    fontFamily: "Billabong",
                    fontSize: 70,
                  ),
                ),
              ),
            ),
            FlatButton(
              child: Text("Accepted Donation"),
              onPressed: () async {
                setState(() {
                  loading = true;
                });
                await Services.fetchAcceptedDonations();
                setState(() {
                  loading = false;
                });
                Navigator.pushNamed(context, CharityAccepted.routeName);
              },
            ),
            Divider(),
            FlatButton(
              child: Text("Rejected Donation"),
              onPressed: () async {
                setState(() {
                  loading = true;
                });
                await Services.fetchRejectedDonations();
                setState(() {
                  loading = false;
                });
                Navigator.pushNamed(context, CharityRejected.routeName);
              },
            ),
            Divider(),
            FlatButton(
              child: Text("Completed Donation"),
              onPressed: () async {
                setState(() {
                  loading = true;
                });
                await Services.fetchCompletedDonations();
                setState(() {
                  loading = false;
                });
                Navigator.pushNamed(context, CharityCompleted.routeName);
              },
            ),
            Divider(),
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Center(
                child: (loading) ? CircularProgressIndicator() : SizedBox(),
              ),
            ),
          ],
        ),
      ),
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
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(Settings.routeName);
            },
          ),
        ],
      ),
      body: Container(
        height: height,
        child: ListView.builder(
          itemBuilder: (BuildContext context, index) {
            return index == 0
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed(
                          (CharityUpdateLoading.routeName),
                        );
                      },
                      child: Text(
                        "Refresh",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                : CharityFoodCard(
                    donation: new Donation(
                      id: Data.unclaimedDonations[index - 1].id,
                      date: Data.unclaimedDonations[index - 1].date,
                      serving: Data.unclaimedDonations[index - 1].serving,
                      imgUrl: Data.unclaimedDonations[index - 1].imgUrl,
                      status: Data.unclaimedDonations[index - 1].status,
                      recepient: Data.unclaimedDonations[index - 1].recepient,
                      donorId: Data.unclaimedDonations[index - 1].donorId,
                      pickupAddress:
                          Data.unclaimedDonations[index - 1].pickupAddress,
                      waitingTime:
                          Data.unclaimedDonations[index - 1].waitingTime,
                    ),
                    height: height * 0.25,
                  );
          },
          itemCount: Data.unclaimedDonations.length + 1,
        ),
      ),
    );
  }
}
