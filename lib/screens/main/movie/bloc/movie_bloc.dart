import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MovieState()) {
    on<ChangeTabEvent>(_onChangeTabEvent);
  }

  void _onChangeTabEvent(ChangeTabEvent event, Emitter<MovieState> emit) {
    emit(state.copyWith(tab: event.tab));
  }
}
