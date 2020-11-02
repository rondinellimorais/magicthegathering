import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final List<Widget> children;
  final List<Color> colors;
  final Image pageBottomImage;

  Background({
    Key key,
    this.colors,
    this.children,
    this.pageBottomImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: this.colors,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                child: this.pageBottomImage,
              ),
            ),
            ...this.children
          ],
        ),
      ),
    );
  }
}
