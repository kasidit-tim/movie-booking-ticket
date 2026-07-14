import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_ticket/core/theme/app_colors.dart';
import 'package:movie_booking_ticket/core/theme/app_spacing.dart';
import 'package:movie_booking_ticket/core/theme/app_text_styles.dart';
import 'package:movie_booking_ticket/gen/assets.gen.dart';

class TicketCard extends StatelessWidget {
  const TicketCard({super.key});

  static const _imageUrl =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM9TbxAf-nQ_7WcBLbZSXfAIYi9fwMZ9WJ9-vpFqcXAlEiVrbhlv9gRchN&s=10";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.card,
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CachedNetworkImage(
                width: 99,
                fit: BoxFit.cover,
                imageUrl: _imageUrl,
              ),
              Gap.w16,
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Avengers: Infinity War",
                      style: context.textTheme.titleLarge?.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    Gap.h16,
                    _InfoRow(
                      icon: Assets.images.general.videoPlay.svg(
                        height: 16,
                        width: 16,
                      ),
                      text: "Acton, adventure, sci-fi",
                    ),
                    Gap.h8,
                    _InfoRow(
                      icon: Assets.images.general.location.svg(
                        height: 16,
                        width: 16,
                      ),
                      text: "Vincom Ocean Park CGV",
                    ),
                    Gap.h8,
                    _InfoRow(
                      icon: Assets.images.general.clock.svg(
                        height: 16,
                        width: 16,
                      ),
                      text: "14h15 • 16.12.2022",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.text});

  final Widget icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        Gap.w4,
        Text(text, style: context.textTheme.bodyMedium),
      ],
    );
  }
}
