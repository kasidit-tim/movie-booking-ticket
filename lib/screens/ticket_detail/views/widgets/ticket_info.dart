import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_ticket/core/theme/app_colors.dart';
import 'package:movie_booking_ticket/core/theme/app_spacing.dart';
import 'package:movie_booking_ticket/core/theme/app_text_styles.dart';
import 'package:movie_booking_ticket/gen/assets.gen.dart';
import 'package:movie_booking_ticket/screens/ticket_detail/models/ticket_detail_data.dart';

class TicketInfo extends StatelessWidget {
  const TicketInfo({super.key, required this.ticket});

  final TicketDetailData ticket;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Column(
      children: [
        _MovieHeader(ticket: ticket, textTheme: textTheme),
        const SizedBox(height: 35),
        _ShowtimeRow(ticket: ticket, textTheme: textTheme),
        Gap.h32,
        const Divider(height: 0, thickness: 0.5),
        Gap.h16,
        _VenueDetails(ticket: ticket, textTheme: textTheme),
      ],
    );
  }
}

class _MovieHeader extends StatelessWidget {
  const _MovieHeader({required this.ticket, required this.textTheme});

  final TicketDetailData ticket;
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
            imageUrl: ticket.posterUrl,
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
                ticket.movieTitle,
                style: textTheme.titleLarge?.copyWith(color: AppColors.black),
              ),
              Gap.h8,
              _InfoRow(
                icon: Assets.images.general.clock.svg(
                  height: 20,
                  width: 20,
                  color: AppColors.black,
                ),
                text: ticket.duration,
                textTheme: textTheme,
              ),
              Gap.h4,
              _InfoRow(
                icon: Assets.images.general.video.svg(
                  height: 20,
                  width: 20,
                  color: AppColors.black,
                ),
                text: ticket.genres,
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
      children: [
        icon,
        Gap.w8,
        Text(
          text,
          style: textTheme.bodyMedium?.copyWith(color: AppColors.black),
        ),
      ],
    );
  }
}

class _ShowtimeRow extends StatelessWidget {
  const _ShowtimeRow({required this.ticket, required this.textTheme});

  final TicketDetailData ticket;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _IconDetailTile(
          icon: Assets.images.ticketDetail.calendar.svg(),
          line1: ticket.showTime,
          line2: ticket.showDate,
          textTheme: textTheme,
        ),
        _IconDetailTile(
          icon: Assets.images.ticketDetail.seatCinema.svg(),
          line1: "Section ${ticket.section}",
          line2: "Seat ${ticket.seats.join(',')}",
          textTheme: textTheme,
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
        Column(
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
      ],
    );
  }
}

class _VenueDetails extends StatelessWidget {
  const _VenueDetails({required this.ticket, required this.textTheme});

  final TicketDetailData ticket;
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
              "${ticket.price.toStringAsFixed(2)} THB",
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
                    ticket.cinemaName,
                    style: textTheme.titleMedium?.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  Gap.h4,
                  Text(
                    ticket.cinemaAddress,
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
                ticket.note,
                style: textTheme.bodyMedium?.copyWith(color: AppColors.black),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
