part of 'movie_bloc.dart';

enum MovieTab { nowPlaying, comingSoon }

class MovieState extends Equatable {
  final MovieTab tab;
  final MovieSectionState nowPlaying;
  final MovieSectionState comingSoon;

  const MovieState({
    this.tab = MovieTab.nowPlaying,
    required this.nowPlaying,
    required this.comingSoon,
  });

  MovieState copyWith({
    MovieTab? tab,
    MovieSectionState? nowPlaying,
    MovieSectionState? comingSoon,
  }) {
    return MovieState(
      tab: tab ?? this.tab,
      nowPlaying: nowPlaying ?? this.nowPlaying,
      comingSoon: comingSoon ?? this.comingSoon,
    );
  }

  @override
  List<Object?> get props => [tab, nowPlaying, comingSoon];
}
