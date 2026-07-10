import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_ticket/models/movie/movie_data.dart';
import 'package:movie_booking_ticket/screens/main/home/data/home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({HomeRepository? repository})
    : _repository = repository ?? HomeRepository(),
      super(HomeState()) {
    on<LoadNowPlayingMovie>(_onLoadNowPlayingMovie);
    on<LoadMovieDetailById>(_onLoadMovieDeatilById);
    on<LoadComingSoonMovie>(_onLoadComingSoonMovie);
  }

  final HomeRepository _repository;

  Future<void> _onLoadNowPlayingMovie(
    LoadNowPlayingMovie event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final movies = await _repository.getNowPlayingMovies();
      emit(state.copyWith(movieDataList: movies));
    } catch (err) {
      debugPrint("=====> LoadNowPlayingMovie err ${err.toString()}");
    } finally {
      emit(state.copyWith(isLoading: false));
      add(LoadMovieDetailById(id: state.movieDataList.first.id ?? -1));
    }
  }

  Future<void> _onLoadMovieDeatilById(
    LoadMovieDetailById event,
    Emitter<HomeState> emit,
  ) async {
    final movie = state.movieDataList.firstWhere(
      (e) => e.id == event.id,
      orElse: () => MovieDataModel(),
    );
    if (movie.runtime != null) return;

    emit(state.copyWith(isLoadingDetail: true));
    try {
      final detail = await _repository.getMovieDetailById(event.id);
      final movieWantToEditIndex = state.movieDataList.indexWhere(
        (e) => e.id == event.id,
      );
      final updatedMovie = state.movieDataList[movieWantToEditIndex].copyWith(
        runtime: detail.runtime,
        genres: detail.genres,
      );

      final updatedList = List<MovieDataModel>.from(state.movieDataList);
      updatedList[movieWantToEditIndex] = updatedMovie;
      emit(state.copyWith(movieDataList: updatedList));
    } catch (err) {
      debugPrint("=====> LoadMovieDetailById err ${err.toString()}");
    } finally {
      emit(state.copyWith(isLoadingDetail: false));
    }
  }

  Future<void> _onLoadComingSoonMovie(
    LoadComingSoonMovie event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isComingSoonLoading: true));
    try {
      final movies = await _repository.getMovieComingSoon();

      final movieDetails = await Future.wait(
        movies.map((movie) async {
          try {
            return await _repository.getMovieDetailById(movie.id!);
          } catch (e) {
            debugPrint('Movie ${movie.id} failed: $e');
            return null;
          }
        }),
      );

      final updatedMovies = List.generate(
        movies.length,
        (index) => movies[index].copyWith(
          runtime: movieDetails[index]?.runtime,
          genres: movieDetails[index]?.genres,
        ),
      );

      emit(state.copyWith(comingSoonList: updatedMovies));
    } catch (err) {
      debugPrint("=====> LoadComingSoonMovie err ${err.toString()}");
    } finally {
      emit(state.copyWith(isComingSoonLoading: false));
    }
  }
}
