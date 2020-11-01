import 'package:magic_gathering/model/MagicCard.dart';
import 'package:magic_gathering/services/BaseService.dart';

class MagicCardService extends BaseService {
  Future<List<MagicCard>> cards() async {
    Map<String, String> params = {
      'page': '0',
      'pageSize': '50',
      'contains': 'imageUrl'
    };

    Uri endpoint = Uri.https('api.magicthegathering.io', '/v1/cards', params);

    final json = await this.get(endpoint);
    final cards = json["cards"];

    List<MagicCard> magicCards = new List<MagicCard>();
    for (var json in cards) {
      magicCards.add(MagicCard.fromJson(json));
    }
    return magicCards;
  }
}
