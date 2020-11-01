import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:magic_gathering/components/Background.dart';
import 'package:magic_gathering/components/Footer.dart';
import 'package:magic_gathering/components/Header.dart';
import 'package:magic_gathering/components/MagicCarousel.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  static const platform = const MethodChannel('magicgathering/bridge');
  final List<String> imgList = [
    'https://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=147651&type=card',
    'https://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=149554&type=card',
    'https://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=147653&type=card',
    'https://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=147652&type=card',
    'https://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=147649&type=card',
    'https://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=147647&type=card',
    'https://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=147646&type=card',
    'https://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=147641&type=card',
  ];

  @override
  void initState() {
    super.initState();
  }

  void startUnityActivity() {
    if (defaultTargetPlatform == TargetPlatform.iOS) {}

    print("veio aqui");
    print(defaultTargetPlatform);
    if (defaultTargetPlatform == TargetPlatform.android) {
      platform.invokeMethod('startUnityActivity');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        colors: [Color(0xFFFC4A1A), Color(0xFFF7B733)],
        pageBottomImage: Image.asset('assets/forest.png'),
        children: [
          Column(
            children: [
              Header(
                rightButton: FlatButton(
                  child: Image.asset("assets/camera.png"),
                  onPressed: startUnityActivity,
                ),
              ),
              MagicCarousel(images: imgList),
              Footer(),
            ],
          ),
        ],
      ),
    );
  }
}
