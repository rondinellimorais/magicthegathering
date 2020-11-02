import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:magic_gathering/components/LoadingView.dart';
import 'package:magic_gathering/components/MagicCard.dart';

class MagicCarousel extends StatelessWidget {
  final List<String> images;
  final Function(int index) onPageChanged;

  MagicCarousel({
    Key key,
    this.images,
    this.onPageChanged,
  }) : super(key: key);

  List<MagicCard> magicCards() {
    return images.map((url) => MagicCard(url: url)).toList();
  }

  Widget renderCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 1.0,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        viewportFraction: 0.72,
        onPageChanged: (index, reason) {
          this.onPageChanged(index);
        },
      ),
      items: magicCards(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: images.isEmpty ? LoadingView() : renderCarousel(),
    );
  }
}
