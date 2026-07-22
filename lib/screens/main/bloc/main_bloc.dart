import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainState()) {
    on<NavigateToTabEvent>(_onNavigateToTabEvent);
  }

  void _onNavigateToTabEvent(NavigateToTabEvent event, Emitter<MainState> emit) {
    emit(state.copyWith(page: event.page));
  }
}
