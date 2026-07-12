part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object?> get props => [];
}

class ChangeTabEvent extends MovieEvent {
  final MovieTab tab;

  const ChangeTabEvent({required this.tab});

  @override
  List<Object?> get props => [tab];
}

class LoadMoviesEvent extends MovieEvent {
  final MovieTab tab;

  const LoadMoviesEvent({required this.tab});

  @override
  List<Object?> get props => [tab];
}

class LoadMoreMoviesEvent extends MovieEvent {
  final MovieTab tab;

  const LoadMoreMoviesEvent({required this.tab});

  @override
  List<Object?> get props => [tab];
}
