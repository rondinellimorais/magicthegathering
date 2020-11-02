import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:magic_gathering/components/Background.dart';
import 'package:magic_gathering/components/Footer.dart';
import 'package:magic_gathering/components/Header.dart';
import 'package:magic_gathering/components/MagicCarousel.dart';
import 'package:magic_gathering/components/ProgressAlertDialog.dart';
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
  List<String> _cardsBase64Image = List<String>();
  List<MagicCard> cards;
  ProgressAlertDialog progressAlertDialog;

  @override
  void initState() {
    super.initState();
    loadMagicCards();
  }

  void loadMagicCards() async {
    cards = await new MagicCardService().cards();
    List<String> imgList = List<String>();

    print(cards.length);

    for (var card
        in cards.where((element) => element.imageUrl != null).toList()) {
      imgList.add(card.imageUrl);
    }

    setState(() {
      _imgList = imgList;
    });
  }

  void prepareImageAssets() async {
    if (_cardsBase64Image.isEmpty) {
      progressAlertDialog = new ProgressAlertDialog();
      showDialog(
        context: context,
        builder: (BuildContext context) => progressAlertDialog,
      );
      await cardsBase64Image();
    }
    startUnityActivity();
  }

  void startUnityActivity() async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      // disponível apenas para android sorry :(
    }

    if (defaultTargetPlatform == TargetPlatform.android) {
      platform.invokeMethod('startUnityActivity');
    }
  }

  Future<void> cardsBase64Image() async {
    var filteredCards =
        cards.where((element) => element.imageUrl != null).toList();
    for (var card in filteredCards) {
      _cardsBase64Image.add(await card.toBase64());
      progressAlertDialog.updatePercentProgress(
        percentProgress(_cardsBase64Image.length, filteredCards.length),
      );
    }

    // dismiss modal
    Navigator.pop(context);
  }

  double percentProgress(int currentLength, int total) => currentLength / total;

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
                  onPressed: prepareImageAssets,
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
