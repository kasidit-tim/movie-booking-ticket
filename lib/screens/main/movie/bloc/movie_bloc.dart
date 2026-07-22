import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_ticket/models/movie/movie_data.dart';
import 'package:movie_booking_ticket/models/movie/movie_paginate_data.dart';
import 'package:movie_booking_ticket/screens/main/movie/data/movie_repository.dart';
import 'package:movie_booking_ticket/screens/main/movie/data/movie_section_state.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc(this._repository)
    : super(
        MovieState(
          nowPlaying: MovieSectionState.empty(),
          comingSoon: MovieSectionState.empty(),
        ),
      ) {
    on<ChangeTabEvent>(_onChangeTabEvent);
    on<LoadMoviesEvent>(_onLoadMovies);
    on<LoadMoreMoviesEvent>(_onLoadMoreMovies);
  }

  final MovieRepository _repository;

  Future<void> _onChangeTabEvent(
    ChangeTabEvent event,
    Emitter<MovieState> emit,
  ) async {
    emit(state.copyWith(tab: event.tab));
  }

  Future<void> _onLoadMovies(
    LoadMoviesEvent event,
    Emitter<MovieState> emit,
  ) async {
    switch (event.tab) {
      case MovieTab.nowPlaying:
        await _loadNowPlaying(emit);
        break;

      case MovieTab.comingSoon:
        await _loadComingSoon(emit);
        break;
    }
  }

  Future<void> _loadNowPlaying(Emitter<MovieState> emit) async {
    var section = state.nowPlaying;
    if (section.movies != MoviePaginateData.empty()) return;

    section = section.copyWith(isLoading: true);
    emit(state.copyWith(nowPlaying: section));
    try {
      final movies = await _repository.getNowPlayingMovies();

      section = section.copyWith(movies: movies);
      emit(state.copyWith(nowPlaying: section));
    } catch (err) {
      debugPrint("=====> LoadNowPlayingMovie err ${err.toString()}");
    } finally {
      section = section.copyWith(isLoading: false);
      emit(state.copyWith(nowPlaying: section));

      for (MovieDataModel movie in section.movies.results ?? []) {
        await _loadMovieDetail(id: movie.id!, emit: emit);
      }
    }
  }

  Future<void> _loadComingSoon(Emitter<MovieState> emit) async {
    var section = state.comingSoon;
    if (section.movies != MoviePaginateData.empty()) return;

    section = section.copyWith(isLoading: true);
    emit(state.copyWith(comingSoon: section));
    try {
      final movies = await _repository.getMovieComingSoon();

      section = section.copyWith(movies: movies);
      emit(state.copyWith(comingSoon: section));
    } catch (err) {
      debugPrint("=====> LoadComingSoonEvent err ${err.toString()}");
    } finally {
      section = section.copyWith(isLoading: false);
      emit(state.copyWith(comingSoon: section));

      for (MovieDataModel movie in section.movies.results ?? []) {
        await _loadMovieDetail(id: movie.id!, emit: emit, isComingSoon: true);
      }
    }
  }

  Future<void> _loadMovieDetail({
    required int id,
    required Emitter<MovieState> emit,
    bool isComingSoon = false,
  }) async {
    try {
      final detail = await _repository.getMovieDetailById(id);
      final section = isComingSoon ? state.comingSoon : state.nowPlaying;

      final updatedList = section.movies.results?.map((movie) {
        if (movie.id != id) return movie;
        return movie.copyWith(runtime: detail.runtime, genres: detail.genres);
      }).toList();

      final updatedSection = section.copyWith(
        movies: section.movies.copyWith(results: updatedList),
      );

      emit(
        isComingSoon
            ? state.copyWith(comingSoon: updatedSection)
            : state.copyWith(nowPlaying: updatedSection),
      );
    } catch (e) {
      debugPrint("=====> Load detail $id error ${e.toString()}");
    }
  }

  Future<void> _onLoadMoreMovies(
    LoadMoreMoviesEvent event,
    Emitter<MovieState> emit,
  ) async {
    switch (event.tab) {
      case MovieTab.nowPlaying:
        await _loadMoreNowPlaying(emit);
        break;

      case MovieTab.comingSoon:
        await _loadMoreComingSoon(emit);
        break;
    }
  }

  Future<void> _loadMoreNowPlaying(Emitter<MovieState> emit) async {
    var section = state.nowPlaying;
    if (section.isLoadingMore) return;
    final currentPage = section.movies.page ?? 0;

    section = section.copyWith(isLoadingMore: true);
    emit(state.copyWith(nowPlaying: section));
    try {
      final nextPage = currentPage + 1;
      final newData = await _repository.getNowPlayingMovies(page: nextPage);

      final updatedResults = _mergeMovies(section.movies, newData);
      section = section.copyWith(
        isLoadingMore: false,
        movies: section.movies.copyWith(
          page: newData.page,
          results: updatedResults,
        ),
      );
      emit(state.copyWith(nowPlaying: section));

      for (MovieDataModel movie in newData.results ?? []) {
        await _loadMovieDetail(id: movie.id!, emit: emit);
      }
    } catch (err) {
      debugPrint("=====> LoadMoreNowPlaying err ${err.toString()}");
      emit(state.copyWith(nowPlaying: section.copyWith(isLoadingMore: false)));
    }
  }

  Future<void> _loadMoreComingSoon(Emitter<MovieState> emit) async {
    var section = state.comingSoon;
    if (section.isLoadingMore) return;
    final currentPage = section.movies.page ?? 0;

    section = section.copyWith(isLoadingMore: true);
    emit(state.copyWith(comingSoon: section));
    try {
      final nextPage = currentPage + 1;
      final newData = await _repository.getMovieComingSoon(page: nextPage);

      final updatedResults = _mergeMovies(section.movies, newData);
      section = section.copyWith(
        isLoadingMore: false,
        movies: section.movies.copyWith(
          page: newData.page,
          results: updatedResults,
        ),
      );
      emit(state.copyWith(comingSoon: section));

      for (MovieDataModel movie in newData.results ?? []) {
        await _loadMovieDetail(id: movie.id!, emit: emit, isComingSoon: true);
      }
    } catch (err) {
      debugPrint("=====> LoadMoreComingSoon err ${err.toString()}");
      emit(state.copyWith(comingSoon: section.copyWith(isLoadingMore: false)));
    }
  }

  List<MovieDataModel> _mergeMovies(
    MoviePaginateData current,
    MoviePaginateData incoming,
  ) {
    return [...?current.results, ...?incoming.results];
  }
}
