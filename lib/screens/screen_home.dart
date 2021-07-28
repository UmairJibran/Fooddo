import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fooddo/components/screens/home/home.dart';
import 'package:fooddo/components/screens/home/notifications.dart';
import 'package:fooddo/screens/screen_login.dart';

import '../services.dart';
import 'screen_settings.dart';

class Home extends StatefulWidget {
  static final routeName = "/home";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedScreen = 0;
  bool _loading;

  List<Widget> screens;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loading = false;
  }

  @override
  Widget build(BuildContext context) {
    screens = [
      HomeComponent(height: MediaQuery.of(context).size.height),
      NotificationsComponet()
    ];
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Text(
          "Fooddo",
          style: TextStyle(
            fontFamily: "Billabong",
            fontSize: 45,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          InkWell(
            child: Stack(
              children: [
                Center(
                  child: Icon(Icons.notifications, color: Colors.black),
                ),
                if (Data.user.unreadNotifications)
                  Positioned(
                    top: 10,
                    right: 00,
                    child: Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
              ],
            ),
            onTap: () async {
              if (selectedScreen != 1) {
                setState(() {
                  _loading = true;
                });
                if (Data.user.unreadNotifications)
                  await Services.notificationRead();
                await Services.fetchNotifications(Data.userPhone);
                setState(() {
                  selectedScreen = 1;
                  _loading = false;
                });
              }
            },
          ),
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
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            _loading
                ? Container(
                    height: _loading
                        ? MediaQuery.of(context).size.height * 0.8
                        : MediaQuery.of(context).size.height * 0.81,
                    width: MediaQuery.of(context).size.width,
                    child: Center(child: CircularProgressIndicator()))
                : Container(
                    height: _loading
                        ? MediaQuery.of(context).size.height * 0.8
                        : MediaQuery.of(context).size.height * 0.81,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      child: screens[selectedScreen],
                    ),
                  ),
            Container(
              height: _loading
                  ? MediaQuery.of(context).size.height * 0.095
                  : MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).primaryColor,
              child: Row(
                children: [
                  InkWell(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Center(
                        child: Icon(Icons.home, size: 30),
                      ),
                    ),
                    onTap: () async {
                      if (selectedScreen != 0) {
                        setState(() {
                          _loading = true;
                        });
                        await Services.fetchUserPastDonation();
                        setState(() {
                          selectedScreen = 0;
                          _loading = false;
                        });
                      }
                    },
                  ),
                  InkWell(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Center(
                        child: Icon(Icons.phone, size: 30),
                      ),
                    ),
                    onTap: () async {
                      await FlutterPhoneDirectCaller.callNumber("03138185443");
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
