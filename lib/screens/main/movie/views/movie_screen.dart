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
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    final bloc = context.read<MovieBloc>();
    _pageController = PageController(initialPage: bloc.state.tab.index);
    bloc.add(LoadMoviesEvent(tab: bloc.state.tab));
  }

  void _onTabChanged(MovieTab tab) {
    final bloc = context.read<MovieBloc>();
    bloc.add(ChangeTabEvent(tab: tab));
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
              child: BlocListener<MovieBloc, MovieState>(
                listenWhen: (prev, curr) {
                  return prev.tab != curr.tab;
                },
                listener: (context, state) {
                  _pageController.animateToPage(
                    state.tab.index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );

                  final bloc = context.read<MovieBloc>();
                  bloc.add(LoadMoviesEvent(tab: state.tab));
                },
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  children: [
                    MovieListPage(tab: MovieTab.nowPlaying),
                    MovieListPage(tab: MovieTab.comingSoon),
                  ],
                ),
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
            return Row(
              children: [
                MovieTabButton(
                  title: 'Now Playing',
                  tab: MovieTab.nowPlaying,
                  isSelected: state.tab == MovieTab.nowPlaying,
                  onTap: () {
                    if (state.tab == MovieTab.nowPlaying) return;
                    _onTabChanged(MovieTab.nowPlaying);
                  },
                ),
                MovieTabButton(
                  title: 'Coming Soon',
                  tab: MovieTab.comingSoon,
                  isSelected: state.tab == MovieTab.comingSoon,
                  onTap: () {
                    if (state.tab == MovieTab.comingSoon) return;
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
