import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_booking_ticket/core/routes/app_routes.dart';
import 'package:movie_booking_ticket/core/theme/app_colors.dart';
import 'package:movie_booking_ticket/core/theme/app_spacing.dart';
import 'package:movie_booking_ticket/core/theme/app_text_styles.dart';
import 'package:movie_booking_ticket/gen/assets.gen.dart';
import 'package:movie_booking_ticket/models/movie/movie_data.dart';
import 'package:movie_booking_ticket/models/movie_detail_args.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.data, this.isComingSoon = false});

  final MovieDataModel data;
  final bool isComingSoon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          '${AppRoutes.movieDetail}/${data.id}',
          extra: MovieDetailArgs(isComingSoon: isComingSoon),
        );
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
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Gap.h8,
            Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isComingSoon)
                  MovieInfoRow(
                    iconPath: Assets.images.general.star.path,
                    text: "${data.voteAverage} (${data.voteCount})",
                  ),
                Skeletonizer(
                  enabled: !data.hasDetail,
                  child: Column(
                    children: [
                      isComingSoon
                          ? MovieInfoRow(
                              iconPath: Assets.images.general.calendar.path,
                              text: data.getReleaseDate,
                            )
                          : MovieInfoRow(
                              iconPath: Assets.images.general.clock.path,
                              text: data.runTime.isNotEmpty
                                  ? data.runTime
                                  : "1h 30min",
                            ),
                      MovieInfoRow(
                        iconPath: Assets.images.general.video.path,
                        text: data.getGenres.isNotEmpty
                            ? data.getGenres
                            : "Action, Drama",
                      ),
                    ],
                  ),
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
