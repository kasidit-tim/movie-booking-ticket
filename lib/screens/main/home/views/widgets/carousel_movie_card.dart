import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_booking_ticket/core/constants/app_constants.dart';
import 'package:movie_booking_ticket/core/theme/app_colors.dart';
import 'package:movie_booking_ticket/core/theme/app_spacing.dart';
import 'package:movie_booking_ticket/core/theme/app_text_styles.dart';
import 'package:movie_booking_ticket/gen/assets.gen.dart';
import 'package:movie_booking_ticket/models/movie/movie_data.dart';
import 'package:movie_booking_ticket/screens/main/home/bloc/home_bloc.dart';
import 'package:movie_booking_ticket/screens/main/home/views/widgets/home_section.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CarouselMovieCard extends StatefulWidget {
  const CarouselMovieCard({super.key});

  @override
  State<CarouselMovieCard> createState() => _CarouselMovieCardState();
}

class _CarouselMovieCardState extends State<CarouselMovieCard> {
  int _currentPage = 0;

  static final _skeletonMovie = MovieDataModel(
    title: 'Loading Title',
    posterPath: '',
    voteAverage: 8.0,
    voteCount: 1000,
    runtime: 120,
    genres: [
      Genre(name: "Test"),
      Genre(name: "Test"),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (prev, curr) => prev.isLoading != curr.isLoading,
      builder: (context, state) {
        if (state.isLoading) {
          return _buildSkeleton();
        }
        if (state.movieDataList.isEmpty) {
          return const SizedBox();
        }
        return _buildContent(state.movieDataList);
      },
    );
  }

  Widget _buildSkeleton() {
    return Skeletonizer(
      enabled: true,
      child: HomeSection(
        title: "Now Playing",
        child: Column(
          children: [
            _buildCarousel([_skeletonMovie], isSkeleton: true),
            Gap.h16,
            _buildSkeletonInfo(),
            const SizedBox(height: 12),
            CarouselIndicator(currentPage: 0, itemCount: 1),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(List<MovieDataModel> movieDataList) {
    final movieData = movieDataList[_currentPage];
    return HomeSection(
      title: "Now Playing",
      child: Column(
        children: [
          _buildCarousel(movieDataList),
          Gap.h16,
          _buildMovieInfo(movieData),
          const SizedBox(height: 12),
          CarouselIndicator(
            currentPage: _currentPage,
            itemCount: movieDataList.length,
          ),
        ],
      ),
    );
  }

  Widget _buildSkeletonInfo() {
    return Column(
      children: [
        Text("Loading Title", style: context.textTheme.headlineSmall),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            "1h 30min • Horror, Action",
            style: context.textTheme.bodyLarge?.copyWith(color: AppColors.grey),
          ),
        ),
        Text("8.0 (1000)", style: context.textTheme.titleMedium),
      ],
    );
  }

  Widget _buildCarousel(
    List<MovieDataModel> movieDataList, {
    bool isSkeleton = false,
  }) {
    return CarouselSlider.builder(
      itemCount: movieDataList.length,
      itemBuilder: (context, i, _) {
        final isCenter = _currentPage == i;
        final movie = movieDataList[i];
        return GestureDetector(
          onTap: isSkeleton ? null : () => debugPrint("====> carousel $i"),
          child: Stack(
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.card,
                ),
                child: isSkeleton
                    ? const SizedBox.expand()
                    : CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl:
                            "${AppConstants.imageW500}${movie.posterPath}",
                        errorWidget: (_, _, error) => Container(
                          color: AppColors.card,
                          alignment: Alignment.center,
                        ),
                      ),
              ),
              if (!isCenter)
                Positioned.fill(child: Container(color: Colors.black45)),
            ],
          ),
        );
      },
      options: CarouselOptions(
        aspectRatio: 1,
        initialPage: _currentPage,
        onPageChanged: (index, reason) {
          setState(() => _currentPage = index);
          final newMovie = movieDataList[index];
          if (newMovie.id != null && newMovie.runtime == null) {
            context.read<HomeBloc>().add(LoadMovieDetailById(id: newMovie.id!));
          }
        },
        enlargeCenterPage: true,
        enlargeFactor: 0.25,
        viewportFraction: 0.65,
      ),
    );
  }

  Widget _buildMovieInfo(MovieDataModel movieData) {
    return Column(
      children: [
        Text(movieData.title ?? "", style: context.textTheme.headlineSmall),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (prev, curr) =>
                prev.isLoadingDetail != curr.isLoadingDetail,
            builder: (context, state) {
              final movie = state.movieDataList[_currentPage];

              if (state.isLoadingDetail && movie.runtime == null) {
                return Skeletonizer(
                  child: Text(
                    "1h 30min • Horror, Action",
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: AppColors.grey,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }

              final runtime = movie.runtime != null
                  ? '${movie.runtime! ~/ 60}h${movie.runtime! % 60}m'
                  : '';
              final genres = movie.genres?.map((g) => g.name).join(', ') ?? '';
              return Text(
                genres.isNotEmpty ? "$runtime • $genres" : runtime,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: AppColors.grey,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              );
            },
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.images.general.star.svg(),
            Gap.w4,
            Text(
              (movieData.voteAverage ?? "").toString(),
              style: context.textTheme.titleMedium,
            ),
            Gap.w4,
            Text(
              '(${(movieData.voteCount ?? "").toString()})',
              style: context.textTheme.bodySmall?.copyWith(
                color: AppColors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CarouselIndicator extends StatelessWidget {
  const CarouselIndicator({
    super.key,
    required this.currentPage,
    required this.itemCount,
  });

  final int currentPage;
  final int itemCount;

  static const double _width = 60;
  static const double _height = 8;
  static const Duration _duration = Duration(milliseconds: 250);

  @override
  Widget build(BuildContext context) {
    final itemWidth = _width / itemCount;

    return SizedBox(
      width: _width,
      height: _height,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.indicatorBg,
              borderRadius: BorderRadius.circular(72),
            ),
          ),
          AnimatedPositioned(
            duration: _duration,
            left: currentPage * itemWidth,
            child: Container(
              width: itemWidth,
              height: _height,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(72),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
