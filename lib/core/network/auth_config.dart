import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_booking_ticket/core/network/dio_client.dart';

abstract class AuthConfig {
  static Future<void> configure() async {
    await dotenv.load(fileName: ".env");

    final baseUrl = dotenv.env['BASE_URL'] ?? '';
    final token = dotenv.env['TMDB_TOKEN'] ?? '';

    if (baseUrl.isNotEmpty) {
      DioClient().setBaseUrl(baseUrl);
    }
    if (token.isNotEmpty) {
      DioClient().setToken(token);
    }
  }
}
