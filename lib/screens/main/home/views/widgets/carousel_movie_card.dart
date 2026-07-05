import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_ticket/core/theme/app_colors.dart';
import 'package:movie_booking_ticket/core/theme/app_spacing.dart';
import 'package:movie_booking_ticket/core/theme/app_text_styles.dart';
import 'package:movie_booking_ticket/gen/assets.gen.dart';

class CarouselMovieCard extends StatefulWidget {
  const CarouselMovieCard({super.key});

  @override
  State<CarouselMovieCard> createState() => _CarouselMovieCardState();
}

class _CarouselMovieCardState extends State<CarouselMovieCard> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: 5,
          itemBuilder: (context, i, realIndex) {
            final isCenter = _currentPage == i;
            return GestureDetector(
              onTap: () {
                debugPrint("====> carousel $i");
              },
              child: Stack(
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl:
                          "https://m.media-amazon.com/images/I/71eHZFw+GlL._AC_UF894,1000_QL80_.jpg",
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
              setState(() {
                _currentPage = index;
              });
            },
            enlargeCenterPage: true,
            enlargeFactor: 0.25,
            viewportFraction: 0.65,
          ),
        ),
        Gap.h16,
        Column(
          children: [
            Text(
              "Avengers - Infinity War",
              style: context.textTheme.headlineSmall,
            ),
            Text(
              "2h29m • Action, adventure, sci-fi",
              style: context.textTheme.bodyLarge?.copyWith(
                color: AppColors.grey,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Assets.images.general.star.svg(),
                Gap.w4,
                Text("4.8", style: context.textTheme.titleMedium),
                Gap.w4,
                Text(
                  "(1.222)",
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        CarouselIndicator(currentPage: _currentPage, itemCount: 5),
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
