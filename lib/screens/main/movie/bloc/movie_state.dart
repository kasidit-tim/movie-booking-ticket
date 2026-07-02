part of 'movie_bloc.dart';

enum MovieTab { nowPlaying, commingSoon }

class MovieState extends Equatable {
  final MovieTab tab;

  const MovieState({this.tab = MovieTab.nowPlaying});

  MovieState copyWith({MovieTab? tab}) {
    return MovieState(tab: tab ?? this.tab);
  }

  @override
  List<Object?> get props => [tab];
}
