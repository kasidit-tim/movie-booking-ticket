part of 'movie_bloc.dart';

enum MovieTab { nowPlaying, comingSoon }

class MovieState extends Equatable {
  final MovieTab tab;
  final MovieSectionState nowPlaying;
  final MovieSectionState comingSoon;
  final Map<int, MovieDetail> details;

  const MovieState({
    this.tab = MovieTab.nowPlaying,
    required this.nowPlaying,
    required this.comingSoon,
    this.details = const {},
  });

  MovieState copyWith({
    MovieTab? tab,
    MovieSectionState? nowPlaying,
    MovieSectionState? comingSoon,
    Map<int, MovieDetail>? details,
  }) {
    return MovieState(
      tab: tab ?? this.tab,
      nowPlaying: nowPlaying ?? this.nowPlaying,
      comingSoon: comingSoon ?? this.comingSoon,
      details: details ?? this.details,
    );
  }

  @override
  List<Object?> get props => [tab, nowPlaying, comingSoon, details];
}
