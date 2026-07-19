import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_booking_ticket/core/theme/app_colors.dart';
import 'package:movie_booking_ticket/core/theme/app_spacing.dart';
import 'package:movie_booking_ticket/core/theme/app_text_styles.dart';
import 'package:movie_booking_ticket/core/widgets/tap_wrapper.dart';
import 'package:movie_booking_ticket/gen/assets.gen.dart';
import 'package:movie_booking_ticket/models/movie/movie_data.dart';
import 'package:movie_booking_ticket/screens/movie_detail/bloc/movie_detail_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieInfoCard extends StatelessWidget {
  const MovieInfoCard({super.key, required this.movie});

  final MovieDataModel? movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(movie?.title ?? '', style: context.textTheme.headlineSmall),
          Text(
            '${movie?.shortRunTime ?? ''} • ${movie?.getReleaseDate ?? ''}',
            style: context.textTheme.bodyLarge?.copyWith(color: AppColors.grey),
          ),
          const SizedBox(height: 40),
          _buildRatingRow(context, movie),
          Gap.h12,
          _buildTrailerRow(context),
        ],
      ),
    );
  }

  Widget _buildRatingRow(BuildContext context, MovieDataModel? movie) {
    return Row(
      children: [
        Text('Review', style: context.textTheme.titleMedium),
        Gap.w8,
        Assets.images.general.star.svg(height: 16, width: 16),
        Gap.w4,
        Text(
          '${movie?.voteAverage?.toStringAsFixed(1) ?? '0'} ',
          style: context.textTheme.titleMedium,
        ),
        Text('(${movie?.voteCount ?? 0})', style: context.textTheme.bodySmall),
      ],
    );
  }

  Widget _buildTrailerRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              5,
              (_) => Assets.images.general.star.svg(
                height: 32,
                width: 32,
                color: const Color(0xFF575757),
              ),
            ),
          ),
        ),
        const SizedBox(width: 28),
        BlocBuilder<MovieDetailBloc, MovieDetailState>(
          buildWhen: (prev, curr) =>
              prev.isExtrasLoading != curr.isExtrasLoading,
          builder: (context, state) {
            if (!state.isExtrasLoading && state.trailerUrl.isEmpty) {
              return const SizedBox.shrink();
            }

            return Skeletonizer(
              enabled: state.isExtrasLoading,
              child: _TrailerButton(url: state.trailerUrl),
            );
          },
        ),
      ],
    );
  }
}

class _TrailerButton extends StatelessWidget {
  const _TrailerButton({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return TapWrapper(
      onTap: () => launchUrl(Uri.parse(url)),
      borderRadius: BorderRadius.circular(4),
      child: Skeleton.unite(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: AppColors.grey, width: 1),
          ),
          child: Row(
            spacing: 4,
            children: [
              const Icon(Icons.play_arrow),
              Text('Watch trailer', style: context.textTheme.titleSmall),
            ],
          ),
        ),
      ),
    );
  }
}
