import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_ticket/models/movie/movie_data.dart';
import 'package:movie_booking_ticket/models/movie/movie_video.dart';
import 'package:movie_booking_ticket/models/cinema.dart';
import 'package:movie_booking_ticket/screens/movie_detail/data/movie_detail_repository.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieDetailBloc({MovieDetailRepository? repository})
    : _repository = repository ?? MovieDetailRepository(),
      super(const MovieDetailState(allCinemas: Cinema.mockCinemas)) {
    on<LoadMovieDetailEvent>(_onLoadMovieDetail);
    on<SelectCinemaEvent>(_onSelectCinema);
  }

  final MovieDetailRepository _repository;

  Future<void> _onLoadMovieDetail(
    LoadMovieDetailEvent event,
    Emitter<MovieDetailState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final results = await Future.wait([
        _repository.getMovieDetailById(event.id),
        _repository.getMovieVideos(event.id),
      ]);

      final detail = results[0] as MovieDataModel;
      final videos = results[1] as MovieVideoResponse;
      final trailer = videos.officialTrailer ?? videos.anyYoutubeVideo;

      emit(state.copyWith(detail: detail, trailerUrl: trailer?.youtubeUrl));
      emit(state.copyWith(selectedCinema: state.allCinemas[0]));
    } catch (e) {
      debugPrint('MovieDetailBloc: load ${event.id} failed: $e ');
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  void _onSelectCinema(
    SelectCinemaEvent event,
    Emitter<MovieDetailState> emit,
  ) {
    emit(state.copyWith(selectedCinema: event.newCinema));
  }
}
