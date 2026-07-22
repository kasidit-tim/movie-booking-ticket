part of 'main_bloc.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}

class NavigateToTabEvent extends MainEvent {
  const NavigateToTabEvent({required this.page});

  final PageTab page;

  @override
  List<Object> get props => [page];
}
