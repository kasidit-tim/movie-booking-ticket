part of 'movie_bloc.dart';

enum MovieTab { nowPlaying, commingSoon }

class MovieState extends Equatable {
  final MovieTab tab;
  final MoviePaginateData nowPlayingMovies;
  final bool isNowPlayingLoading;
  final bool isLoadingMore;

  const MovieState({
    this.tab = MovieTab.nowPlaying,
    required this.nowPlayingMovies,
    this.isNowPlayingLoading = false,
    this.isLoadingMore = false,
  });

  MovieState copyWith({
    MovieTab? tab,
    MoviePaginateData? nowPlayingMovies,
    bool? isNowPlayingLoading,
    bool? isLoadingMore,
  }) {
    return MovieState(
      tab: tab ?? this.tab,
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      isNowPlayingLoading: isNowPlayingLoading ?? this.isNowPlayingLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [
    tab,
    nowPlayingMovies,
    isNowPlayingLoading,
    isLoadingMore,
  ];
}
