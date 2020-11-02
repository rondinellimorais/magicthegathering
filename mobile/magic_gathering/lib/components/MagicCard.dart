import 'package:flutter/material.dart';

class MagicCard extends StatelessWidget {
  final String url;

  MagicCard({Key key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /**
     * Coloquei a imagem no box decorator pois aqui
     * eu consigo eliminar as pontas brancas da imagem
     * utilizando técnicas de overflow
     */
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11.0),
        image: DecorationImage(
          image: NetworkImage(this.url),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
