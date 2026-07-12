import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_booking_ticket/models/movie/movie_paginate_data.dart';

part 'movie_section_state.g.dart';

@CopyWith()
class MovieSectionState extends Equatable {
  final MoviePaginateData movies;
  final bool isLoading;
  final bool isLoadingMore;

  const MovieSectionState({
    required this.movies,
    this.isLoading = false,
    this.isLoadingMore = false,
  });

  factory MovieSectionState.empty() {
    return MovieSectionState(
      movies: MoviePaginateData.empty(),
      isLoading: false,
      isLoadingMore: false,
    );
  }

  @override
  List<Object?> get props => [movies, isLoading, isLoadingMore];
}
