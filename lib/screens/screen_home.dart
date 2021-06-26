import 'package:flutter/material.dart';
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
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(Settings.routeName);
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await Services.logout();
              await Navigator.of(context).pushReplacementNamed(Login.routeName);
            },
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
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
                      child: Stack(
                        children: [
                          Center(
                            child: Text(
                              "Notifications",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (Data.user.unreadNotifications)
                            Positioned(
                              top: 10,
                              right: 20,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                height: 25,
                                width: 50,
                                child: Center(
                                  child: Text(
                                    "New",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
