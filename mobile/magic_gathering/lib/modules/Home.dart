import 'package:flutter/cupertino.dart';
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
  int currentIndex = 0;
  String inViewPortBase64;

  @override
  void initState() {
    super.initState();
    loadMagicCards();
  }

  void loadMagicCards() async {
    try {
      cards = await new MagicCardService().cards();
      List<String> imgList = List<String>();

      for (var card
          in cards.where((element) => element.imageUrl != null).toList()) {
        imgList.add(card.imageUrl);
      }

      setState(() {
        _imgList = imgList;
      });
    } catch (e) {
      throw e;
    }
  }

  Future<void> cardsBase64Image() async {
    /**
     * OBS: Vou limitar a lista a 4 itens pois esses base64
     * execede o limite de informações que podem ser enviadas
     * via putExtra na intent
     */
    var filteredCards = cards
        .where((element) => element.imageUrl != null)
        .toList()
        .sublist(1, 5);

    inViewPortBase64 = await filteredCards[currentIndex].toBase64();

    for (var card in filteredCards) {
      _cardsBase64Image.add(await card.toBase64());
      progressAlertDialog.updatePercentProgress(
        percentProgress(_cardsBase64Image.length, filteredCards.length),
      );
    }
    Navigator.pop(context);
  }

  double percentProgress(int currentLength, int total) => currentLength / total;

  void prepareImageAssets() async {
    if (_cardsBase64Image.isEmpty) {
      progressAlertDialog = new ProgressAlertDialog();
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => progressAlertDialog,
      );
      await cardsBase64Image();
    }
    startUnityActivity();
  }

  void startUnityActivity() async {
    Map<String, dynamic> parameters = {
      'cardBase64Image': inViewPortBase64,
      'cardsBase64Image': _cardsBase64Image
    };
    platform.invokeMethod('startUnityActivity', parameters);
  }

  void openUnityScene() {
    if (_imgList.isEmpty) {
      return;
    }

    if (defaultTargetPlatform == TargetPlatform.iOS) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(
                "Realidade aumentada disponível apenas para Android sorry 😭"),
            actions: [
              CupertinoDialogAction(
                child: Text(
                  "Fechar",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }

    if (defaultTargetPlatform == TargetPlatform.android) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Você quer uma experiência com realidade aumentada ?"),
            content: Text(
                "Tenha em mão os qr codes, de preferência... literalmente 😊"),
            actions: [
              FlatButton(
                child: Text(
                  "Sim",
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  prepareImageAssets();
                },
              ),
              FlatButton(
                child: Text(
                  "Não",
                  style: TextStyle(fontSize: 16, color: Colors.redAccent[700]),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
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
                  onPressed: openUnityScene,
                ),
              ),
              MagicCarousel(
                images: _imgList,
                onPageChanged: (index) {
                  currentIndex = index;
                },
              ),
              Footer(),
            ],
          ),
        ],
      ),
    );
  }
}
