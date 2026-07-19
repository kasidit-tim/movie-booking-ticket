import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_ticket/models/movie/movie_data.dart';
import 'package:movie_booking_ticket/screens/main/home/data/home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._repository) : super(HomeState()) {
    on<LoadNowPlayingMovie>(_onLoadNowPlayingMovie);
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

      emit(state.copyWith(movieDataList: updatedMovies));
    } catch (err) {
      debugPrint("=====> LoadNowPlayingMovie err ${err.toString()}");
    } finally {
      emit(state.copyWith(isLoading: false));
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
