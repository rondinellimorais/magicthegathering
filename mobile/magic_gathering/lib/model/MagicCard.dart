import 'dart:convert';
import 'package:http/http.dart' as http;

class MagicCard {
  final int id;
  final String name;
  final String imageUrl;

  MagicCard({
    this.id,
    this.name,
    this.imageUrl,
  });

  Future<String> toBase64() async {
    http.Response response = await http.get(imageUrl);
    return base64Encode(response.bodyBytes);
  }

  factory MagicCard.fromJson(Map<String, dynamic> json) {
    return MagicCard(
      id: int.parse(json['multiverseid']),
      name: json['name'],
      imageUrl: json['imageUrl'],
    );
  }
}
