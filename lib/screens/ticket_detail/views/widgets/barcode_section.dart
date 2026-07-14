import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_ticket/core/theme/app_colors.dart';
import 'package:movie_booking_ticket/core/theme/app_spacing.dart';
import 'package:movie_booking_ticket/core/theme/app_text_styles.dart';

class BarcodeSection extends StatelessWidget {
  const BarcodeSection({super.key, required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          BarcodeWidget(
            barcode: Barcode.code128(),
            height: 100,
            drawText: false,
            data: orderId,
          ),
          Gap.h8,
          Text(
            'Order ID: $orderId',
            style: context.textTheme.bodyMedium?.copyWith(
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
