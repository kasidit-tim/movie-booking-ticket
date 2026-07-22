import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_booking_ticket/models/booking_data.dart';
import 'package:movie_booking_ticket/screens/main/ticket/data/booking_repository.dart';

part 'ticket_event.dart';
part 'ticket_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  TicketBloc(this._repository) : super(const TicketState()) {
    on<LoadBookingsEvent>(_onLoadBookings);
  }

  final BookingRepository _repository;

  void _onLoadBookings(LoadBookingsEvent event, Emitter<TicketState> emit) {
    emit(state.copyWith(isLoading: true));
    final bookings = _repository.getBookings();
    emit(state.copyWith(bookings: bookings, isLoading: false));
  }
}