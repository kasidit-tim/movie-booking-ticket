import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_booking_ticket/core/routes/app_routes.dart';
import 'package:movie_booking_ticket/core/widgets/bottom_nav_button.dart';
import 'package:movie_booking_ticket/models/booking_data.dart';
import 'package:movie_booking_ticket/screens/movie_detail/bloc/movie_detail_bloc.dart';
import 'package:movie_booking_ticket/screens/movie_detail/views/widgets/movie_detail_app_bar.dart';
import 'package:movie_booking_ticket/screens/movie_detail/views/widgets/movie_detail_content.dart';
import 'package:movie_booking_ticket/screens/movie_detail/views/widgets/movie_info_card.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailBloc, MovieDetailState>(
      buildWhen: (prev, curr) {
        return prev.isLoading != curr.isLoading;
      },
      builder: (context, state) {
        final movie = state.detail;

        if (state.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (movie == null) {
          return Scaffold(body: SizedBox());
        }

        return Scaffold(
          extendBodyBehindAppBar: true,
          body: CustomScrollView(
            slivers: [
              MovieDetailAppBar(
                posterUrl: movie.getPosterImgW500,
                onBackPressed: () => Navigator.of(context).pop(),
                infoCard: const MovieInfoCard(),
              ),
              SliverToBoxAdapter(child: MovieDetailContent(movie: movie)),
            ],
          ),
          bottomNavigationBar: MainBottomNavButton(
            label: 'Continue',
            onPressed: () {
              final currentState = context.read<MovieDetailBloc>().state;

              final booking = BookingData(
                movie: currentState.detail!,
                cinema: currentState.selectedCinema!,
              );
              context.push(AppRoutes.selectSeat, extra: booking);
            },
          ),
        );
      },
    );
  }
}
