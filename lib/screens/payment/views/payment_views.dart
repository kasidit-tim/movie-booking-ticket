import 'package:flutter/material.dart';
import 'package:movie_booking_ticket/core/theme/app_colors.dart';
import 'package:movie_booking_ticket/core/theme/app_spacing.dart';
import 'package:movie_booking_ticket/core/theme/app_text_styles.dart';
import 'package:movie_booking_ticket/core/widgets/bottom_nav_button.dart';
import 'package:movie_booking_ticket/core/widgets/main_app_bar.dart';
import 'package:movie_booking_ticket/core/widgets/my_textfield.dart';
import 'package:movie_booking_ticket/gen/assets.gen.dart';

import 'widgets/payment_method_list.dart';
import 'widgets/ticket_card.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

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
              const TicketCard(),
              Gap.h32,
              const _OrderInfoSection(),
              Gap.h24,
              const _DiscountCodeInput(),
              Gap.h32,
              const Divider(height: 0),
              Gap.h32,
              const _TotalRow(),
              Gap.h32,
              const PaymentMethodList(),
              Gap.h32,
              const _PaymentTimer(),
              Gap.h32,
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavButton(label: "Continue", onPressed: () {}),
    );
  }
}

class _OrderInfoSection extends StatelessWidget {
  const _OrderInfoSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _DetailRow(label: "Order ID", value: "78889377726"),
        _DetailRow(label: "Seat", value: "H7, H8"),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: context.textTheme.bodyLarge),
        Text(value, style: context.textTheme.titleMedium),
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
  const _TotalRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Total", style: context.textTheme.bodyLarge),
        Text(
          "189 THB",
          style: context.textTheme.headlineSmall?.copyWith(
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}

class _PaymentTimer extends StatelessWidget {
  const _PaymentTimer();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardSelected,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Complete your payment in",
            style: context.textTheme.titleMedium,
          ),
          Text(
            "15:00",
            style: context.textTheme.titleMedium?.copyWith(
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
