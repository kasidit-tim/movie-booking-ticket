import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_booking_ticket/core/theme/app_colors.dart';
import 'package:movie_booking_ticket/core/theme/app_spacing.dart';
import 'package:movie_booking_ticket/core/theme/app_text_styles.dart';
import 'package:movie_booking_ticket/gen/assets.gen.dart';
import 'package:movie_booking_ticket/models/movie/movie_data.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    super.key,
    this.showRatingStar = true,
    required this.data,
    this.isComingSoon = false,
  });

  final bool showRatingStar;
  final MovieDataModel data;
  final bool isComingSoon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint("=====> movie card");
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
              child: data.getPosterImgW500.isEmpty
                  ? Container(
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    )
                  : CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: data.getPosterImgW500,
                    ),
            ),
            Gap.h16,
            Text(
              "${data.title}",
              style: context.textTheme.titleMedium?.copyWith(
                color: AppColors.primary,
              ),
            ),
            Gap.h8,
            Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showRatingStar)
                  MovieInfoRow(
                    iconPath: Assets.images.general.star.path,
                    text: "${data.voteAverage} (${data.voteCount})",
                  ),
                isComingSoon
                    ? MovieInfoRow(
                        iconPath: Assets.images.general.calendar.path,
                        text: data.getReleaseDate,
                      )
                    : MovieInfoRow(
                        iconPath: Assets.images.general.clock.path,
                        text: data.runTime,
                      ),
                MovieInfoRow(
                  iconPath: Assets.images.general.video.path,
                  text: data.getGenres,
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
    return Row(
      children: [
        SvgPicture.asset(iconPath),
        Gap.w8,
        Expanded(
          child: Text(text, maxLines: 1, overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }
}
