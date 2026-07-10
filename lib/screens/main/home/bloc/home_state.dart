part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.movieDataList = const [],
    this.isLoading = false,
    this.isLoadingDetail = false,
    this.comingSoonList = const [],
    this.isComingSoonLoading = false,
  });

  final List<MovieDataModel> movieDataList;
  final bool isLoading;
  final bool isLoadingDetail;
  final List<MovieDataModel> comingSoonList;
  final bool isComingSoonLoading;

  HomeState copyWith({
    List<MovieDataModel>? movieDataList,
    bool? isLoading,
    bool? isLoadingDetail,
    List<MovieDataModel>? comingSoonList,
    bool? isComingSoonLoading,
  }) {
    return HomeState(
      movieDataList: movieDataList ?? this.movieDataList,
      isLoading: isLoading ?? this.isLoading,
      isLoadingDetail: isLoadingDetail ?? this.isLoadingDetail,
      comingSoonList: comingSoonList ?? this.comingSoonList,
      isComingSoonLoading: isComingSoonLoading ?? this.isComingSoonLoading,
    );
  }

  @override
  List<Object?> get props => [
    movieDataList,
    isLoading,
    isLoadingDetail,
    comingSoonList,
    isComingSoonLoading,
  ];
}
