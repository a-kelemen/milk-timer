import 'package:flutter/material.dart';

import 'drawings.dart';
import 'shared/sharedPrefs.dart';

class History extends StatefulWidget {
  History({Key key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<String> _times = [];

  @override
  void initState() {
    super.initState();
    SharedPrefs.getTimeValues().then((value) {
      setState(() {
        _times = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: printTimes(_times),
            ),
            GestureDetector(
              child: Container(
                color: Colors.red,
                padding: EdgeInsets.only(bottom: 10, right: 10),
                child: Text("Clear",
                    style: TextStyle(
                        //color: Styles.primaryColor,
                        fontWeight: FontWeight.w300)),
              ),
              onTap: () {
                SharedPrefs.clearHistory();
              },
            )
          ],
        ),
      ),
    );
  }

  List<Widget> printTimes(times) {
    List<String> days = [];
    List<Widget> wList = [];
    String day;
    String hour;
    String side;

    for (String time in times.reversed.toList()) {
      side = time.substring(time.length - 1, time.length - 0);
      String shortTime = time.split(".")[0];
      day = shortTime.split(" ")[0];
      hour = shortTime.split(" ")[1];
      if (days.contains(day)) {
      } else {
        wList.add(timeToCustomFont(day));
        days.add(day);
      }

      wList.add(Row(
        children: <Widget>[
          GestureDetector(
              onLongPress: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      //title: Text('Reset settings?'),
                      //backgroundColor: Styles.backgroundColor,
                      content: Container(
                        padding: EdgeInsets.only(top: 30),
                        height: 400,
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(bottom: 50),
                              child: GestureDetector(
                                //color: Colors.transparent,
                                child: Row(children: <Widget>[
                                  Container(
                                    padding:
                                        EdgeInsets.only(right: 10, left: 20),
                                    child: Icon(
                                      Icons.edit,
                                      //color: Styles.primaryColor,
                                    ),
                                  ),
                                  Text(
                                    'DELETE',
                                    //style:Styles.dialogButtonStyle
                                  ),
                                ]),
                                onTap: () {
                                  //Navigator.of(context).pop(ConfirmAction.CANCEL);

                                  var a = SharedPrefs.deleteTime(time);

                                  a.then((bool value) {
                                    SharedPrefs.getTimeValues().then((value) {
                                      setState(() {
                                        _times = value;
                                      });
                                    });
                                  });

                                  //isSavedSettingsVisible = false;
                                  //isInfoVisible = false;
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        Row(
                          children: <Widget>[
                            GestureDetector(
                              child: Container(
                                padding: EdgeInsets.only(bottom: 10, right: 10),
                                child: Text("CANCEL",
                                    style: TextStyle(
                                        //color: Styles.primaryColor,
                                        fontWeight: FontWeight.w300)),
                              ),
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        )
                      ],
                    );
                  },
                );
              },
              child: timeToCustomFont(hour.substring(0, hour.length - 3))),
          Text(side),
        ],
      ));
    }
    return wList;
  }
}
