import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_booking_ticket/models/cinema.dart';
import 'package:movie_booking_ticket/models/movie/movie_credits.dart';
import 'package:movie_booking_ticket/models/movie/movie_data.dart';
import 'package:movie_booking_ticket/models/movie/movie_video.dart';
import 'package:movie_booking_ticket/screens/movie_detail/bloc/movie_detail_bloc.dart';
import 'package:movie_booking_ticket/screens/movie_detail/data/movie_detail_repository.dart';

// ── Mocks ──────────────────────────────────────────────────────────

class MockMovieDetailRepository extends Mock
    implements MovieDetailRepository {}

// ── Test fixtures ──────────────────────────────────────────────────

MovieDataModel _movieFixture({int id = 42, String title = 'Test Movie'}) {
  return MovieDataModel(
    id: id,
    title: title,
    runtime: 120,
    genres: [Genre(id: 1, name: 'Action')],
  );
}

MovieVideoResponse _videoResponseFixture({
  bool includeOfficialTrailer = true,
  bool includeAnyYoutube = true,
}) {
  final results = <MovieVideo>[];
  if (includeOfficialTrailer) {
    results.add(
      MovieVideo(
        id: 'v1',
        iso6391: 'en',
        iso31661: 'US',
        name: 'Official Trailer',
        key: 'abc123',
        site: 'YouTube',
        size: 1080,
        type: 'Trailer',
        official: true,
        publishedAt: DateTime(2026, 1, 1),
      ),
    );
  }
  if (includeAnyYoutube && !includeOfficialTrailer) {
    results.add(
      MovieVideo(
        id: 'v2',
        iso6391: 'en',
        iso31661: 'US',
        name: 'Teaser',
        key: 'xyz789',
        site: 'YouTube',
        size: 720,
        type: 'Teaser',
        official: false,
        publishedAt: DateTime(2026, 1, 1),
      ),
    );
  }
  return MovieVideoResponse(id: 42, results: results);
}

MovieCredits _creditsFixture() {
  return const MovieCredits(
    id: 42,
    cast: [
      CastMember(id: 1, name: 'Actor One', character: 'Hero'),
      CastMember(id: 2, name: 'Actor Two', character: 'Villain'),
    ],
    crew: [
      CrewMember(id: 10, name: 'Director Name', job: 'Director'),
      CrewMember(id: 11, name: 'Writer Name', job: 'Writer'),
    ],
  );
}

void main() {
  late MockMovieDetailRepository mockRepo;

  setUp(() {
    mockRepo = MockMovieDetailRepository();
  });

  setUpAll(() {
    // Register fallback values for mocktail
    registerFallbackValue(const MovieVideoResponse(id: 0));
    registerFallbackValue(const MovieCredits(id: 0));
  });

  group('MovieDetailBloc', () {
    // ── LoadMovieDetailEvent ─────────────────────────────────────

    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits loading → detail loaded → extras loading states on success',
      build: () {
        when(() => mockRepo.getMovieDetailById(42))
            .thenAnswer((_) async => _movieFixture());
        when(() => mockRepo.getMovieVideos(42))
            .thenAnswer((_) async => _videoResponseFixture());
        when(() => mockRepo.getMovieCredits(42))
            .thenAnswer((_) async => _creditsFixture());
        return MovieDetailBloc(mockRepo);
      },
      act: (bloc) => bloc.add(const LoadMovieDetailEvent(id: 42)),
      // The bloc emits: isLoading:true, detail+cinema, isLoading:false,
      // then extras: trailerUrl+credits, isExtrasLoading:false
      expect: () => [
        // isLoading: true, isExtrasLoading: true
        predicate<MovieDetailState>((s) => s.isLoading && s.isExtrasLoading),
        // detail loaded + first cinema selected
        predicate<MovieDetailState>(
          (s) =>
              s.detail?.id == 42 &&
              s.selectedCinema == Cinema.mockCinemas.first,
        ),
        // isLoading: false
        predicate<MovieDetailState>((s) => !s.isLoading),
        // extras loaded: trailerUrl + credits
        predicate<MovieDetailState>(
          (s) =>
              s.trailerUrl == 'https://www.youtube.com/watch?v=abc123' &&
              s.credits != null,
        ),
        // isExtrasLoading: false
        predicate<MovieDetailState>((s) => !s.isExtrasLoading),
      ],
      verify: (_) {
        verify(() => mockRepo.getMovieDetailById(42)).called(1);
        verify(() => mockRepo.getMovieVideos(42)).called(1);
        verify(() => mockRepo.getMovieCredits(42)).called(1);
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'sets first mock cinema as selectedCinema on detail load',
      build: () {
        when(() => mockRepo.getMovieDetailById(any()))
            .thenAnswer((_) async => _movieFixture());
        when(() => mockRepo.getMovieVideos(any()))
            .thenAnswer((_) async => _videoResponseFixture());
        when(() => mockRepo.getMovieCredits(any()))
            .thenAnswer((_) async => _creditsFixture());
        return MovieDetailBloc(mockRepo);
      },
      act: (bloc) => bloc.add(const LoadMovieDetailEvent(id: 42)),
      verify: (bloc) {
        expect(bloc.state.selectedCinema, Cinema.mockCinemas.first);
      },
    );

    // ── Trailer URL extraction ───────────────────────────────────

    blocTest<MovieDetailBloc, MovieDetailState>(
      'prefers official trailer over any YouTube video',
      build: () {
        when(() => mockRepo.getMovieDetailById(any()))
            .thenAnswer((_) async => _movieFixture());
        when(() => mockRepo.getMovieVideos(any())).thenAnswer(
          (_) async => _videoResponseFixture(includeOfficialTrailer: true),
        );
        when(() => mockRepo.getMovieCredits(any()))
            .thenAnswer((_) async => _creditsFixture());
        return MovieDetailBloc(mockRepo);
      },
      act: (bloc) => bloc.add(const LoadMovieDetailEvent(id: 42)),
      verify: (bloc) {
        expect(
          bloc.state.trailerUrl,
          'https://www.youtube.com/watch?v=abc123',
        );
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'falls back to any YouTube video when no official trailer exists',
      build: () {
        when(() => mockRepo.getMovieDetailById(any()))
            .thenAnswer((_) async => _movieFixture());
        when(() => mockRepo.getMovieVideos(any())).thenAnswer(
          (_) async => _videoResponseFixture(
            includeOfficialTrailer: false,
            includeAnyYoutube: true,
          ),
        );
        when(() => mockRepo.getMovieCredits(any()))
            .thenAnswer((_) async => _creditsFixture());
        return MovieDetailBloc(mockRepo);
      },
      act: (bloc) => bloc.add(const LoadMovieDetailEvent(id: 42)),
      verify: (bloc) {
        expect(
          bloc.state.trailerUrl,
          'https://www.youtube.com/watch?v=xyz789',
        );
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'sets empty trailer URL when no YouTube videos exist',
      build: () {
        when(() => mockRepo.getMovieDetailById(any()))
            .thenAnswer((_) async => _movieFixture());
        when(() => mockRepo.getMovieVideos(any())).thenAnswer(
          (_) async => const MovieVideoResponse(id: 42, results: []),
        );
        when(() => mockRepo.getMovieCredits(any()))
            .thenAnswer((_) async => _creditsFixture());
        return MovieDetailBloc(mockRepo);
      },
      act: (bloc) => bloc.add(const LoadMovieDetailEvent(id: 42)),
      verify: (bloc) {
        expect(bloc.state.trailerUrl, '');
      },
    );

    // ── Credits / directors / topCast ────────────────────────────

    blocTest<MovieDetailBloc, MovieDetailState>(
      'populates credits with directors and top cast',
      build: () {
        when(() => mockRepo.getMovieDetailById(any()))
            .thenAnswer((_) async => _movieFixture());
        when(() => mockRepo.getMovieVideos(any()))
            .thenAnswer((_) async => _videoResponseFixture());
        when(() => mockRepo.getMovieCredits(any()))
            .thenAnswer((_) async => _creditsFixture());
        return MovieDetailBloc(mockRepo);
      },
      act: (bloc) => bloc.add(const LoadMovieDetailEvent(id: 42)),
      verify: (bloc) {
        expect(bloc.state.directors.length, 1);
        expect(bloc.state.directors.first.name, 'Director Name');
        expect(bloc.state.topCast.length, 2);
        expect(bloc.state.topCast.first.name, 'Actor One');
      },
    );

    // ── SelectCinemaEvent ────────────────────────────────────────

    blocTest<MovieDetailBloc, MovieDetailState>(
      'updates selectedCinema on SelectCinemaEvent',
      build: () => MovieDetailBloc(mockRepo),
      act: (bloc) {
        final targetCinema = Cinema.mockCinemas[2];
        bloc.add(SelectCinemaEvent(newCinema: targetCinema));
      },
      expect: () => [
        predicate<MovieDetailState>(
          (s) => s.selectedCinema == Cinema.mockCinemas[2],
        ),
      ],
    );

    // ── Error handling ───────────────────────────────────────────

    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits loading:false and continues when detail fetch fails',
      build: () {
        when(() => mockRepo.getMovieDetailById(any()))
            .thenThrow(Exception('Network error'));
        when(() => mockRepo.getMovieVideos(any()))
            .thenAnswer((_) async => _videoResponseFixture());
        when(() => mockRepo.getMovieCredits(any()))
            .thenAnswer((_) async => _creditsFixture());
        return MovieDetailBloc(mockRepo);
      },
      act: (bloc) => bloc.add(const LoadMovieDetailEvent(id: 42)),
      // Should still emit loading states and eventually stop loading
      expect: () => [
        predicate<MovieDetailState>((s) => s.isLoading),
        predicate<MovieDetailState>((s) => !s.isLoading),
        // Extras still fire and succeed
        predicate<MovieDetailState>((s) => s.trailerUrl.isNotEmpty),
        predicate<MovieDetailState>((s) => !s.isExtrasLoading),
      ],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'emits isExtrasLoading:false when extras fetch fails',
      build: () {
        when(() => mockRepo.getMovieDetailById(any()))
            .thenAnswer((_) async => _movieFixture());
        when(() => mockRepo.getMovieVideos(any()))
            .thenThrow(Exception('Videos API down'));
        when(() => mockRepo.getMovieCredits(any()))
            .thenThrow(Exception('Credits API down'));
        return MovieDetailBloc(mockRepo);
      },
      act: (bloc) => bloc.add(const LoadMovieDetailEvent(id: 42)),
      expect: () => [
        predicate<MovieDetailState>((s) => s.isLoading && s.isExtrasLoading),
        predicate<MovieDetailState>((s) => s.detail?.id == 42),
        predicate<MovieDetailState>((s) => !s.isLoading),
        predicate<MovieDetailState>((s) => !s.isExtrasLoading),
      ],
      verify: (bloc) {
        // Trailer and credits should remain at defaults on error
        expect(bloc.state.trailerUrl, '');
        expect(bloc.state.credits, isNull);
      },
    );

    // ── Initial state ────────────────────────────────────────────

    test('initial state has mock cinemas loaded', () {
      final bloc = MovieDetailBloc(mockRepo);
      expect(bloc.state.allCinemas, Cinema.mockCinemas);
      expect(bloc.state.isLoading, isFalse);
      expect(bloc.state.isExtrasLoading, isFalse);
      expect(bloc.state.detail, isNull);
      expect(bloc.state.trailerUrl, '');
      expect(bloc.state.credits, isNull);
      bloc.close();
    });
  });
}
