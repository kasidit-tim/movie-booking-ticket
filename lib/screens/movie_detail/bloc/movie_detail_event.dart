part of 'movie_detail_bloc.dart';

sealed class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadMovieDetailEvent extends MovieDetailEvent {
  final int id;

  const LoadMovieDetailEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class SelectCinemaEvent extends MovieDetailEvent {
  final Cinema newCinema;

  const SelectCinemaEvent({required this.newCinema});

  @override
  List<Object> get props => [newCinema];
}
