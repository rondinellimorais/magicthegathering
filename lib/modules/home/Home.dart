import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

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
                  Row(
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
                        child: FlatButton(
                          child: Image.asset("assets/camera.png"),
                          onPressed: startUnityActivity,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: CarouselSlider(
                      options: CarouselOptions(
                        aspectRatio: 1.0,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                        viewportFraction: 0.74,
                      ),
                      items: imgList
                          .map(
                            (item) => Container(
                              decoration: BoxDecoration(
                                /**
                                 * Coloquei a imagem no box decorator pois aqui
                                 * eu consigo eliminar as pontas brancas da imagem
                                 * utilizando técnicas de overflow
                                 */
                                borderRadius: BorderRadius.circular(11.0),
                                image: DecorationImage(
                                  image: NetworkImage(item),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          )
                          .toList(),
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
