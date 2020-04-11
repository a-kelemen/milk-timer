
import 'package:flutter/material.dart';

Widget timeToCustomFont(String time) {
  List<Widget> rowItems = [];

  for (var i = 0; i < time.length; i++) {
    if (time[i] == ":") {
      rowItems.add(Container(
        padding: EdgeInsets.only(left:5, right:5),
        child: Image(
          image: AssetImage('images/kettospont.png'),
          height: 21,
        ),
      ));
    } else if (["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
        .contains(time[i])) {
      rowItems.add(Container(
        padding: EdgeInsets.only(left:3, right:3),
        child: Image(
          image: AssetImage('images/${time[i]}.png'),
          height: 40,
        ),
      ));
    } else {

      rowItems.add(Text(time[i]));
    }

  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: rowItems);
}