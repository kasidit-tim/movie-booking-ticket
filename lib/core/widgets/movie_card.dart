import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_booking_ticket/core/theme/app_colors.dart';
import 'package:movie_booking_ticket/core/theme/app_spacing.dart';
import 'package:movie_booking_ticket/core/theme/app_text_styles.dart';
import 'package:movie_booking_ticket/gen/assets.gen.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              height: 267,
              width: double.infinity,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl:
                    "https://media.themoviedb.org/t/p/w220_and_h330_face/d08HqqeBQSwN8i8MEvpsZ8Cb438.jpg",
              ),
            ),
            Gap.h16,
            Text(
              "Shang chi: Legend of the Ten Rings",
              style: context.textTheme.titleMedium?.copyWith(
                color: AppColors.primary,
              ),
            ),
            Gap.h8,
            Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MovieInfoRow(
                  iconPath: Assets.images.general.star.path,
                  text: "4.0 (982)",
                ),
                MovieInfoRow(
                  iconPath: Assets.images.general.clock.path,
                  text: "2 hour 5 minutes",
                ),
                MovieInfoRow(
                  iconPath: Assets.images.general.video.path,
                  text: "Action, Sci-fi",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MovieInfoRow extends StatelessWidget {
  const MovieInfoRow({super.key, required this.iconPath, required this.text});

  final String iconPath;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(children: [SvgPicture.asset(iconPath), Gap.w8, Text(text)]);
  }
}
