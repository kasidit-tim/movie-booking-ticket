part of 'movie_detail_bloc.dart';

class MovieDetailState extends Equatable {
  const MovieDetailState({
    this.isLoading = false,
    this.isExtrasLoading = false,
    this.detail,
    this.trailerUrl = '',
    this.credits,
    this.allCinemas = const [],
    this.selectedCinema,
  });

  final bool isLoading;
  final bool isExtrasLoading;
  final MovieDataModel? detail;
  final String trailerUrl;
  final MovieCredits? credits;
  final List<Cinema> allCinemas;
  final Cinema? selectedCinema;

  List<CrewMember> get directors => credits?.directors ?? [];
  List<CastMember> get topCast =>
      credits != null ? credits!.cast.take(10).toList() : [];

  MovieDetailState copyWith({
    bool? isLoading,
    bool? isExtrasLoading,
    MovieDataModel? detail,
    String? trailerUrl,
    MovieCredits? credits,
    List<Cinema>? allCinemas,
    Cinema? selectedCinema,
  }) {
    return MovieDetailState(
      isLoading: isLoading ?? this.isLoading,
      isExtrasLoading: isExtrasLoading ?? this.isExtrasLoading,
      detail: detail ?? this.detail,
      trailerUrl: trailerUrl ?? this.trailerUrl,
      credits: credits ?? this.credits,
      allCinemas: allCinemas ?? this.allCinemas,
      selectedCinema: selectedCinema ?? this.selectedCinema,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isExtrasLoading,
    detail,
    trailerUrl,
    credits,
    allCinemas,
    selectedCinema,
  ];
}
