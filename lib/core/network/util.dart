import 'package:flutter_dotenv/flutter_dotenv.dart';

class Util {
  static Future<Map<String, dynamic>> apiKey() async {
    final headers = Map<String, dynamic>();
    headers["Authorization"] = dotenv.env['AUTH'];;

    return headers;
  }
}