import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_booking_ticket/core/routes/app_routes.dart';
import 'package:movie_booking_ticket/core/widgets/bottom_nav_button.dart';
import 'package:movie_booking_ticket/models/booking_data.dart';
import 'package:movie_booking_ticket/screens/movie_detail/bloc/movie_detail_bloc.dart';
import 'package:movie_booking_ticket/screens/movie_detail/data/movie_detail_skeleton.dart';
import 'package:movie_booking_ticket/screens/movie_detail/views/widgets/movie_detail_app_bar.dart';
import 'package:movie_booking_ticket/screens/movie_detail/views/widgets/movie_detail_content.dart';
import 'package:movie_booking_ticket/screens/movie_detail/views/widgets/movie_info_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({super.key, this.isComingSoon = false});

  final bool isComingSoon;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailBloc, MovieDetailState>(
      buildWhen: (prev, curr) {
        return prev.isLoading != curr.isLoading;
      },
      builder: (context, state) {
        if (!state.isLoading && state.detail == null) {
          return const Scaffold(body: SizedBox());
        }

        final movie = state.isLoading ? kSkeletonMovie : state.detail;

        return Scaffold(
          extendBodyBehindAppBar: true,
          body: CustomScrollView(
            slivers: [
              MovieDetailAppBar(
                isLoading: state.isLoading,
                posterUrl: movie?.getPosterImgW500,
                infoCard: MovieInfoCard(movie: movie),
              ),
              SliverToBoxAdapter(
                child: Skeletonizer(
                  enabled: state.isLoading,
                  child: MovieDetailContent(
                    movie: movie,
                    isComingSoon: isComingSoon,
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: isComingSoon
              ? const SizedBox.shrink()
              : Skeletonizer(
                  enabled: state.isLoading,
                  child: MainBottomNavButton(
                    label: 'Continue',
                    onPressed: () {
                      final currentState = context
                          .read<MovieDetailBloc>()
                          .state;

                      final booking = BookingData(
                        movie: currentState.detail!,
                        cinema: currentState.selectedCinema!,
                      );
                      context.push(AppRoutes.selectSeat, extra: booking);
                    },
                  ),
                ),
        );
      },
    );
  }
}
