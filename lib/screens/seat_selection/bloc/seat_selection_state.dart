part of 'seat_selection_bloc.dart';

class SeatSelectionState extends Equatable {
  final Set<String> selectedSeats;
  final Set<String> reservedSeats;
  final DateTime? selectedDate;
  final String? selectedTime;

  static const double seatPrice = 210;

  const SeatSelectionState({
    this.selectedSeats = const {},
    this.reservedSeats = const {'G7', 'G8', 'G9', 'G10', 'G11', 'G12'},
    this.selectedDate,
    this.selectedTime,
  });

  double get totalPrice => selectedSeats.length * seatPrice;

  bool get isDateTimeSelected => selectedDate != null && selectedTime != null;

  SeatSelectionState copyWith({
    Set<String>? selectedSeats,
    Set<String>? reservedSeats,
    DateTime? selectedDate,
    String? selectedTime,
    bool clearDate = false,
    bool clearTime = false,
  }) {
    return SeatSelectionState(
      selectedSeats: selectedSeats ?? this.selectedSeats,
      reservedSeats: reservedSeats ?? this.reservedSeats,
      selectedDate: clearDate ? null : (selectedDate ?? this.selectedDate),
      selectedTime: clearTime ? null : (selectedTime ?? this.selectedTime),
    );
  }

  @override
  List<Object?> get props => [
    selectedSeats,
    reservedSeats,
    selectedDate,
    selectedTime,
  ];
}
