import 'package:flutter/material.dart';
import 'package:fooddo/classes/donation.dart';
import 'package:fooddo/screens/screen_charity_home.dart';

import '../services.dart';

class DeliveryPersonsAssignment extends StatefulWidget {
  static final routeName = "/deliver-person-assignment";

  @override
  _DeliveryPersonsAssignmentState createState() =>
      _DeliveryPersonsAssignmentState();
}

class _DeliveryPersonsAssignmentState extends State<DeliveryPersonsAssignment> {
  bool _loading;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loading = false;
  }

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments as Map;
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            if (_loading) LinearProgressIndicator(),
            if (Data.deliveryPersons.length == 0)
              Center(
                child: Text("No Delivery Person found for specified area"),
              )
            else
              Container(
                height: MediaQuery.of(context).size.height * 0.88,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: Data.deliveryPersons.length,
                  itemBuilder: (_, index) {
                    return ListTile(
                      leading: Icon(
                        Icons.local_shipping_outlined,
                        size: 40,
                        color: Colors.black,
                      ),
                      title: Text(
                        Data.deliveryPersons[index].name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        "+" + Data.deliveryPersons[index].contact,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Text(
                        "Capacity: " +
                            Data.deliveryPersons[index].vehicleCapacity
                                .toString(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: _loading
                          ? () {}
                          : () async {
                              setState(() {
                                _loading = true;
                              });
                              await Services.assignDeliveryPerson(
                                donation: args["donation"],
                                deliveryPersons: Data.deliveryPersons[index],
                              );
                              setState(() {
                                _loading = false;
                              });
                              Navigator.of(context).pushReplacementNamed(
                                  CharityDashboard.routeName);
                            },
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
