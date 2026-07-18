import 'package:flutter/material.dart';
import 'package:movie_booking_ticket/core/theme/app_colors.dart';
import 'package:movie_booking_ticket/core/theme/app_spacing.dart';
import 'package:movie_booking_ticket/models/booking_data.dart';
import 'package:movie_booking_ticket/screens/ticket_detail/views/widgets/barcode_section.dart';
import 'package:movie_booking_ticket/screens/ticket_detail/views/widgets/perforated_divider.dart';
import 'package:movie_booking_ticket/screens/ticket_detail/views/widgets/ticket_info.dart';

class TicketCard extends StatelessWidget {
  const TicketCard({super.key, required this.booking});

  final BookingData booking;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 24, bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TicketInfo(booking: booking),
          ),
          const PerforatedDivider(),
          Gap.h20,
          BarcodeSection(orderId: booking.orderId ?? ''),
        ],
      ),
    );
  }
}
