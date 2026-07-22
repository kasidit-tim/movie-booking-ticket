import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_ticket/models/cinema.dart';
import 'package:movie_booking_ticket/models/movie/movie_data.dart';

part 'booking_data.g.dart';

@JsonSerializable(explicitToJson: true)
class BookingData {
  final MovieDataModel movie;
  final Cinema cinema;
  final Set<String> seats;
  final double totalPrice;
  final DateTime? date;
  final String? time;
  final String? orderId;

  const BookingData({
    required this.movie,
    required this.cinema,
    this.seats = const {},
    this.totalPrice = 0,
    this.date,
    this.time,
    this.orderId,
  });

  factory BookingData.fromJson(Map<String, dynamic> json) =>
      _$BookingDataFromJson(json);

  Map<String, dynamic> toJson() => _$BookingDataToJson(this);

  BookingData copyWith({
    Set<String>? seats,
    double? totalPrice,
    DateTime? date,
    String? time,
    String? orderId,
  }) {
    return BookingData(
      movie: movie,
      cinema: cinema,
      seats: seats ?? this.seats,
      totalPrice: totalPrice ?? this.totalPrice,
      date: date ?? this.date,
      time: time ?? this.time,
      orderId: orderId ?? this.orderId,
    );
  }

  List<String> get seatLabels => seats.toList()..sort();
  String get seatDisplay => (seats.toList()..sort()).join(', ');
}
