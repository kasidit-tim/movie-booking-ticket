import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_ticket/core/theme/app_colors.dart';
import 'package:movie_booking_ticket/core/theme/app_spacing.dart';
import 'package:movie_booking_ticket/core/theme/app_text_styles.dart';
import 'package:movie_booking_ticket/gen/assets.gen.dart';

class PaymentMethodList extends StatefulWidget {
  const PaymentMethodList({super.key, this.initialIndex = 2});

  final int initialIndex;

  @override
  State<PaymentMethodList> createState() => _PaymentMethodListState();
}

class _PaymentMethodListState extends State<PaymentMethodList> {
  static const _methodCount = 5;

  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Payment Method", style: context.textTheme.headlineSmall),
        Gap.h24,
        ...List.generate(_methodCount, (i) {
          return PaymentMethodCard(
            isSelected: i == _selectedIndex,
            isLast: i == _methodCount - 1,
            onTap: () => setState(() => _selectedIndex = i),
          );
        }),
      ],
    );
  }
}

class PaymentMethodCard extends StatelessWidget {
  const PaymentMethodCard({
    super.key,
    required this.isSelected,
    required this.isLast,
    this.onTap,
  });

  final bool isSelected;
  final bool isLast;
  final VoidCallback? onTap;

  static const _imageUrl =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSS74rD-okxmYf-TqMpklB7u_BCH1qrYRlIbw03v5AkmReYVgojZvgTWtjx&s=10";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: isLast ? 0 : 16),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.cardSelected : AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: isSelected ? Border.all(color: AppColors.primary) : null,
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: CachedNetworkImage(
                height: 48,
                width: 86,
                fit: BoxFit.cover,
                imageUrl: _imageUrl,
              ),
            ),
            Gap.w16,
            Text("Shopee Pay", style: context.textTheme.titleMedium),
            const Spacer(),
            Assets.images.general.arrowRight.svg(),
          ],
        ),
      ),
    );
  }
}
