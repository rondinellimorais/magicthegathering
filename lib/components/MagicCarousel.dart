import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:magic_gathering/components/MagicCard.dart';

class MagicCarousel extends StatelessWidget {
  final List<String> images;

  MagicCarousel({Key key, this.images}) : super(key: key);

  List<MagicCard> magicCards() {
    return this.images.map((url) => MagicCard(url: url)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 1.0,
          enlargeCenterPage: true,
          enableInfiniteScroll: false,
          viewportFraction: 0.74,
        ),
        items: this.magicCards(),
      ),
    );
  }
}
