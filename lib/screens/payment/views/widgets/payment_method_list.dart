import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_ticket/core/theme/app_colors.dart';
import 'package:movie_booking_ticket/core/theme/app_spacing.dart';
import 'package:movie_booking_ticket/core/theme/app_text_styles.dart';
import 'package:movie_booking_ticket/gen/assets.gen.dart';
import 'package:movie_booking_ticket/screens/payment/data/payment_method.dart';

class PaymentMethodList extends StatefulWidget {
  const PaymentMethodList({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<PaymentMethodList> createState() => _PaymentMethodListState();
}

class _PaymentMethodListState extends State<PaymentMethodList> {
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
        Text('Payment Method', style: context.textTheme.headlineSmall),
        Gap.h24,
        ...List.generate(PaymentMethod.mockMethods.length, (i) {
          final method = PaymentMethod.mockMethods[i];
          return _PaymentMethodCard(
            method: method,
            isSelected: i == _selectedIndex,
            isLast: i == PaymentMethod.mockMethods.length - 1,
            onTap: () => setState(() => _selectedIndex = i),
          );
        }),
      ],
    );
  }
}

class _PaymentMethodCard extends StatelessWidget {
  const _PaymentMethodCard({
    required this.method,
    required this.isSelected,
    required this.isLast,
    this.onTap,
  });

  final PaymentMethod method;
  final bool isSelected;
  final bool isLast;
  final VoidCallback? onTap;

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
                imageUrl: method.iconUrl,
              ),
            ),
            Gap.w16,
            Text(method.name, style: context.textTheme.titleMedium),
            const Spacer(),
            Assets.images.general.arrowRight.svg(),
          ],
        ),
      ),
    );
  }
}
