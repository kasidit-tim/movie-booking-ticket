import 'package:flutter/material.dart';
import 'package:movie_booking_ticket/core/theme/app_colors.dart';
import 'package:movie_booking_ticket/core/theme/app_spacing.dart';
import 'package:movie_booking_ticket/core/theme/app_text_styles.dart';
import 'package:movie_booking_ticket/core/widgets/bottom_nav_button.dart';
import 'package:movie_booking_ticket/core/widgets/main_app_bar.dart';
import 'package:movie_booking_ticket/core/widgets/my_textfield.dart';
import 'package:movie_booking_ticket/gen/assets.gen.dart';
import 'package:movie_booking_ticket/models/booking_data.dart';

import 'widgets/payment_method_list.dart';
import 'widgets/payment_timer.dart';
import 'widgets/ticket_card.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key, required this.booking});

  final BookingData booking;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: "Payment"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap.h16,
              TicketCard(
                movie: booking.movie,
                dateTimeDisplay: booking.dateTimeDisplay,
              ),
              Gap.h32,
              _OrderInfoSection(
                orderId: booking.orderId,
                seats: booking.seatDisplay,
              ),
              Gap.h24,
              const _DiscountCodeInput(),
              Gap.h32,
              const Divider(height: 0),
              Gap.h32,
              _TotalRow(total: booking.totalPrice),
              Gap.h32,
              const PaymentMethodList(),
              Gap.h32,
              const PaymentTimer(),
              Gap.h32,
            ],
          ),
        ),
      ),
      bottomNavigationBar: MainBottomNavButton(
        label: "Continue",
        onPressed: () {},
      ),
    );
  }
}

class _OrderInfoSection extends StatelessWidget {
  const _OrderInfoSection({required this.orderId, required this.seats});

  final String orderId;
  final String seats;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Order ID", style: context.textTheme.bodyLarge),
            Text(orderId, style: context.textTheme.titleMedium),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(child: Text("Seat", style: context.textTheme.bodyLarge)),
            Expanded(child: Text(seats, style: context.textTheme.titleMedium, textAlign: TextAlign.end)),
          ],
        ),
      ],
    );
  }
}

class _DiscountCodeInput extends StatelessWidget {
  const _DiscountCodeInput();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: MyTextfield(
        hintText: "discount code",
        hintStyle: context.textTheme.bodyMedium?.copyWith(
          color: AppColors.hintText,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 12, right: 8),
          child: Assets.images.general.discount.svg(),
        ),
        suffixIcon: GestureDetector(
          onTap: () {},
          child: Container(
            width: 120,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                "Apply",
                style: context.textTheme.titleMedium?.copyWith(
                  color: AppColors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TotalRow extends StatelessWidget {
  const _TotalRow({required this.total});

  final double total;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Total", style: context.textTheme.bodyLarge),
        Text(
          "${total.toStringAsFixed(2)} THB",
          style: context.textTheme.headlineSmall?.copyWith(
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}

