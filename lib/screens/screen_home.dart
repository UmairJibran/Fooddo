import 'package:flutter/material.dart';
import 'package:fooddo/components/screens/home/home.dart';
import 'package:fooddo/components/screens/home/notifications.dart';

class Home extends StatefulWidget {
  static final routeName = "/home";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedScreen = 0;

  List<Widget> screens;

  @override
  Widget build(BuildContext context) {
    screens = [
      HomeComponent(height: MediaQuery.of(context).size.height),
      NotificationsComponet()
    ];
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
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
            onPressed: () {},
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
              child: screens[selectedScreen],
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(),
                  SizedBox(),
                  FlatButton(
                    child: Text(
                      "Home",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedScreen = 0;
                      });
                    },
                  ),
                  SizedBox(),
                  FlatButton(
                    child: Text(
                      "Notifications",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedScreen = 1;
                      });
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
