import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ContinuationButton extends StatelessWidget {
  final Function onTap;
  final String buttonText;

  const ContinuationButton({Key key, this.onTap, this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey,
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.blue[300],
            border: Border.all(
              color: Colors.black12,
              width: 0.8,
            ),
          ),
          child: Text(
            buttonText.isNotEmpty ? buttonText : "Continue",
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
      ),
    );
  }
}
