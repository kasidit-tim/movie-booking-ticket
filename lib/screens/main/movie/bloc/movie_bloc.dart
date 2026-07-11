import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_ticket/models/movie/movie_data.dart';
import 'package:movie_booking_ticket/models/movie/movie_paginate_data.dart';
import 'package:movie_booking_ticket/screens/main/movie/data/movie_repository.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc({MovieRepository? repository})
    : _repository = repository ?? MovieRepository(),
      super(MovieState(nowPlayingMovies: MoviePaginateData.empty())) {
    on<ChangeTabEvent>(_onChangeTabEvent);
    on<LoadAllNowPlayingEvent>(_onLoadAllNowPlayingEvent);
    on<LoadMoreNowPlayingEvent>(_onLoadMoreNowPlayingEvent);
  }

  final MovieRepository _repository;

  void _onChangeTabEvent(ChangeTabEvent event, Emitter<MovieState> emit) {
    emit(state.copyWith(tab: event.tab));
  }

  Future<void> _onLoadAllNowPlayingEvent(
    LoadAllNowPlayingEvent event,
    Emitter<MovieState> emit,
  ) async {
    emit(state.copyWith(isNowPlayingLoading: true));
    try {
      final movies = await _repository.getNowPlayingMovies();

      emit(state.copyWith(nowPlayingMovies: movies));
    } catch (err) {
      debugPrint("=====> LoadNowPlayingMovie err ${err.toString()}");
    } finally {
      emit(state.copyWith(isNowPlayingLoading: false));
      for (final movie in state.nowPlayingMovies.results ?? []) {
        await _loadMovieDetail(movie.id!, emit);
      }
    }
  }

  Future<void> _onLoadMoreNowPlayingEvent(
    LoadMoreNowPlayingEvent event,
    Emitter<MovieState> emit,
  ) async {
    if (state.isLoadingMore) return;
    final currentPage = state.nowPlayingMovies.page ?? 0;

    emit(state.copyWith(isLoadingMore: true));
    try {
      final nextPage = currentPage + 1;
      final newData = await _repository.getNowPlayingMovies(page: nextPage);

      final updatedResults = <MovieDataModel>[
        ...?state.nowPlayingMovies.results,
        ...?newData.results,
      ];

      emit(
        state.copyWith(
          nowPlayingMovies: state.nowPlayingMovies.copyWith(
            page: newData.page,
            results: updatedResults,
          ),
        ),
      );

      emit(state.copyWith(isLoadingMore: false));
      // Load details for new movies
      for (final movie in newData.results ?? []) {
        await _loadMovieDetail(movie.id!, emit);
      }
    } catch (err) {
      debugPrint("=====> LoadMoreNowPlaying err ${err.toString()}");
      emit(state.copyWith(isLoadingMore: false));
    }
  }

  Future<void> _loadMovieDetail(int id, Emitter<MovieState> emit) async {
    try {
      final detail = await _repository.getMovieDetailById(id);

      final updatedList = state.nowPlayingMovies.results?.map((movie) {
        if (movie.id != id) return movie;

        return movie.copyWith(runtime: detail.runtime, genres: detail.genres);
      }).toList();

      emit(
        state.copyWith(
          nowPlayingMovies: state.nowPlayingMovies.copyWith(
            results: updatedList,
          ),
        ),
      );
    } catch (e) {
      debugPrint("=====> Load detail $id error ${e.toString()}");
    }
  }
}
