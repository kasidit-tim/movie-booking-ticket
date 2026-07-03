import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_ticket/core/theme/app_colors.dart';
import 'package:movie_booking_ticket/core/theme/app_spacing.dart';
import 'package:movie_booking_ticket/core/theme/app_text_styles.dart';
import 'package:movie_booking_ticket/core/widgets/main_app_bar.dart';
import 'package:movie_booking_ticket/gen/assets.gen.dart';

class TicketScreen extends StatelessWidget {
  const TicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: "My ticket"),
      body: ListView.builder(
        padding: EdgeInsets.only(top: 32, left: 16, right: 12),
        itemCount: 10,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildTicketCard(context),
          );
        },
      ),
    );
  }

  Widget _buildTicketCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.card,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              width: 99,
              fit: BoxFit.cover,
              imageUrl:
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQM9TbxAf-nQ_7WcBLbZSXfAIYi9fwMZ9WJ9-vpFqcXAlEiVrbhlv9gRchN&s=10",
            ),
            Gap.w16,
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Avengers: Infinity War",
                    style: context.textTheme.titleLarge,
                  ),
                  Gap.h20,
                  Row(
                    children: [
                      Assets.images.general.clock.svg(height: 16, width: 16),
                      Gap.w4,
                      Text(
                        "14h15 • 16.12.2022",
                        style: context.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  Gap.h12,
                  Row(
                    children: [
                      Assets.images.general.location.svg(height: 16, width: 16),
                      Gap.w4,
                      Text(
                        "Vincom Ocean Park CGV",
                        style: context.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
