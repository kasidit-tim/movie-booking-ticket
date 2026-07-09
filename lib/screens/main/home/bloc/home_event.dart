part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadNowPlayingMovie extends HomeEvent {
  const LoadNowPlayingMovie();

  @override
  List<Object> get props => [];
}

class LoadMovieDetailById extends HomeEvent {
  const LoadMovieDetailById({required this.id});

  final int id;

  @override
  List<Object> get props => [id];
}
