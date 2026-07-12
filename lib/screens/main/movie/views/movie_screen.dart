import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_booking_ticket/core/theme/app_colors.dart';
import 'package:movie_booking_ticket/core/theme/app_spacing.dart';
import 'package:movie_booking_ticket/screens/main/movie/bloc/movie_bloc.dart';
import 'package:movie_booking_ticket/screens/main/movie/views/widgets/movie_list_page.dart';
import 'package:movie_booking_ticket/screens/main/movie/views/widgets/movie_tab_button.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  final _pageController = PageController();

  void _onTabChanged(MovieTab tab) {
    _pageController.animateToPage(
      tab == MovieTab.nowPlaying ? 0 : 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Gap.h16,
            _buildTabBar(),
            Gap.h32,
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                children: [
                  MovieListPage(tab: MovieTab.nowPlaying),
                  MovieListPage(tab: MovieTab.comingSoon),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.card,
        ),
        child: BlocBuilder<MovieBloc, MovieState>(
          buildWhen: (prev, curr) => prev.tab != curr.tab,
          builder: (context, state) {
            final bloc = context.read<MovieBloc>();
            return Row(
              children: [
                MovieTabButton(
                  title: 'Now Playing',
                  tab: MovieTab.nowPlaying,
                  isSelected: state.tab == MovieTab.nowPlaying,
                  onTap: () {
                    bloc.add(const ChangeTabEvent(tab: MovieTab.nowPlaying));
                    _onTabChanged(MovieTab.nowPlaying);
                  },
                ),
                MovieTabButton(
                  title: 'Coming Soon',
                  tab: MovieTab.comingSoon,
                  isSelected: state.tab == MovieTab.comingSoon,
                  onTap: () {
                    bloc.add(const ChangeTabEvent(tab: MovieTab.comingSoon));
                    _onTabChanged(MovieTab.comingSoon);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
