import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final Widget rightButton;

  Header({
    Key key,
    this.rightButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.only(left: 30, top: 30),
          child: Text(
            "Magic\nthe Gathering",
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 15),
          child: this.rightButton,
        ),
      ],
    );
  }
}
