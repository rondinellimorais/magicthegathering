import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:magic_gathering/components/Background.dart';
import 'package:magic_gathering/components/Footer.dart';
import 'package:magic_gathering/components/Header.dart';
import 'package:magic_gathering/components/MagicCarousel.dart';
import 'package:magic_gathering/model/MagicCard.dart';
import 'package:magic_gathering/services/MagicCardService.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  static const platform = const MethodChannel('magicgathering/bridge');
  List<String> _imgList = List<String>();
  List<MagicCard> cards;

  @override
  void initState() {
    super.initState();
    loadMagicCards();
  }

  void loadMagicCards() async {
    cards = await new MagicCardService().cards();
    List<String> imgList = List<String>();
    for (var card in cards) {
      if (card.imageUrl != null) {
        imgList.add(card.imageUrl);
      }
    }

    setState(() {
      _imgList = imgList;
    });
  }

  void startUnityActivity() async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {}

    if (defaultTargetPlatform == TargetPlatform.android) {
      List<String> cardsBase64Image = List<String>();
      for (var card in cards) {
        if (card.imageUrl != null) {
          cardsBase64Image.add(await card.toBase64());
        }
      }
      platform.invokeMethod('startUnityActivity', cardsBase64Image);
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
              MagicCarousel(images: _imgList),
              Footer(),
            ],
          ),
        ],
      ),
    );
  }
}
