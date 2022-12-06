
import 'package:ditonton/common/shared.dart';
import 'package:http/http.dart' as http;

class SslPinning {
  static Future<http.Client> get _instance async =>
      _client ??= await Shared.createLEClient();
  static http.Client? _client;
  static http.Client get client => _client ?? http.Client();
  static Future<void> init() async {
    _client = await _instance;
  }
}