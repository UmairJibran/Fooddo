import 'package:flutter/material.dart';
import 'package:fooddo/components/screens/home/home.dart';
import 'package:fooddo/components/screens/home/notifications.dart';

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
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            if (_loading) LinearProgressIndicator(),
            Container(
              height: _loading
                  ? MediaQuery.of(context).size.height * 0.782
                  : MediaQuery.of(context).size.height * 0.784,
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
                    onTap: () async {
                      if (selectedScreen != 1) {
                        setState(() {
                          _loading = true;
                        });
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
