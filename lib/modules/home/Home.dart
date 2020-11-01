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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFC4A1A), Color(0xFFF7B733)],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: Container(
                  child: Image.asset('assets/forest.png'),
                ),
              ),
              Column(
                children: [
                  Container(
                    child: Text(
                      "Magic the Gathering",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child:
                          Text("aqui vai um texto gigante para entender o q"),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 30, top: 30),
                    child: Center(
                      child: Text(
                        "By Rondinelli Morais",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
