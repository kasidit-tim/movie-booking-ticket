import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_booking_ticket/core/widgets/movie_card.dart';
import 'package:movie_booking_ticket/models/movie/movie_data.dart';
import 'package:movie_booking_ticket/screens/main/home/bloc/home_bloc.dart';
import 'package:movie_booking_ticket/screens/main/home/views/widgets/home_section.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ComingSoonList extends StatelessWidget {
  const ComingSoonList({super.key});

  static final _skeletonMovies = List.generate(
    3,
    (_) => MovieDataModel(
      title: 'Loading',
      posterPath: null,
      releaseDate: DateTime(2026, 7, 10),
      genres: [
        Genre(name: "Test A"),
        Genre(name: "Test B"),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (prev, curr) =>
          prev.isComingSoonLoading != curr.isComingSoonLoading,
      builder: (context, state) {
        final isLoading = state.isComingSoonLoading;
        final list = isLoading ? _skeletonMovies : state.comingSoonList;

        if (!isLoading && state.comingSoonList.isEmpty) {
          return const SizedBox();
        }

        return Skeletonizer(
          enabled: isLoading,
          child: HomeSection(
            title: "Coming soon",
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(list.length, (i) {
                  final movieData = list[i];
                  return Padding(
                    padding: EdgeInsets.only(left: i == 0 ? 16 : 0, right: 16),
                    child: SizedBox(
                      width: 175,
                      child: MovieCard(data: movieData, isComingSoon: true),
                    ),
                  );
                }),
              ),
            ),
          ),
        );
      },
    );
  }
}
