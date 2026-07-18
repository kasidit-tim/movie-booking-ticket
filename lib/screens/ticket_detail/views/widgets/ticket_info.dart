import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_ticket/core/theme/app_colors.dart';
import 'package:movie_booking_ticket/core/theme/app_spacing.dart';
import 'package:movie_booking_ticket/core/theme/app_text_styles.dart';
import 'package:movie_booking_ticket/gen/assets.gen.dart';
import 'package:movie_booking_ticket/models/booking_data.dart';
import 'package:movie_booking_ticket/models/movie/movie_data.dart';

class TicketInfo extends StatelessWidget {
  const TicketInfo({super.key, required this.booking});

  final BookingData booking;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Column(
      children: [
        _MovieHeader(movie: booking.movie, textTheme: textTheme),
        const SizedBox(height: 35),
        _ShowtimeRow(booking: booking, textTheme: textTheme),
        Gap.h32,
        const Divider(height: 0, thickness: 0.5),
        Gap.h16,
        _VenueDetails(booking: booking, textTheme: textTheme),
      ],
    );
  }
}

class _MovieHeader extends StatelessWidget {
  const _MovieHeader({required this.movie, required this.textTheme});

  final MovieDataModel movie;
  final TextTheme textTheme;

  static const _posterHeight = 177.0;
  static const _posterWidth = 125.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          child: CachedNetworkImage(
            imageUrl: movie.getPosterImgW500,
            fit: BoxFit.cover,
            height: _posterHeight,
            width: _posterWidth,
          ),
        ),
        Gap.w16,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap.h20,
              Text(
                movie.title ?? '',
                style: textTheme.titleLarge?.copyWith(color: AppColors.black),
              ),
              Gap.h8,
              _InfoRow(
                icon: Assets.images.general.clock.svg(
                  height: 20,
                  width: 20,
                  color: AppColors.black,
                ),
                text: movie.shortRunTime,
                textTheme: textTheme,
              ),
              Gap.h4,
              _InfoRow(
                icon: Assets.images.general.video.svg(
                  height: 20,
                  width: 20,
                  color: AppColors.black,
                ),
                text: movie.getGenres,
                textTheme: textTheme,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.text,
    required this.textTheme,
  });

  final Widget icon;
  final String text;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        icon,
        Gap.w8,
        Expanded(
          child: Text(
            text,
            style: textTheme.bodyMedium?.copyWith(color: AppColors.black),
          ),
        ),
      ],
    );
  }
}

class _ShowtimeRow extends StatelessWidget {
  const _ShowtimeRow({required this.booking, required this.textTheme});

  final BookingData booking;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    final showTime = '${booking.time}';
    final date = booking.date!;
    final showDate =
        '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';

    return Row(
      children: [
        Expanded(
          child: _IconDetailTile(
            icon: Assets.images.ticketDetail.calendar.svg(),
            line1: showTime,
            line2: showDate,
            textTheme: textTheme,
          ),
        ),
        Expanded(
          child: _IconDetailTile(
            icon: Assets.images.ticketDetail.seatCinema.svg(),
            line1: 'Section 4',
            line2: 'Seat ${booking.seatLabels.join(',')}',
            textTheme: textTheme,
          ),
        ),
      ],
    );
  }
}

class _IconDetailTile extends StatelessWidget {
  const _IconDetailTile({
    required this.icon,
    required this.line1,
    required this.line2,
    required this.textTheme,
  });

  final Widget icon;
  final String line1;
  final String line2;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        icon,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                line1,
                style: textTheme.titleMedium?.copyWith(color: AppColors.black),
              ),
              Text(
                line2,
                style: textTheme.titleMedium?.copyWith(color: AppColors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _VenueDetails extends StatelessWidget {
  const _VenueDetails({required this.booking, required this.textTheme});

  final BookingData booking;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          spacing: 10,
          children: [
            Assets.images.ticketDetail.moneySend.svg(),
            Text(
              '${booking.totalPrice.toStringAsFixed(2)} THB',
              style: textTheme.titleMedium?.copyWith(color: AppColors.black),
            ),
          ],
        ),
        Gap.h8,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Assets.images.ticketDetail.location.svg(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    booking.cinema.name,
                    style: textTheme.titleMedium?.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  Gap.h4,
                  Text(
                    booking.cinema.address,
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Gap.h8,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Assets.images.ticketDetail.note.svg(),
            Expanded(
              child: Text(
                'Show this QR code to the ticket counter to receive your ticket',
                style: textTheme.bodyMedium?.copyWith(color: AppColors.black),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
