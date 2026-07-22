import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_ticket/core/theme/app_colors.dart';
import 'package:movie_booking_ticket/core/theme/app_spacing.dart';
import 'package:movie_booking_ticket/core/theme/app_text_styles.dart';
import 'package:movie_booking_ticket/gen/assets.gen.dart';
import 'package:movie_booking_ticket/models/movie/movie_data.dart';

class TicketCard extends StatelessWidget {
  const TicketCard({
    super.key,
    required this.movie,
    required this.cinemaName,
    required this.dateTimeDisplay,
  });

  final MovieDataModel movie;
  final String cinemaName;
  final String dateTimeDisplay;

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
                imageUrl: movie.getPosterImgW500,
              ),
              Gap.w16,
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title ?? "",
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
                        text: movie.getGenres,
                      ),
                      Gap.h8,
                      _InfoRow(
                        icon: Assets.images.general.location.svg(
                          height: 16,
                          width: 16,
                        ),
                        text: cinemaName,
                      ),
                      Gap.h8,
                      _InfoRow(
                        icon: Assets.images.general.clock.svg(
                          height: 16,
                          width: 16,
                        ),
                        text: dateTimeDisplay,
                      ),
                    ],
                  ),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        icon,
        Gap.w4,
        Expanded(child: Text(text, style: context.textTheme.bodyMedium)),
      ],
    );
  }
}
