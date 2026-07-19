import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_ticket/models/movie/movie_credits.dart';
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
    on<ExtrasLoadedEvent>(_onExtrasLoaded);
    on<SelectCinemaEvent>(_onSelectCinema);
  }

  final MovieDetailRepository _repository;

  Future<void> _onLoadMovieDetail(
    LoadMovieDetailEvent event,
    Emitter<MovieDetailState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, isExtrasLoading: true));
    try {
      final detail = await _repository.getMovieDetailById(event.id);
      emit(state.copyWith(detail: detail, selectedCinema: state.allCinemas[0]));
    } catch (e) {
      debugPrint('MovieDetailBloc: load detail ${event.id} failed: $e');
    } finally {
      emit(state.copyWith(isLoading: false));
    }

    add(ExtrasLoadedEvent(id: event.id));
  }

  Future<void> _onExtrasLoaded(
    ExtrasLoadedEvent event,
    Emitter<MovieDetailState> emit,
  ) async {
    final movieId = event.id;
    try {
      final results = await Future.wait([
        _repository.getMovieVideos(movieId),
        _repository.getMovieCredits(movieId),
      ]);

      final videos = results[0] as MovieVideoResponse;
      final credits = results[1] as MovieCredits;
      final trailer = videos.officialTrailer ?? videos.anyYoutubeVideo;
      emit(
        state.copyWith(trailerUrl: trailer?.youtubeUrl ?? '', credits: credits),
      );
    } catch (e) {
      debugPrint('MovieDetailBloc: fetch extras $movieId failed: $e');
    } finally {
      emit(state.copyWith(isExtrasLoading: false));
    }
  }

  void _onSelectCinema(
    SelectCinemaEvent event,
    Emitter<MovieDetailState> emit,
  ) {
    emit(state.copyWith(selectedCinema: event.newCinema));
  }
}
