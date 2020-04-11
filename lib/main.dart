import 'dart:async';
import 'package:flutter/material.dart';
import 'drawings.dart';
import 'history.dart';
import 'shared/sharedPrefs.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    precacheImage(new AssetImage('images/cumi_0.png'), context);
    precacheImage(new AssetImage('images/cumi_1.png'), context);
    precacheImage(new AssetImage('images/cumi_2.png'), context);
    precacheImage(new AssetImage('images/cumi_3.png'), context);
    return MaterialApp(
      title: 'Milk timer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Milk timer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  int counter = -1;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Timer timer;
  bool _buttonPressed = false;
  bool _loopActive = false;

  String _lastTime = "_";
  void checkForNewSharedLists() {
    setState(() {
      if (widget.counter >= 5 && !_buttonPressed) {
        widget.counter -= 5;
        SharedPrefs.setCounterValue(widget.counter.toDouble());
      }
    });
  }

  void initState() {
    SharedPrefs.getCounterValue().then((double val) {
      setState(() {
        widget.counter = val.toInt();
      });
    });
    super.initState();

    timer = Timer.periodic(
        //Duration(seconds: 3600), (Timer t) => checkForNewSharedLists());
        Duration(seconds: 10),
        (Timer t) => checkForNewSharedLists());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void _increaseCounterWhilePressed() async {
    if (_loopActive) return;

    _loopActive = true;

    while (_buttonPressed) {
      setState(() {
        if (widget.counter < 40) {
          widget.counter++;
          SharedPrefs.setCounterValue(widget.counter.toDouble());
        }
      });

      await Future.delayed(Duration(milliseconds: 200));
    }

    _loopActive = false;
  }

  String getTimeString() {
    SharedPrefs.getTimeValues().then((value) {
      setState(() {
        _lastTime = value.last.toString();
      });
    });
    if (_lastTime.length >= 16) {
      return _lastTime.substring(11, 16);
    }
    return "";
  }

  String getSide() {
    SharedPrefs.getTimeValues().then((value) {
      setState(() {
        _lastTime = value.last.toString();
      });
    });
    if (_lastTime.length >= 16) {
      return _lastTime.substring(_lastTime.length - 1, _lastTime.length);
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
                child: Listener(
                  onPointerDown: (details) {
                    _buttonPressed = true;
                    _increaseCounterWhilePressed();
                  },
                  onPointerUp: (details) {
                    _buttonPressed = false;
                    if (widget.counter > 30) {
                      setState(() {
                        widget.counter = 40;
                        SharedPrefs.setCounterValue(widget.counter.toDouble());
                      });
                    }

                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Color(0xFF303030),
                          content: Container(
                            padding: EdgeInsets.only(top: 30),
                            height: 400,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(bottom: 50),
                                  child: GestureDetector(
                                    child: Row(children: <Widget>[
                                      Container(
                                          padding: EdgeInsets.only(
                                              right: 10, left: 20),
                                          child: Image(
                                            image:
                                                AssetImage('images/nipple.png'),
                                            height: 30,
                                          )),
                                      Image(
                                        image: AssetImage('images/left.png'),
                                        height: 60,
                                      )
                                    ]),
                                    onTap: () {
                                      SharedPrefs.addTimeValue(
                                          DateTime.now().toString() + "--l");
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(bottom: 50),
                                  child: GestureDetector(
                                    //color: Colors.transparent,
                                    child: Row(children: <Widget>[
                                      Container(
                                          padding: EdgeInsets.only(
                                              right: 10, left: 20),
                                          child: Image(
                                            image:
                                                AssetImage('images/nipple.png'),
                                            height: 30,
                                          )),
                                      Image(
                                        image: AssetImage('images/right.png'),
                                        height: 60,
                                      )
                                    ]),
                                    onTap: () {
                                      SharedPrefs.addTimeValue(
                                          DateTime.now().toString() + "--r");
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
                                      padding: EdgeInsets.only(
                                          bottom: 10, right: 10),
                                      child: Image(
                                        image: AssetImage('images/nyil.png'),
                                        height: 30,
                                      )),
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
                  child: Container(
                    decoration: BoxDecoration(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        AnimatedContainer(
                            padding: EdgeInsets.only(top: 30),
                            duration: const Duration(seconds: 1),
                            //vsync: this,
                            child: widget.counter != null && widget.counter < 10
                                ? Image(
                                    image: AssetImage('images/cumi_0.png'),
                                    height: 370,
                                  )
                                : widget.counter != null && widget.counter < 20
                                    ? Image(
                                        image: AssetImage('images/cumi_1.png'),
                                        height: 370,
                                      )
                                    : widget.counter != null &&
                                            widget.counter < 30
                                        ? Image(
                                            image:
                                                AssetImage('images/cumi_2.png'),
                                            height: 370,
                                          )
                                        : widget.counter != null &&
                                                widget.counter <= 40
                                            ? Image(
                                                image: AssetImage(
                                                    'images/cumi_3.png'),
                                                height: 370,
                                              )
                                            : Text("")),
                        Container(
                            padding: EdgeInsets.only(top: 50, bottom: 10),
                            child: timeToCustomFont(getTimeString())),
                      ],
                    ),
                  ),
                ),
                onTap: () {}),
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              child: getSide() == "l"
                  ? Container(
                      child: Image(
                        image: AssetImage('images/boob_left.png'),
                        height: 200,
                      ),
                    )
                  : Container(
                      child: Image(
                        image: AssetImage('images/boob_right.png'),
                        height: 200,
                      ),
                    ),
            ),
            GestureDetector(
              child: Container(
                height: 30,
                color: Colors.black,
                padding: EdgeInsets.only(bottom: 10, right: 10),
                child: Text("HISTORY",
                    style: TextStyle(
                        //color: Styles.primaryColor,
                        fontWeight: FontWeight.w300)),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return History();
                }));
              },
            )
          ],
        ),
      ),
    );
  }
}
