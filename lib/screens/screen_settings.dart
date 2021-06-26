import 'package:flutter/material.dart';
import 'package:fooddo/components/continuation_button.dart';
import 'package:fooddo/services.dart';

class Settings extends StatefulWidget {
  static final routeName = "/settings";

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool changesMade;
  bool updating;
  var _key;
  String _userName, _userEmail, _userAddress;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _key = GlobalKey<FormState>();
    _userName = Data.user.name;
    _userEmail = Data.user.email;
    _userAddress = Data.user.address;
    changesMade = false;
    updating = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Fooddo",
          style: TextStyle(
            fontFamily: "Billabong",
            fontSize: 45,
            color: Colors.black,
          ),
        ),
        actions: [
          changesMade
              ? IconButton(
                  icon: Icon(
                    Icons.check,
                    color: Colors.black,
                  ),
                  onPressed: () async {
                    if (_userName != Data.user.name ||
                        _userAddress != Data.user.address ||
                        _userEmail != Data.user.email) {
                      if (_key.currentState.validate()) {
                        setState(() {
                          updating = true;
                        });
                        _key.currentState.save();
                        await Services.updateUser(
                          name: _userName,
                          address: _userAddress,
                          email: _userEmail,
                        );
                        setState(() {
                          updating = false;
                          changesMade = false;
                        });
                      }
                    }
                  },
                )
              : SizedBox(),
        ],
      ),
      body: updating
          ? CircularProgressIndicator(
              backgroundColor: Colors.green,
            )
          : Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                  child: Form(
                    key: _key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Update Profile",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        TextFormField(
                          initialValue: _userName,
                          decoration: InputDecoration(
                            hintText: "Enter your name",
                          ),
                          validator: (value) {
                            if (value.isEmpty)
                              return "Name Can not be empty";
                            else
                              return null;
                          },
                          onChanged: (value) {
                            setState(
                              () {
                                changesMade = true;
                                _userName = value;
                              },
                            );
                          },
                        ),
                        TextFormField(
                          initialValue: _userAddress,
                          decoration: InputDecoration(
                            hintText: "Enter your address",
                          ),
                          validator: (value) {
                            if (value.isEmpty)
                              return "Address Can not be empty";
                            else
                              return null;
                          },
                          onChanged: (value) {
                            setState(
                              () {
                                changesMade = true;
                                _userAddress = value;
                              },
                            );
                          },
                        ),
                        TextFormField(
                          initialValue: _userEmail,
                          decoration: InputDecoration(
                            hintText: "Enter your email",
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value.isEmpty)
                              return "Email Can not be empty";
                            else
                              return null;
                          },
                          onChanged: (value) {
                            setState(
                              () {
                                changesMade = true;
                                _userEmail = value;
                              },
                            );
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ContinuationButton(
                              buttonText: "Update",
                              onTap: () async {
                                if (_userName != Data.user.name ||
                                    _userAddress != Data.user.address ||
                                    _userEmail != Data.user.email) {
                                  if (_key.currentState.validate()) {
                                    setState(() {
                                      updating = true;
                                    });
                                    _key.currentState.save();
                                    await Services.updateUser(
                                      name: _userName,
                                      address: _userAddress,
                                      email: _userEmail,
                                    );
                                    setState(() {
                                      updating = false;
                                      changesMade = false;
                                    });
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
