import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_booking_ticket/core/theme/app_colors.dart';
import 'package:movie_booking_ticket/gen/assets.gen.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MovieDetailAppBar extends StatelessWidget {
  const MovieDetailAppBar({
    super.key,
    this.posterUrl,
    required this.infoCard,
    required this.isLoading,
  });

  final String? posterUrl;
  final Widget infoCard;
  final bool isLoading;

  static const _leadingPadding = 16.0;
  static const _backButtonSize = 45.0;
  static const _expandedHeight = 325.0;
  static const _posterHeight = 240.0;
  static const _infoCardTopOffset = 160.0;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColors.black.withValues(alpha: 0.85),
      foregroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      leadingWidth: _backButtonSize + _leadingPadding,
      leading: Padding(
        padding: const EdgeInsets.only(left: _leadingPadding),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            context.pop();
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.black.withValues(alpha: 0.3),
            ),
            width: _backButtonSize,
            height: _backButtonSize,
            child: Assets.images.general.arrowLeft.svg(),
          ),
        ),
      ),
      toolbarHeight: kToolbarHeight,
      expandedHeight: _expandedHeight,
      pinned: true,
      flexibleSpace: Skeletonizer(
        enabled: isLoading,
        child: FlexibleSpaceBar(
          background: Container(
            color: AppColors.background,
            child: Stack(
              children: [
                isLoading
                    ? Container(
                        width: double.infinity,
                        height: _posterHeight,
                        color: AppColors.background,
                      )
                    : CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: posterUrl ?? '',
                        height: _posterHeight,
                        width: double.infinity,
                        errorWidget: (_, _, _) => Container(
                          width: double.infinity,
                          height: _posterHeight,
                          color: AppColors.background,
                        ),
                      ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: _infoCardTopOffset,
                  child: Center(child: Skeleton.unite(child: infoCard)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
