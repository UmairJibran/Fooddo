import 'package:flutter/material.dart';
import 'package:fooddo/classes/donation.dart';
import 'package:fooddo/components/charity_food_card.dart';

import 'screen_login.dart';
import '../services.dart';
import 'screen_charity_accepted.dart';
import 'screen_charity_rejected.dart';
import 'screen_charity_completed.dart';
import 'screen_charity_en_route.dart';
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
              color: Theme.of(context).primaryColor,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Fooddo!",
                      style: TextStyle(
                        fontFamily: "Billabong",
                        fontSize: 70,
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
            ),
            FlatButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Accepted Donation"),
                  SizedBox(width: 10),
                  Icon(Icons.check),
                ],
              ),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Rejected Donation"),
                  SizedBox(width: 10),
                  Icon(Icons.close),
                ],
              ),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Completed Donation"),
                  SizedBox(width: 10),
                  Icon(Icons.done_all_outlined),
                ],
              ),
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
            FlatButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("EnRoute Donation"),
                  SizedBox(width: 10),
                  Icon(Icons.delivery_dining),
                ],
              ),
              onPressed: () async {
                setState(() {
                  loading = true;
                });
                await Services.fetchEnRouteDonations();
                setState(() {
                  loading = false;
                });
                Navigator.pushNamed(context, CharityEnRoute.routeName);
              },
            ),
            Divider(),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
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
          PopupMenuButton<Choice>(
            onSelected: (Choice choice) async {
              switch (choice.action) {
                case "logout":
                  {
                    await Services.logout();
                    await Navigator.of(context)
                        .pushReplacementNamed(Login.routeName);
                    break;
                  }
                case "update":
                  {
                    Navigator.of(context).pushNamed(Settings.routeName);
                    break;
                  }
              }
            },
            itemBuilder: (BuildContext context) {
              return choices.map((Choice choice) {
                return PopupMenuItem<Choice>(
                  value: choice,
                  child: Row(
                    children: [
                      Icon(choice.icon),
                      SizedBox(width: 10),
                      Text(choice.title),
                    ],
                  ),
                );
              }).toList();
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
                    donation: Data.unclaimedDonations[index - 1],
                    height: height * 0.25,
                    donationType: "New",
                  );
          },
          itemCount: Data.unclaimedDonations.length + 1,
        ),
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon, this.action});

  final String title;
  final IconData icon;
  final String action;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Update Profile', icon: Icons.settings, action: "update"),
  const Choice(title: 'LogOut', icon: Icons.logout, action: "logout")
];
