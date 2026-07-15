import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'seat_selection_event.dart';
part 'seat_selection_state.dart';

class SeatSelectionBloc extends Bloc<SeatSelectionEvent, SeatSelectionState> {
  SeatSelectionBloc() : super(const SeatSelectionState()) {
    on<ToggleSeatEvent>(_onToggleSeat);
    on<SelectDateEvent>(_onSelectDate);
    on<SelectTimeEvent>(_onSelectTime);
  }

  void _onToggleSeat(
      ToggleSeatEvent event, Emitter<SeatSelectionState> emit) {
    final currentSeats = Set<String>.from(state.selectedSeats);
    if (currentSeats.contains(event.seatNo)) {
      currentSeats.remove(event.seatNo);
    } else {
      currentSeats.add(event.seatNo);
    }
    emit(state.copyWith(selectedSeats: currentSeats));
  }

  void _onSelectDate(
      SelectDateEvent event, Emitter<SeatSelectionState> emit) {
    emit(state.copyWith(selectedDate: event.date));
  }

  void _onSelectTime(
      SelectTimeEvent event, Emitter<SeatSelectionState> emit) {
    emit(state.copyWith(selectedTime: event.time));
  }
}