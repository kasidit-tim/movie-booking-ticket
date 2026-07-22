part of 'main_bloc.dart';

enum PageTab { home, ticket, movie, profile }

class MainState extends Equatable {
  const MainState({this.page = PageTab.home});

  final PageTab page;

  MainState copyWith({PageTab? page}) {
    return MainState(page: page ?? this.page);
  }

  @override
  List<Object> get props => [page];
}
