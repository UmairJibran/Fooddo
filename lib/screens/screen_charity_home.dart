import 'package:flutter/material.dart';
import 'package:fooddo/components/screens/charity_home/home.dart';
import 'package:fooddo/components/screens/charity_home/notifications.dart';

import '../services.dart';
import 'screen_charity_accepted.dart';
import 'screen_charity_rejected.dart';
import 'screen_charity_completed.dart';
import 'screen_settings.dart';

class CharityDashboard extends StatefulWidget {
  static final routeName = "/charity-dashboard";

  @override
  _CharityDashboardState createState() => _CharityDashboardState();
}

class _CharityDashboardState extends State<CharityDashboard> {
  int selectedScreen = 0;
  bool loading;
  List<Widget> screens;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    screens = [
      ChairyHomeComponent(height: MediaQuery.of(context).size.height),
      CharityNotificationsComponent()
    ];
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
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.794,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: screens[selectedScreen],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).primaryColor,
              child: Row(
                children: [
                  InkWell(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Center(
                        child: Text(
                          "Home",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      if (selectedScreen != 0)
                        setState(() {
                          selectedScreen = 0;
                        });
                    },
                  ),
                  InkWell(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Center(
                        child: Text(
                          "Notifications",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      if (selectedScreen != 1)
                        setState(() {
                          selectedScreen = 1;
                        });
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
