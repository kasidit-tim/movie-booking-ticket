part of 'movie_detail_bloc.dart';

class MovieDetailState extends Equatable {
  const MovieDetailState({
    this.isLoading = false,
    this.detail,
    this.trailerUrl,
    this.allCinemas = const [],
    this.selectedCinema,
  });

  final bool isLoading;
  final MovieDataModel? detail;
  final String? trailerUrl;
  final List<Cinema> allCinemas;
  final Cinema? selectedCinema;

  MovieDetailState copyWith({
    bool? isLoading,
    MovieDataModel? detail,
    String? trailerUrl,
    List<Cinema>? allCinemas,
    Cinema? selectedCinema,
  }) {
    return MovieDetailState(
      isLoading: isLoading ?? this.isLoading,
      detail: detail ?? this.detail,
      trailerUrl: trailerUrl ?? this.trailerUrl,
      allCinemas: allCinemas ?? this.allCinemas,
      selectedCinema: selectedCinema ?? this.selectedCinema,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    detail,
    trailerUrl,
    allCinemas,
    selectedCinema,
  ];
}
