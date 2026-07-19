import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_booking_ticket/core/routes/app_routes.dart';
import 'package:movie_booking_ticket/core/widgets/main_app_bar.dart';
import 'package:movie_booking_ticket/models/booking_data.dart';
import 'package:movie_booking_ticket/screens/ticket_detail/views/widgets/ticket_card.dart';

class TicketDetailScreen extends StatelessWidget {
  const TicketDetailScreen({super.key, required this.booking});

  final BookingData booking;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        context.go(AppRoutes.homeTab);
      },
      child: Scaffold(
        appBar: MainAppBar(
          title: 'My ticket',
          onBack: () {
            context.go(AppRoutes.homeTab);
          },
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
          child: TicketCard(booking: booking),
        ),
      ),
    );
  }
}
