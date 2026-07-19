import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_booking_ticket/core/theme/app_colors.dart';
import 'package:movie_booking_ticket/core/theme/app_spacing.dart';
import 'package:movie_booking_ticket/core/theme/app_text_styles.dart';
import 'package:movie_booking_ticket/models/movie/movie_data.dart';
import 'package:movie_booking_ticket/screens/movie_detail/bloc/movie_detail_bloc.dart';
import 'package:movie_booking_ticket/screens/movie_detail/views/widgets/movie_detail_people_section.dart';
import 'package:readmore/readmore.dart';

class MovieDetailContent extends StatelessWidget {
  const MovieDetailContent({
    super.key,
    required this.movie,
    required this.isComingSoon,
  });

  final MovieDataModel? movie;
  final bool isComingSoon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap.h32,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              _LabelValueRow(
                label: 'Movie genre',
                value: movie?.getGenres ?? '',
              ),
              Gap.h16,
              _LabelValueRow(
                label: 'Censorship',
                value: movie?.thaiCertification ?? '-',
              ),
              Gap.h16,
              _LabelValueRow(
                label: 'Language',
                value: movie?.originalLanguage?.toUpperCase() ?? '',
              ),
            ],
          ),
        ),
        Gap.h32,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _StorylineSection(overview: movie?.overview ?? ''),
        ),
        Gap.h32,
        const DirectorSection(),
        Gap.h32,
        const CastSection(),
        Gap.h32,
        isComingSoon ? SizedBox(height: 200) : const _CinemaSection(),
      ],
    );
  }
}

class _LabelValueRow extends StatelessWidget {
  const _LabelValueRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            '$label:',
            style: context.textTheme.bodyLarge?.copyWith(
              color: const Color(0xFFCDCDCD),
            ),
          ),
        ),
        Gap.w16,
        Expanded(child: Text(value, style: context.textTheme.titleMedium)),
      ],
    );
  }
}

class _StorylineSection extends StatelessWidget {
  const _StorylineSection({required this.overview});

  final String overview;

  @override
  Widget build(BuildContext context) {
    if (overview.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Storyline', style: context.textTheme.headlineSmall),
        Gap.h24,
        ReadMoreText(
          overview,
          trimLines: 4,
          trimMode: TrimMode.Line,
          trimCollapsedText: ' See more',
          trimExpandedText: ' Show less',
          style: context.textTheme.bodyLarge,
          moreStyle: context.textTheme.titleMedium?.copyWith(
            color: AppColors.primary,
          ),
          lessStyle: context.textTheme.titleMedium?.copyWith(
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}

class _CinemaSection extends StatelessWidget {
  const _CinemaSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Cinema', style: context.textTheme.headlineSmall),
          Gap.h24,
          BlocBuilder<MovieDetailBloc, MovieDetailState>(
            buildWhen: (prev, curr) {
              return prev.selectedCinema != curr.selectedCinema;
            },
            builder: (context, state) {
              final allCinemas = state.allCinemas;
              final selectedCinema = state.selectedCinema;

              return Column(
                children: List.generate(allCinemas.length, (i) {
                  final cinema = allCinemas[i];
                  final isSelected = cinema.id == selectedCinema?.id;
                  return GestureDetector(
                    onTap: () => context.read<MovieDetailBloc>().add(
                      SelectCinemaEvent(newCinema: cinema),
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        border: isSelected
                            ? Border.all(color: AppColors.primary)
                            : null,
                        color: isSelected
                            ? AppColors.cardSelected
                            : AppColors.card,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cinema.name,
                            style: context.textTheme.titleLarge,
                          ),
                          Gap.h16,
                          Text(
                            '${cinema.distance} | ${cinema.address}',
                            style: context.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}
