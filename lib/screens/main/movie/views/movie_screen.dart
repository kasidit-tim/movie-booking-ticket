import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_booking_ticket/core/theme/app_colors.dart';
import 'package:movie_booking_ticket/core/theme/app_spacing.dart';
import 'package:movie_booking_ticket/core/widgets/movie_card.dart';
import 'package:movie_booking_ticket/screens/main/movie/bloc/movie_bloc.dart';
import 'package:movie_booking_ticket/screens/main/movie/views/widgets/movie_tab_button.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Gap.h16,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.card,
                ),
                child: BlocBuilder<MovieBloc, MovieState>(
                  buildWhen: (previous, current) => previous.tab != current.tab,
                  builder: (context, state) {
                    final bloc = context.read<MovieBloc>();

                    return Row(
                      children: [
                        MovieTabButton(
                          title: 'Now Playing',
                          tab: MovieTab.nowPlaying,
                          isSelected: state.tab == MovieTab.nowPlaying,
                          onTap: () => bloc.add(
                            const ChangeTabEvent(tab: MovieTab.nowPlaying),
                          ),
                        ),
                        MovieTabButton(
                          title: 'Coming Soon',
                          tab: MovieTab.commingSoon,
                          isSelected: state.tab == MovieTab.commingSoon,
                          onTap: () => bloc.add(
                            const ChangeTabEvent(tab: MovieTab.commingSoon),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Gap.h32,
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: 10,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 24,
                  childAspectRatio: 0.44,
                ),
                itemBuilder: (context, i) {
                  return MovieCard();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
