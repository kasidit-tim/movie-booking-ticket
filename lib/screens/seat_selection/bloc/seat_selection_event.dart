part of 'seat_selection_bloc.dart';

sealed class SeatSelectionEvent extends Equatable {
  const SeatSelectionEvent();

  @override
  List<Object> get props => [];
}

class ToggleSeatEvent extends SeatSelectionEvent {
  final String seatNo;

  const ToggleSeatEvent(this.seatNo);

  @override
  List<Object> get props => [seatNo];
}

class SelectDateEvent extends SeatSelectionEvent {
  final DateTime date;

  const SelectDateEvent(this.date);

  @override
  List<Object> get props => [date];
}

class SelectTimeEvent extends SeatSelectionEvent {
  final String time;

  const SelectTimeEvent(this.time);

  @override
  List<Object> get props => [time];
}