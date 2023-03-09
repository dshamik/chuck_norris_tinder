import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:chuck_norris_tinder/api/models/chuck_norris.dart';

class API {
  final client = http.Client();
  final Uri apiUri;

  API(this.apiUri);

  Future<ChuckNorris?> getData() async {
    ChuckNorris? chuckNorris;
    try {
      var response = await client.get(apiUri);
      chuckNorris = ChuckNorris.fromJson(jsonDecode(response.body));
    } catch (e) {
      chuckNorris = null;
    }

    return chuckNorris;
  }
}
