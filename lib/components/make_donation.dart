import 'package:flutter/material.dart';
import 'package:fooddo/screens/screen_make_donation.dart';

class AddDonation extends StatelessWidget {
  final double height;

  const AddDonation({Key key, this.height}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        Navigator.of(context).pushNamed(MakeDonation.routeName);
      },
      child: Container(
        margin: EdgeInsets.only(top: 20, bottom: 10, right: 20, left: 20),
        padding: EdgeInsets.all(20),
        height: height * 0.25,
        width: MediaQuery.of(context).size.width * 0.38,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            new BoxShadow(
              blurRadius: 20,
              color: Colors.grey[400],
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.add, size: 40),
            SizedBox(width: 10),
            Text(
              "Make Donation!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
