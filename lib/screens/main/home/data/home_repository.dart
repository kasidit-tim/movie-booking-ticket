import 'package:movie_booking_ticket/core/network/api_endpoints.dart';
import 'package:movie_booking_ticket/core/network/dio_client.dart';
import 'package:movie_booking_ticket/models/movie/movie_data.dart';

class HomeRepository {
  HomeRepository({DioClient? client}) : _client = client ?? DioClient();

  final DioClient _client;

  Future<List<MovieDataModel>> getNowPlayingMovies() async {
    final response = await _client.get(
      ApiEndpoints.nowPlaying,
      queryParameters: {"language": "en-US", "page": 1},
    );
    final data = response.data['results'] as List;
    return MovieDataModel.parseList(data.sublist(0, 6));
  }

  Future<MovieDataModel> getMovieDetailById(int id) async {
    final response = await _client.get(
      ApiEndpoints.movieDetailById(id),
      queryParameters: {"language": "en-US"},
    );
    return MovieDataModel.fromJson(response.data);
  }
}
