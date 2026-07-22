import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_booking_ticket/core/widgets/main_app_bar.dart';
import 'package:movie_booking_ticket/screens/ticket_detail/data/ticket_detail_args.dart';
import 'package:movie_booking_ticket/screens/ticket_detail/views/widgets/ticket_card.dart';

class TicketDetailScreen extends StatelessWidget {
  const TicketDetailScreen({super.key, required this.args});

  final TicketDetailArgs args;

  void handleBack(BuildContext context) {
    if (args.backRoute != null) {
      context.go(args.backRoute!);
    } else {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          handleBack(context);
        }
      },
      child: Scaffold(
        appBar: MainAppBar(
          title: 'My ticket',
          onBack: () => handleBack(context),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
          child: TicketCard(booking: args.bookingData),
        ),
      ),
    );
  }
}
