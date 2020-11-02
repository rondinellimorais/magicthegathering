import 'dart:convert';
import 'package:http/http.dart' as http;

class BaseService {
  Future<dynamic> get(Uri uri) async {
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      throw e;
    }
  }
}
