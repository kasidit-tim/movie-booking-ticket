import 'package:movie_booking_ticket/models/booking_data.dart';

class TicketDetailArgs {
  final BookingData bookingData;
  final String? backRoute;

  TicketDetailArgs({required this.bookingData, this.backRoute});
}
