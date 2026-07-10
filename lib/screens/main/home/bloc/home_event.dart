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

class LoadComingSoonMovie extends HomeEvent {
  const LoadComingSoonMovie();

  @override
  List<Object> get props => [];
}
