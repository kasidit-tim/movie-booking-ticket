import 'package:movie_booking_ticket/models/movie/movie_data.dart';

class BookingData {
  final MovieDataModel movie;
  final Set<String> seats;
  final double totalPrice;
  final DateTime date;
  final String time;
  final String orderId;

  const BookingData({
    required this.movie,
    required this.seats,
    required this.totalPrice,
    required this.date,
    required this.time,
    required this.orderId,
  });

  List<String> get seatLabels => seats.toList()..sort();
  String get seatDisplay => (seats.toList()..sort()).join(', ');
  String get dateTimeDisplay {
    final months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec",
    ];
    return "$time • ${date.day.toString().padLeft(2, '0')}.${months[date.month - 1]}.${date.year}";
  }
}