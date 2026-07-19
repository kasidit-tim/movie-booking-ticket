import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_booking_ticket/core/theme/app_colors.dart';
import 'package:movie_booking_ticket/core/theme/app_spacing.dart';
import 'package:movie_booking_ticket/core/theme/app_text_styles.dart';
import 'package:movie_booking_ticket/screens/movie_detail/bloc/movie_detail_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PersonData {
  const PersonData({required this.name, required this.imageUrl});

  final String name;
  final String imageUrl;

  static final skeletonList = List.generate(
    5,
    (i) => const PersonData(name: 'Placeholder Name', imageUrl: ''),
  );
}

class DirectorSection extends StatelessWidget {
  const DirectorSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailBloc, MovieDetailState>(
      buildWhen: (prev, curr) => prev.isExtrasLoading != curr.isExtrasLoading,
      builder: (context, state) {
        final isExtrasLoading = state.isExtrasLoading;
        final directors = state.directors;

        if (!isExtrasLoading && directors.isEmpty) {
          return const SizedBox.shrink();
        }

        final people = isExtrasLoading
            ? PersonData.skeletonList
            : directors
                  .map(
                    (d) =>
                        PersonData(name: d.name, imageUrl: d.profileImageUrl),
                  )
                  .toList();

        return Skeletonizer(
          enabled: isExtrasLoading,
          child: PersonChipRow(title: 'Director', people: people),
        );
      },
    );
  }
}

class CastSection extends StatelessWidget {
  const CastSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailBloc, MovieDetailState>(
      buildWhen: (prev, curr) => prev.isExtrasLoading != curr.isExtrasLoading,
      builder: (context, state) {
        final isExtrasLoading = state.isExtrasLoading;
        final cast = state.topCast;

        if (!isExtrasLoading && cast.isEmpty) return const SizedBox.shrink();

        final people = isExtrasLoading
            ? PersonData.skeletonList
            : cast
                  .map(
                    (c) =>
                        PersonData(name: c.name, imageUrl: c.profileImageUrl),
                  )
                  .toList();

        return Skeletonizer(
          enabled: isExtrasLoading,
          child: PersonChipRow(title: 'Actor', people: people),
        );
      },
    );
  }
}

class PersonChipRow extends StatelessWidget {
  const PersonChipRow({super.key, required this.title, required this.people});

  final String title;
  final List<PersonData> people;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(title, style: context.textTheme.headlineSmall),
        ),
        Gap.h24,
        SizedBox(
          height: 58,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: people.length,
            separatorBuilder: (_, _) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final person = people[index];
              return Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: person.imageUrl,
                        width: 36,
                        height: 36,
                        fit: BoxFit.cover,
                        errorWidget: (_, _, _) => Container(
                          width: 36,
                          height: 36,
                          color: AppColors.card,
                          child: const Icon(Icons.person, size: 20),
                        ),
                      ),
                    ),
                    Gap.w12,
                    SizedBox(
                      width: 78,
                      child: Text(
                        person.name,
                        style: context.textTheme.bodyMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
