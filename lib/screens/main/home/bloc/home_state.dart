part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.movieDataList = const [],
    this.isLoading = false,
    this.isLoadingDetail = false,
  });

  final List<MovieDataModel> movieDataList;
  final bool isLoading;
  final bool isLoadingDetail;

  HomeState copyWith({
    List<MovieDataModel>? movieDataList,
    bool? isLoading,
    bool? isLoadingDetail,
  }) {
    return HomeState(
      movieDataList: movieDataList ?? this.movieDataList,
      isLoading: isLoading ?? this.isLoading,
      isLoadingDetail: isLoadingDetail ?? this.isLoadingDetail,
    );
  }

  @override
  List<Object?> get props => [movieDataList, isLoading, isLoadingDetail];
}
