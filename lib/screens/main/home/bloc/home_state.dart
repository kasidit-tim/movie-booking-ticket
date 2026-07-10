part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.movieDataList = const [],
    this.isLoading = false,
    this.comingSoonList = const [],
    this.isComingSoonLoading = false,
  });

  final List<MovieDataModel> movieDataList;
  final bool isLoading;
  final List<MovieDataModel> comingSoonList;
  final bool isComingSoonLoading;

  HomeState copyWith({
    List<MovieDataModel>? movieDataList,
    bool? isLoading,
    List<MovieDataModel>? comingSoonList,
    bool? isComingSoonLoading,
  }) {
    return HomeState(
      movieDataList: movieDataList ?? this.movieDataList,
      isLoading: isLoading ?? this.isLoading,
      comingSoonList: comingSoonList ?? this.comingSoonList,
      isComingSoonLoading: isComingSoonLoading ?? this.isComingSoonLoading,
    );
  }

  @override
  List<Object?> get props => [
    movieDataList,
    isLoading,
    comingSoonList,
    isComingSoonLoading,
  ];
}
