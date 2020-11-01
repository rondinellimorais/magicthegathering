class MagicCard {
  final int id;
  final String name;
  final String imageUrl;

  MagicCard({
    this.id,
    this.name,
    this.imageUrl,
  });

  factory MagicCard.fromJson(Map<String, dynamic> json) {
    return MagicCard(
      id: json['multiverseid'],
      name: json['name'],
      imageUrl: json['imageUrl'],
    );
  }
}
