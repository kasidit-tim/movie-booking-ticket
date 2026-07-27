import 'package:mocktail/mocktail.dart';
import 'package:movie_booking_ticket/core/network/dio_client.dart';
import 'package:movie_booking_ticket/models/movie/movie_data.dart';
import 'package:movie_booking_ticket/models/movie/movie_paginate_data.dart';
import 'package:movie_booking_ticket/screens/main/home/data/home_repository.dart';
import 'package:movie_booking_ticket/screens/main/movie/data/movie_repository.dart';

import '../helpers/fixture_loader.dart';

/// A mock [DioClient] used only to satisfy [MovieRepository]'s constructor.
///
/// No HTTP methods are ever called on it because [FakeMovieRepository]
/// overrides every repository method.
class MockDioClient extends Mock implements DioClient {}

/// A fake [MovieRepository] backed by JSON fixtures on disk.
///
/// Reads from `test/fixtures/home/now_playing.json` and
/// `test/fixtures/home/coming_soon.json` so that golden tests
/// use deterministic, realistic data without network calls.
///
/// ```dart
/// final repo = FakeMovieRepository();
/// final movies = await repo.getNowPlayingMovies();
/// ```
class FakeMovieRepository extends MovieRepository {
  FakeMovieRepository() : super(MockDioClient());

  late final MoviePaginateData _nowPlaying = MoviePaginateData.fromJson(
    loadFixtureMap('home/now_playing.json'),
  );

  late final MoviePaginateData _comingSoon = MoviePaginateData.fromJson(
    loadFixtureMap('home/coming_soon.json'),
  );

  late final List<MovieDataModel> _allMovies = [
    ...?_nowPlaying.results,
    ...?_comingSoon.results,
  ];

  @override
  Future<MoviePaginateData> getNowPlayingMovies({int page = 1}) async {
    return _nowPlaying;
  }

  @override
  Future<MoviePaginateData> getMovieComingSoon({int page = 1}) async {
    return _comingSoon;
  }

  @override
  Future<MovieDataModel> getMovieDetailById(int id) async {
    final movie = _allMovies.where((m) => m.id == id).firstOrNull;
    if (movie != null) return movie;

    // Fall back to the first movie from the now-playing fixture.
    return _allMovies.isNotEmpty
        ? _allMovies.first
        : const MovieDataModel(id: 0, title: 'Unknown');
  }
}

/// A fake [HomeRepository] backed by the same JSON fixtures.
///
/// Both [getNowPlayingMovies] and [getMovieComingSoon] return the first
/// 6 movies from their respective fixture files (matching the real
/// `HomeRepository` which caps at 6 via `data.take(6)`).
///
/// [getMovieDetailById] looks up the movie by ID in the loaded fixtures,
/// which already contain `runtime` and `genres` — the only fields
/// [HomeBloc] merges into the list items.
class FakeHomeRepository extends HomeRepository {
  FakeHomeRepository() : super(MockDioClient());

  late final List<MovieDataModel> _nowPlaying = _loadMovies(
    'home/now_playing.json',
  );

  late final List<MovieDataModel> _comingSoon = _loadMovies(
    'home/coming_soon.json',
  );

  late final List<MovieDataModel> _allMovies = [..._nowPlaying, ..._comingSoon];

  static List<MovieDataModel> _loadMovies(String path) {
    final json = loadFixtureMap(path);
    final results = json['results'] as List;
    return results
        .map((e) => MovieDataModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<MovieDataModel>> getNowPlayingMovies() async {
    return _nowPlaying;
  }

  @override
  Future<List<MovieDataModel>> getMovieComingSoon() async {
    return _comingSoon;
  }

  @override
  Future<MovieDataModel> getMovieDetailById(int id) async {
    final movie = _allMovies.where((m) => m.id == id).firstOrNull;
    if (movie != null) return movie;

    return _allMovies.isNotEmpty
        ? _allMovies.first
        : const MovieDataModel(id: 0, title: 'Unknown');
  }
}
