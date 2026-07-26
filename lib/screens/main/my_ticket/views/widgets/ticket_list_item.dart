import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_ticket/core/constants/app_constants.dart';
import 'package:movie_booking_ticket/core/theme/app_colors.dart';
import 'package:movie_booking_ticket/core/theme/app_spacing.dart';
import 'package:movie_booking_ticket/core/theme/app_text_styles.dart';
import 'package:movie_booking_ticket/gen/assets.gen.dart';
import 'package:movie_booking_ticket/models/booking_data.dart';

class TicketListItem extends StatelessWidget {
  const TicketListItem({super.key, required this.booking, required this.onTap});

  final BookingData booking;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final showTime = '${booking.time}';
    final date = booking.date!;
    final showDate =
        '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';

    return GestureDetector(
      onTap: onTap,
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
                imageUrl:
                    "${AppConstants.imageW500}${booking.movie.posterPath}",
              ),
              Gap.w16,
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 24, bottom: 36),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.movie.title ?? "",
                        style: context.textTheme.titleLarge,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Gap.h20,
                      Row(
                        children: [
                          Assets.images.general.clock.svg(
                            height: 16,
                            width: 16,
                          ),
                          Gap.w4,
                          Expanded(
                            child: Text(
                              '$showTime • $showDate',
                              style: context.textTheme.bodyMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Gap.h12,
                      Row(
                        children: [
                          Assets.images.general.location.svg(
                            height: 16,
                            width: 16,
                          ),
                          Gap.w4,
                          Expanded(
                            child: Text(
                              booking.cinema.name,
                              style: context.textTheme.bodyMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
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
