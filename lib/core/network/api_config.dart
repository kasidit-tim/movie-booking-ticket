import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_booking_ticket/core/network/dio_client.dart';

abstract class ApiConfig {
  static Future<void> configure(DioClient dio) async {
    await dotenv.load(fileName: ".env");

    final baseUrl = dotenv.env['BASE_URL'] ?? '';
    final token = dotenv.env['TMDB_TOKEN'] ?? '';

    if (baseUrl.isNotEmpty) {
      dio.setBaseUrl(baseUrl);
    }
    if (token.isNotEmpty) {
      dio.setToken(token);
    }
  }
}
