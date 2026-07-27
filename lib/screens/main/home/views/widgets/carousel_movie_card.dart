import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_booking_ticket/core/constants/app_constants.dart';
import 'package:movie_booking_ticket/core/routes/app_routes.dart';
import 'package:movie_booking_ticket/screens/movie_detail/data/movie_detail_args.dart';
import 'package:movie_booking_ticket/core/theme/app_colors.dart';
import 'package:movie_booking_ticket/core/theme/app_spacing.dart';
import 'package:movie_booking_ticket/core/theme/app_text_styles.dart';
import 'package:movie_booking_ticket/gen/assets.gen.dart';
import 'package:movie_booking_ticket/models/movie/movie_data.dart';
import 'package:movie_booking_ticket/screens/main/bloc/main_bloc.dart';
import 'package:movie_booking_ticket/screens/main/home/bloc/home_bloc.dart';
import 'package:movie_booking_ticket/screens/main/home/views/widgets/home_section.dart';
import 'package:movie_booking_ticket/screens/main/movie/bloc/movie_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CarouselMovieCard extends StatefulWidget {
  const CarouselMovieCard({super.key});

  @override
  State<CarouselMovieCard> createState() => _CarouselMovieCardState();
}

class _CarouselMovieCardState extends State<CarouselMovieCard> {
  int _currentPage = 0;

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
            MovieCarouselSkeleton(),
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
      onSeeAll: () {
        final mainBloc = context.read<MainBloc>();
        mainBloc.add(NavigateToTabEvent(page: PageTab.movie));

        final movieBloc = context.read<MovieBloc>();
        movieBloc.add(ChangeTabEvent(tab: MovieTab.nowPlaying));
      },
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

  Widget _buildCarousel(List<MovieDataModel> movieDataList) {
    final width = MediaQuery.sizeOf(context).width;
    final isFoldOrTablet = width > 700;
    return CarouselSlider.builder(
      itemCount: movieDataList.length,
      itemBuilder: (context, i, _) {
        final isCenter = _currentPage == i;
        final movie = movieDataList[i];
        return GestureDetector(
          onTap: () {
            context.push(
              '${AppRoutes.movieDetail}/${movie.id}',
              extra: const MovieDetailArgs(isComingSoon: false),
            );
          },
          child: Stack(
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: CachedNetworkImage(
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  imageUrl: "${AppConstants.imageW500}${movie.posterPath}",
                  placeholder: (context, url) => Container(
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(16),
                    ),
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
        clipBehavior: Clip.hardEdge,
        aspectRatio: isFoldOrTablet ? 2.1 : 1,
        initialPage: _currentPage,
        onPageChanged: (index, reason) {
          setState(() => _currentPage = index);
        },
        enlargeCenterPage: true,
        enlargeFactor: 0.25,
        viewportFraction: isFoldOrTablet ? 0.35 : 0.65,
      ),
    );
  }

  Widget _buildMovieInfo(MovieDataModel movieData) {
    return Column(
      children: [
        Text(movieData.title ?? "", style: context.textTheme.headlineSmall),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            "${movieData.shortRunTime} • ${movieData.getGenres}",
            style: context.textTheme.bodyLarge?.copyWith(color: AppColors.grey),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
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

class MovieCarouselSkeleton extends StatelessWidget {
  const MovieCarouselSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: CarouselSlider.builder(
        itemCount: 5,
        itemBuilder: (ctx, i, _) {
          return Bone(
            width: double.infinity,
            height: double.infinity,
            borderRadius: BorderRadius.circular(16),
          );
        },
        options: CarouselOptions(
          aspectRatio: 1,
          enlargeCenterPage: true,
          enlargeFactor: 0.25,
          viewportFraction: 0.65,
        ),
      ),
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
