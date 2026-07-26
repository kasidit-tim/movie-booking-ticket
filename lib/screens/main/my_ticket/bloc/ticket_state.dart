part of 'ticket_bloc.dart';

class TicketState extends Equatable {
  const TicketState({
    this.bookings = const [],
    this.isLoading = false,
  });

  final List<BookingData> bookings;
  final bool isLoading;

  TicketState copyWith({List<BookingData>? bookings, bool? isLoading}) {
    return TicketState(
      bookings: bookings ?? this.bookings,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [bookings, isLoading];
}