import 'package:flutter/material.dart';
import 'package:movie_booking_ticket/core/routes/app_router.dart';
import 'package:movie_booking_ticket/core/theme/app_theme.dart';

void main() {
  runApp(const MovieBookingTicket());
}

class MovieBookingTicket extends StatelessWidget {
  const MovieBookingTicket({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      title: 'Movie Booking Ticket',
      theme: AppTheme.dark,
    );
  }
}
