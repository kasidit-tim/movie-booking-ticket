import 'package:movie_booking_ticket/core/network/api_endpoints.dart';
import 'package:movie_booking_ticket/core/network/dio_client.dart';
import 'package:movie_booking_ticket/models/movie/movie_data.dart';

class HomeRepository {
  HomeRepository(this._client);

  final DioClient _client;

  Future<List<MovieDataModel>> getNowPlayingMovies() async {
    final response = await _client.get(
      ApiEndpoints.nowPlaying,
      queryParameters: {"language": "en-US", "page": 1, "region": "TH"},
    );
    final data = response.data['results'] as List;
    return MovieDataModel.parseList(data.take(6).toList());
  }

  Future<MovieDataModel> getMovieDetailById(int id) async {
    final response = await _client.get(
      ApiEndpoints.movieDetailById(id),
      queryParameters: {"language": "en-US"},
    );
    return MovieDataModel.fromJson(response.data);
  }

  Future<List<MovieDataModel>> getMovieComingSoon() async {
    final response = await _client.get(
      ApiEndpoints.comingSoon,
      queryParameters: {
        "sort_by": "popularity.desc",
        "with_release_type": "2|3",
        "release_date.gte": DateTime.now()
            .add(Duration(days: 30))
            .toString()
            .substring(0, 10),
        "release_date.lte": DateTime.now()
            .add(Duration(days: 60))
            .toString()
            .substring(0, 10),
        "region": "TH",
      },
    );
    final data = response.data['results'] as List;
    return MovieDataModel.parseList(data.take(6).toList());
  }
}
