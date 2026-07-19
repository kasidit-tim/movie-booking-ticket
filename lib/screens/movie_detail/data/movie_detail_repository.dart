import 'package:movie_booking_ticket/core/network/api_endpoints.dart';
import 'package:movie_booking_ticket/core/network/dio_client.dart';
import 'package:movie_booking_ticket/models/movie/movie_credits.dart';
import 'package:movie_booking_ticket/models/movie/movie_data.dart';
import 'package:movie_booking_ticket/models/movie/movie_video.dart';

class MovieDetailRepository {
  MovieDetailRepository({DioClient? client}) : _client = client ?? DioClient();

  final DioClient _client;

  Future<MovieDataModel> getMovieDetailById(int id) async {
    final response = await _client.get(
      ApiEndpoints.movieDetailById(id),
      queryParameters: {
        "language": "en-US",
        "append_to_response": "release_dates",
      },
    );
    return MovieDataModel.fromJson(response.data);
  }

  Future<MovieVideoResponse> getMovieVideos(int id) async {
    final response = await _client.get(
      ApiEndpoints.movieVideosById(id),
      queryParameters: {"language": "en-US"},
    );
    return MovieVideoResponse.fromJson(response.data);
  }

  Future<MovieCredits> getMovieCredits(int id) async {
    final response = await _client.get(
      ApiEndpoints.movieCreditsById(id),
      queryParameters: {"language": "en-US"},
    );
    return MovieCredits.fromJson(response.data);
  }
}
