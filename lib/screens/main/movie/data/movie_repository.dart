import 'package:movie_booking_ticket/core/network/api_endpoints.dart';
import 'package:movie_booking_ticket/core/network/dio_client.dart';
import 'package:movie_booking_ticket/models/movie/movie_data.dart';
import 'package:movie_booking_ticket/models/movie/movie_paginate_data.dart';

class MovieRepository {
  MovieRepository({DioClient? client}) : _client = client ?? DioClient();

  final DioClient _client;

  Future<MoviePaginateData> getNowPlayingMovies({int page = 1}) async {
    final response = await _client.get(
      ApiEndpoints.nowPlaying,
      queryParameters: {"language": "en-US", "page": page, "region": "TH"},
    );
    final data = response.data;
    return MoviePaginateData.fromJson(data);
  }

  Future<MovieDataModel> getMovieDetailById(int id) async {
    final response = await _client.get(
      ApiEndpoints.movieDetailById(id),
      queryParameters: {"language": "en-US"},
    );
    return MovieDataModel.fromJson(response.data);
  }

  Future<MoviePaginateData> getMovieComingSoon({int page = 1}) async {
    final response = await _client.get(
      ApiEndpoints.comingSoon,
      queryParameters: {
        "sort_by": "popularity.desc",
        "with_release_type": "2|3",
        "release_date.gte": DateTime.now()
            .add(Duration(days: 30))
            .toString()
            .substring(0, 10),
        "region": "TH",
        "page": page,
      },
    );
    final data = response.data;
    return MoviePaginateData.fromJson(data);
  }
}
