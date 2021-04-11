import 'package:flutter/material.dart';

class FoodCardTile extends StatelessWidget {
  final String date;
  final String imgUrl;
  final int serving;
  final String status;
  final double height;
  final String recepient;
  FoodCardTile({
    this.date,
    this.imgUrl,
    this.serving,
    this.status,
    this.height,
    this.recepient,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: EdgeInsets.all(20),
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
        children: [
          Container(
            height: height * 0.78,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(imgUrl)),
          ),
          SizedBox(width: 10),
          Container(
            height: height * 0.7,
            width: MediaQuery.of(context).size.width * 0.38,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Served",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      status == Status.delivered
                          ? Icons.check
                          : Icons.query_builder,
                      color: status == Status.delivered
                          ? Colors.greenAccent
                          : Colors.indigo,
                    ),
                  ],
                ),
                Text(
                  "$serving People",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  "at $recepient",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "on $date",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
