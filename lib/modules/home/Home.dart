import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  static const platform = const MethodChannel('magicgathering/bridge');

  @override
  void initState() {
    super.initState();
  }

  void startUnityActivity() {
    platform.invokeMethod('startUnityActivity');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Home renderizada"),
              FlatButton(
                child: Text("touch me"),
                onPressed: startUnityActivity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
